local WALK_SPEED = 4
local RUN_SPEED = 7

require("stategraphs/commonstates")

local actionhandlers = 
{
    ActionHandler(ACTIONS.EAT, "eat"),
    ActionHandler(ACTIONS.HARVEST, "farm"),
    ActionHandler(ACTIONS.GOHOME, "action"),
    ActionHandler(ACTIONS.PICKUP, "pickup"),
    ActionHandler(ACTIONS.GOHOME, "ascendtree"),
}

local events =
{
    CommonHandlers.OnSleep(),
    CommonHandlers.OnFreeze(),
    EventHandler("attacked", function(inst) if inst.components.health:GetPercent() > 0 then inst.sg:GoToState("hit") end end),
    EventHandler("doattack", function(inst, data) if not inst.components.health:IsDead() and (inst.sg:HasStateTag("hit") or not inst.sg:HasStateTag("busy")) then inst.sg:GoToState("attack", data.target) end end),
    EventHandler("death", function(inst) inst.sg:GoToState("death") end),
    EventHandler("trapped", function(inst) inst.sg:GoToState("trapped") end),
    EventHandler("locomote", 
        function(inst) 
            if not inst.sg:HasStateTag("idle") and not inst.sg:HasStateTag("moving") then return end
            
            if not inst.components.locomotor:WantsToMoveForward() then
                if not inst.sg:HasStateTag("idle") then
                    if not inst.sg:HasStateTag("running") then
                        inst.sg:GoToState("idle")
                    end
                    inst.sg:GoToState("idle")
                end
            elseif inst.components.locomotor:WantsToRun() then
                if not inst.sg:HasStateTag("running") then
                    inst.sg:GoToState("run")
                end
            else
                if not inst.sg:HasStateTag("hopping") then
                    inst.sg:GoToState("hop")
                end
            end
        end),
}

local states =
{
    State
    {
        name = "look",
        tags = {"idle", "canrotate" },

        onenter = function(inst)
            inst.lookingup = nil
            inst.donelooking = nil
            
            if math.random() > .5 then
                inst.AnimState:PlayAnimation("lookup_pre")
                inst.AnimState:PushAnimation("lookup_loop", true)
                inst.lookingup = true
            else
                inst.AnimState:PlayAnimation("lookdown_pre")
                inst.AnimState:PushAnimation("lookdown_loop", true)
            end
            
            inst.sg:SetTimeout(1 + math.random()*1)
        end,
        
        ontimeout = function(inst)
            inst.donelooking = true
            if inst.lookingup then
                inst.AnimState:PlayAnimation("lookup_pst")
            else
                inst.AnimState:PlayAnimation("lookdown_pst")
            end
        end,
        
        events =
        {
            EventHandler("animover", function(inst, data)
                if inst.donelooking then
                    inst.sg:GoToState("idle")
                end
            end),
        }
    },

    State
    {
        name = "idle",
        tags = {"idle", "canrotate"},

        timeline = 
        {
            TimeEvent(16*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/piko/idle") end),
            TimeEvent(18*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/piko/idle") end),
            TimeEvent(20*FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/piko/idle") end),
        },

        onenter = function(inst, playanim)
            inst.Physics:Stop()
            if playanim then
                inst.AnimState:PlayAnimation(playanim)
                inst.AnimState:PushAnimation("idle", true)
            else
                inst.AnimState:PlayAnimation("idle", true)
            end                                
            inst.sg:SetTimeout(1 + math.random()*1)
        end,
        
        ontimeout= function(inst)
           -- inst.sg:GoToState("look")
        end,
    },

    State
    {
        name = "attack",
        tags = {"attack", "notalking", "abouttoattack", "busy"},
        
        onenter = function(inst, cb)
            inst.Physics:Stop()
			inst.sg.statemem.target = inst.components.combat.target
            inst.components.combat:StartAttack()
            inst.AnimState:PlayAnimation("attack")
		if inst.components.combat.target then
                if inst.components.combat.target and inst.components.combat.target:IsValid() then
                    inst:FacePoint(Point(inst.components.combat.target.Transform:GetWorldPosition()))
                end
            end
        end,

        timeline =
        {
			TimeEvent(2*FRAMES, function(inst) 
				inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/piko/attack") 
				end),
            TimeEvent(10*FRAMES, function(inst) 
				inst.components.combat:DoAttack(inst.sg.statemem.target) 
				inst.sg:RemoveStateTag("abouttoattack") 
			end),
            TimeEvent(12*FRAMES, function(inst) 
                inst.sg:RemoveStateTag("busy")
			end),
			TimeEvent(13*FRAMES, function(inst)
                if not inst.sg.statemem.slow then
                    inst.sg:RemoveStateTag("attack")
                end
            end),
            TimeEvent(24*FRAMES, function(inst)
                if inst.sg.statemem.slow then
                    inst.sg:RemoveStateTag("attack")
                end
            end),  
        },

        events =
        {
            EventHandler("animover", function(inst, data) 
				inst.sg:GoToState("idle")
			end),
        },
    },

    State
    {
        name = "action",

        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle")
            inst:PerformBufferedAction()
			local piko2nd = inst:CanMorph()
			if not (piko2nd) then
			inst.sg:GoToState("idle")
                return
            end
            inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/raise")
        end,
        onexit = function(inst)

        end,
        timeline = 
        {
            TimeEvent(3*FRAMES, function(inst) 
                local fireFX = SpawnPrefab("sand_puff")
				local smokeFX = SpawnPrefab("chester_transform_fx")
				local smokeFX2 = SpawnPrefab("collapse_small")
                --local sparkleFX = SpawnPrefab("sparklefx")
                local pos = inst:GetPosition()
				fireFX.Transform:SetPosition(pos:Get())
                smokeFX.Transform:SetPosition(pos:Get())
				smokeFX2.Transform:SetPosition(pos:Get())
                --sparkleFX.Transform:SetPosition(pos:Get())
            end),
            TimeEvent(3*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/chester/pop")
                inst:MorphPiko()
            end),
        },
        events =
        {
            EventHandler("animqueueover", function(inst, data) inst.sg:GoToState("idle") end),
        }
    },

    State
    {
        name = "ascendtree",

        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("climbuptree")
        end,

        events =
        {
            EventHandler("animover", function(inst, data)
                 inst:PerformBufferedAction()
                 inst.sg:GoToState("idle") 
                 end),
        }
    },

    State
    {
        name = "descendtree",

        onenter = function(inst, playanim)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("climbdowntree")
        end,

        events =
        {
            EventHandler("animover", function(inst, data)
                 inst.sg:GoToState("idle") 
                 end),
        }
    },

    State
    {
        name = "eat",
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat_pre", false)
            inst.AnimState:PushAnimation("eat_loop", true)
            inst.sg:SetTimeout(2+math.random()*4)
        end,
        
        ontimeout = function(inst)
            inst:PerformBufferedAction()
            inst.sg:GoToState("idle", "eat_pst")
        end,
    },
	
    State
    {
        name = "farm",
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat_pre", false)
            inst.AnimState:PushAnimation("eat_loop", true)
            inst.sg:SetTimeout(2)
        end,
        
        ontimeout = function(inst)
            inst:PerformBufferedAction()
            inst.sg:GoToState("idle", "eat_pst")
        end,
		events=
        {
            EventHandler("animover", function (inst)
            --    inst.sg:GoToState("idle")
            end),
        }
    },

    State
    {
        name = "pickup",
        { "doing", "busy" },
        onenter = function(inst)
            inst.Physics:Stop()
			inst.components.sleeper:WakeUp()
            inst.AnimState:PlayAnimation("eat_pre", false)
            inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/piko/steal")
			inst.sg.statemem.action = inst.bufferedaction
			inst.sg:SetTimeout(4 * FRAMES)
		end,
        timeline =
        {
			TimeEvent(1 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
			TimeEvent(2 * FRAMES, function(inst)
			inst:PerformBufferedAction()
                if inst.sg.statemem.action ~= nil then
                    local target = inst.sg.statemem.action.target
					--[[
                    if target.components.inventoryitem then
						if target then
							if inst.components.container then
								--inst.components.container:GiveItem(target)
							end
						end
                    end
					]]
                end
            end),
		},
		ontimeout = function(inst)
				--inst.sg:GoToState("idle")
		end,
		onexit = function(inst)
            if inst.bufferedaction == inst.sg.statemem.action then
                inst:ClearBufferedAction()
            end
        end,
	events =
	{
		EventHandler("animover", function(inst, data) 
				inst:PerformBufferedAction() 
				inst.sg:GoToState("pickup_pst")
			end),
        }
    },
    State
    {
        name = "pickup_pst",
        
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("eat_pst", false)
        end,
        
        events =
        {
            EventHandler("animover", function(inst, data) inst.sg:GoToState("idle") end),
        }
    },

    State
    {
        name = "hop",
        tags = {"moving", "canrotate", "hopping"},
        
        timeline =
        {
            TimeEvent(5*FRAMES, function(inst) 
                inst.Physics:Stop() 
                inst.SoundEmitter:PlaySound("dontstarve/rabbit/hop")
            end ),
        },
        
        onenter = function(inst) 
            inst.AnimState:PlayAnimation("walk")
            inst.components.locomotor:WalkForward()
            inst.sg:SetTimeout(2*math.random()+0.5)
        end,
        
        onupdate = function(inst)
            if not inst.components.locomotor:WantsToMoveForward() then
                inst.sg:GoToState("idle")
            end
        end,        
        
        ontimeout = function(inst)
            inst.sg:GoToState("hop")
        end,
    },

    State
    {
        name = "run",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst) 
            inst.AnimState:PlayAnimation("run_pre")
            inst.AnimState:PushAnimation("run", true)
            inst.components.locomotor:RunForward()
        end,

        onupdate = function(inst)
            if inst.components.locomotor:GetRunSpeed() > 0.0 then
                inst.components.locomotor:RunForward()
            end
        end,   
    },

    State
    {
        name = "death",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/piko/death")
            inst.AnimState:PlayAnimation("death")
            inst.Physics:Stop()
        end,
		events =
        {
            EventHandler("animover", function(inst)
                inst:DoTaskInTime(1, function() 
                    SpawnPrefab("sand_puff").Transform:SetPosition(inst:GetPosition():Get())
                    inst:Remove()
                end)
            end),
        },
    },

    State
    {
        name = "fall",
        tags = {"busy", "stunned"},

        onenter = function(inst)
            inst.AnimState:PlayAnimation("stunned_loop", true)
        end,
        
        onupdate = function(inst)

                inst.sg:GoToState("stunned")
        end,

        onexit = function(inst)

        end,
    },

    State
    {
        name = "stunned",
        tags = {"busy", "stunned"},
        
        onenter = function(inst) 
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("stunned_loop", true)
            --inst.sg:SetTimeout(6)
        end,
        
        onexit = function(inst)

        end,
        
        ontimeout = function(inst) 
			--inst.sg:GoToState("idle") 
		end,
    },

    State
    {
        name = "trapped",
        tags = {"busy", "trapped"},
        
        onenter = function(inst) 
            inst.Physics:Stop()
			inst:ClearBufferedAction()
            inst.AnimState:PlayAnimation("stunned_loop", true)
            inst.sg:SetTimeout(1)
        end,
        
        ontimeout = function(inst) inst.sg:GoToState("idle") end,
    },

    State
    {
        name = "hit",
        tags = {"busy"},
        
        onenter = function(inst)
            inst.SoundEmitter:PlaySound("dontstarve_DLC003/creatures/piko/scream")
            inst.AnimState:PlayAnimation("hit")
            inst.Physics:Stop()            
        end,

        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },        
    },
	State {
        name = "sleep",
        tags = { "sleeping", "busy" }, 
        onenter = function(inst)
		if inst.components.locomotor ~= nil then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("sleep_pre")
        end,
        timeline = 
		{
		},
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("sleeping") end ),
            EventHandler("onwakeup", function(inst) inst.sg:GoToState("wake") end),
        },
    },
	State
    {
        name = "sleeping",
        tags = { "sleeping", "busy" },
		onenter = function(inst)
				inst.components.locomotor:StopMoving()
				inst.AnimState:PlayAnimation("sleep_loop")
		end,
		onexit = function(inst)
		end,
		timeline=
        {
        },
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("sleeping") end ),
			EventHandler("onwakeup", function(inst) inst.sg:GoToState("wake") end),
        },
    },
	State
    {
        name = "wake",
        tags = { "busy", "waking" },
        onenter = function(inst)
            if inst.components.locomotor ~= nil then
                inst.components.locomotor:StopMoving()
            end
            inst.AnimState:PlayAnimation("sleep_pst")
            if inst.components.sleeper ~= nil and inst.components.sleeper:IsAsleep() then
                inst.components.sleeper:WakeUp()
            end
        end,
        events =
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
    },
}

return StateGraph("SGpikosch", states, events, "idle", actionhandlers)

