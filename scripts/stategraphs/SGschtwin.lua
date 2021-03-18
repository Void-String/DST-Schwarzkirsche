require("stategraphs/commonstates")
local function DoFoleySounds(inst)
	--for k,v in pairs(inst.components.inventory.equipslots) do
	--	if v.components.inventoryitem and v.components.inventoryitem.foleysound then
		--	inst.SoundEmitter:PlaySound(v.components.inventoryitem.foleysound)
	--	end
	--end
end

local actionhandlers =
{    
    ActionHandler(ACTIONS.CHOP, 
        function(inst)
            if not inst.sg:HasStateTag("prechop") then 
                if inst.sg:HasStateTag("chopping") then
                    return "chop"
                else
                    return "chop_start"
                end
            end 
        end),
    ActionHandler(ACTIONS.MINE, 
        function(inst) 
            if not inst.sg:HasStateTag("premine") then 
                if inst.sg:HasStateTag("mining") then
                    return "mine"
                else
                    return "mine_start"
                end
            end 
        end),
		    ActionHandler(ACTIONS.SLEEPIN, 
		function(inst, action)
			if action.invobject then
                if action.invobject.onuse then
                    action.invobject.onuse()
                end
				return "bedroll"
			else
				return "doshortaction"
			end
		
		end),
		ActionHandler(ACTIONS.EAT, 
        function(inst, action)
            if inst.sg:HasStateTag("busy") then
                return nil
            end
            local obj = action.target or action.invobject
            if not (obj and obj.components.edible) then
                return nil
            end
            
            if inst.components.eater:CanEat(obj) and obj.components.edible.foodtype == "MEAT" and not obj.components.edible.forcequickeat then
                return "eat"
            elseif inst.components.eater:CanEat(obj) then
                return "quickeat"
            else
                inst:PushEvent("canteatfood", {food = obj})
                return nil
            end
        end),
}

local events = 
{
    CommonHandlers.OnLocomote(true, false),
    CommonHandlers.OnDeath(),
    CommonHandlers.OnAttack(),

	EventHandler("attacked", function(inst)
	if not inst.components.health:IsDead() and not inst.hide then
            inst.sg:GoToState("hit")
        end
    end),
	
	EventHandler("ontalk", function(inst, data)
	if inst.sg:HasStateTag("idle") then
		if inst.prefab == "wes" then
		   inst.sg:GoToState("mime")
		else
			inst.sg:GoToState("talk", data.noanim)
		end
	end
	end),

	EventHandler("wakeup",
        function(inst)
            inst.sg:GoToState("wakeup")
        end),  

	EventHandler("knockedout",
        function(inst)
            if inst.sg:HasStateTag("knockout") then
                inst.sg.statemem.cometo = nil
            elseif not (inst.sg:HasStateTag("sleeping") or inst.sg:HasStateTag("bedroll") or inst.sg:HasStateTag("tent") or inst.sg:HasStateTag("waking")) then
                inst.sg:GoToState("knockout")
            end
        end),		
}

local states =
{

		State{
        name = "idle",
        tags = {"idle", "canrotate"},
        onenter = function(inst, pushanim)    
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_loop", true)
        end,
		},
	
		State{
        name = "eat",
        tags ={"busy"},
        onenter = function(inst)
		
		inst.components.locomotor:Stop()
		inst.SoundEmitter:PlaySound("dontstarve/wilson/eat", "eating")    
        inst.AnimState:PlayAnimation("eat")
		
		if inst.components.hunger then
			inst.components.hunger:Pause()
		end
		
		end,

        timeline=
        {
            TimeEvent(28*FRAMES, function(inst) 
                inst:PerformBufferedAction() 
            end),
            TimeEvent(30*FRAMES, function(inst) 
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(70*FRAMES, function(inst) 
	            inst.SoundEmitter:KillSound("eating")    
	        end),
        },        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
        
        onexit= function(inst)
            inst.SoundEmitter:KillSound("eating") 
			if inst.components.hunger then
				inst.components.hunger:Resume()
			end
        end,
		},    
    
		State{
        name = "quickeat",
        tags ={"busy"},
        onenter = function(inst)
		
		inst.components.locomotor:Stop()
		inst.SoundEmitter:PlaySound("dontstarve/wilson/eat", "eating")    

        inst.AnimState:PlayAnimation("quick_eat")
		
		if inst.components.hunger then
			inst.components.hunger:Pause()
		end
		
        end,

        timeline=
        {
            TimeEvent(12*FRAMES, function(inst) 
                inst:PerformBufferedAction() 
                inst.sg:RemoveStateTag("busy")
            end),
        },        
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },
        
        onexit= function(inst)
		
		inst.SoundEmitter:KillSound("eating")
		
		if inst.components.hunger then
            inst.components.hunger:Resume()
		end
		
        end,
		},   
		
		State{
        name = "talk",
        tags = {"idle", "talking"},

        onenter = function(inst, noanim)
            inst.components.locomotor:Stop()
            if not noanim then
                inst.AnimState:PlayAnimation("dial_loop", true)
            end
			if inst.talksoundoverride then
                inst.SoundEmitter:PlaySound(inst.talksoundoverride, "talk")
            else
                inst.SoundEmitter:PlaySound("dontstarve/characters/wilson/talk_LP", "talk")
            end
            inst.sg:SetTimeout(1.5 + math.random()*.5)
        end,
        
        ontimeout = function(inst)
            inst.SoundEmitter:KillSound("talk")
            inst.sg:GoToState("idle")
        end,
        
        onexit = function(inst)
            inst.SoundEmitter:KillSound("talk")
        end,
        
        events=
        {
            EventHandler("donetalking", function(inst) inst.sg:GoToState("idle") end),
        },
		}, 
	
		State{
        name = "run_start",
        tags = {"moving", "running", "canrotate"},
        
        onenter = function(inst)
			inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("run_pre")
            inst.sg.mem.foosteps = 0
        end,

        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,

        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
        },
        
        timeline=
        {        
            TimeEvent(4*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_step")
			end),
        },        
        
		},

		State{
        name = "run_stop",
        tags = {"canrotate", "idle"},
        onenter = function(inst) 
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("run_pst")
        end,
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),        
        },
		},

		State{
        name = "run",
        tags = {"moving", "running", "canrotate"},
        onenter = function(inst) 
            inst.components.locomotor:RunForward()
            inst.AnimState:PlayAnimation("run_loop")
        end,
        onupdate = function(inst)
            inst.components.locomotor:RunForward()
        end,
        timeline=
        {
            TimeEvent(7*FRAMES, function(inst)
				inst.sg.mem.foosteps = inst.sg.mem.foosteps + 1
            end),
            TimeEvent(15*FRAMES, function(inst)
				inst.sg.mem.foosteps = inst.sg.mem.foosteps + 1
                inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_step")
            end),
        },
        
        events=
        {   
            EventHandler("animover", function(inst) inst.sg:GoToState("run") end ),        
        },
		},
		
		State{
        name = "attack",
        tags = {"attack", "notalking", "abouttoattack", "busy"},
		onenter = function(inst)
		
		inst.equipfn(inst, inst.items["SWORD"])
		inst.Physics:Stop()
		inst.sg.statemem.target = inst.components.combat.target
		inst.components.combat:StartAttack()
		inst.AnimState:PlayAnimation("atk")
		inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_nightsword")
            
		if inst.components.combat.target then
			if inst.components.combat.target and inst.components.combat.target:IsValid() then
				inst:FacePoint(Point(inst.components.combat.target.Transform:GetWorldPosition()))
			end
		end
		
        end,
        timeline=
        {
            TimeEvent(8*FRAMES, function(inst) inst.components.combat:DoAttack(inst.sg.statemem.target) inst.sg:RemoveStateTag("abouttoattack") end),
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
        events=
        {
            EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end ),
        },
		},  
		
		State{
        name = "death",
        tags = {"busy"},
        onenter = function(inst)
            inst.Physics:Stop()
            inst.AnimState:Hide("swap_arm_carry")
            inst.AnimState:PlayAnimation("death")
        end,
        events =
        {
            EventHandler("animover", function(inst)
                inst:DoTaskInTime(1, function() 
                    SpawnPrefab("collapse_small").Transform:SetPosition(inst:GetPosition():Get())
                    SpawnPrefab("chester_transform_fx").Transform:SetPosition(inst:GetPosition():Get())
                    inst.SoundEmitter:PlaySound("dontstarve/maxwell/shadowmax_despawn")
                    inst:Remove()
                end)
            end ),
        },
		},  
		
		State{
        name = "bedroll",
		tags = { "busy" },
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("bedroll", false)
        end,
        timeline =
        {
            TimeEvent(20 * FRAMES, function(inst) 
                inst.SoundEmitter:PlaySound("dontstarve/wilson/use_bedroll")
            end),
        },
        events =
        {
            EventHandler("firedamage", function(inst)
                if inst.sg:HasStateTag("sleeping") then
                    inst.sg.statemem.iswaking = true
                    inst.sg:GoToState("wakeup")
				end
            end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    if (inst.components.health ~= nil and inst.components.health.takingfiredamage) or
                        (inst.components.burnable ~= nil and inst.components.burnable:IsBurning()) then
                        inst:PushEvent("performaction", { action = inst.bufferedaction })
                        inst:ClearBufferedAction()
                        inst.sg.statemem.iswaking = true
                        inst.sg:GoToState("wakeup")
                    elseif inst:GetBufferedAction() then
                        inst:PerformBufferedAction() 
                        if inst.components.playercontroller ~= nil then
                        end
                        inst.sg:AddStateTag("sleeping")
                        inst.sg:AddStateTag("silentmorph")
                        inst.sg:RemoveStateTag("nomorph")
                        inst.sg:RemoveStateTag("busy")
                        inst.AnimState:PlayAnimation("bedroll_sleep_loop", true)
                    else
						inst.AnimState:PlayAnimation("bedroll_sleep_loop", true)
                    end
                end
            end),
        },
        onexit = function(inst)
            if inst.sleepingbag ~= nil then
                inst.sleepingbag.components.sleepingbag:DoWakeUp(true)
                inst.sleepingbag = nil
            elseif not inst.sg.statemem.iswaking then
            end
        end,
		},

		State{
        name = "knockout",
        tags = { "busy", "knockout", "nopredict", "nomorph" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()
            inst.sg.statemem.isinsomniac = inst:HasTag("insomniac")
            if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
                inst.sg:AddStateTag("dismounting")
                inst.AnimState:PlayAnimation("fall_off")
                inst.SoundEmitter:PlaySound("dontstarve/beefalo/saddle/dismount")
            else
                inst.AnimState:PlayAnimation(inst.sg.statemem.isinsomniac and "insomniac_dozy" or "dozy")
            end
            inst.sg:SetTimeout(9)
        end,
        ontimeout = function(inst)
            if inst.components.grogginess == nil then
                inst.sg.statemem.iswaking = true
                inst.sg:GoToState("wakeup")
            end
        end,
        events =
        {
            EventHandler("firedamage", function(inst)
                if inst.sg:HasStateTag("sleeping") then
                    inst.sg.statemem.iswaking = true
                    inst.sg:GoToState("wakeup")
                else
                    inst.sg.statemem.cometo = true
                end
            end),
            EventHandler("cometo", function(inst)
                if inst.sg:HasStateTag("sleeping") then
                    inst.sg.statemem.iswaking = true
                    inst.sg:GoToState("wakeup")
                else
                    inst.sg.statemem.cometo = true
                end
            end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    if inst.sg:HasStateTag("dismounting") then
                        inst.sg:RemoveStateTag("dismounting")
                        if inst.components.rider ~= nil then
                            inst.components.rider:ActualDismount()
                        end
                        inst.AnimState:PlayAnimation(inst.sg.statemem.isinsomniac and "insomniac_dozy" or "dozy")
                    elseif inst.sg.statemem.cometo then
                        inst.sg.statemem.iswaking = true
                        inst.sg:GoToState("wakeup")
                    else
                        inst.AnimState:PlayAnimation(inst.sg.statemem.isinsomniac and "insomniac_sleep_loop" or "sleep_loop", true)
                        inst.sg:AddStateTag("sleeping")
                    end
                end
            end),
        },
        onexit = function(inst)
            if inst.sg:HasStateTag("dismounting") and inst.components.rider ~= nil then
                inst.components.rider:ActualDismount()
            end
            if not inst.sg.statemem.iswaking then
            end
        end,
		},
		
		State{
        name = "wakeup",
        onenter = function(inst)
        if inst.AnimState:IsCurrentAnimation("bedroll") or
           inst.AnimState:IsCurrentAnimation("bedroll_sleep_loop") then
           inst.AnimState:PlayAnimation("bedroll_wakeup")
        elseif not (inst.AnimState:IsCurrentAnimation("bedroll_wakeup") or
           inst.AnimState:IsCurrentAnimation("wakeup")) then
           inst.AnimState:PlayAnimation("wakeup")
		end
           inst.components.health:SetInvincible(true)
        end,
        
        onexit = function(inst)
            inst.components.health:SetInvincible(false)
        end,

        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end),
        },

		},

		State{
		
        name = "hit",
        tags = {"busy"},
        
        onenter = function(inst)
		inst:ClearBufferedAction()
		inst.AnimState:PlayAnimation("hit")
		inst.Physics:Stop()
		
		inst.SoundEmitter:PlaySound("dontstarve/characters/willow","/hit")   
		inst.SoundEmitter:PlaySound("dontstarve/characters/willow","/hurt")   
		end,
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("idle") end ),
        }, 
        
        timeline =
        {
            TimeEvent(3*FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },               
		},

		State{
        name = "stunned",
        tags = {"busy", "canrotate"},

        onenter = function(inst)
            inst:ClearBufferedAction()
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("idle_sanity_pre")
            inst.AnimState:PushAnimation("idle_sanity_loop", true)
            inst.sg:SetTimeout(5)
        end,

        ontimeout = function(inst)
            inst.sg:GoToState("idle")
        end,
		},

        State{ name = "chop_start",
        tags = {"prechop", "chopping", "working"},
        onenter = function(inst)
		
		inst.equipfn(inst, inst.items["AXE"])
		inst.Physics:Stop()
		inst.AnimState:PlayAnimation("chop_pre")
      
		end,
        
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("chop") end),
        },
		},

		State{
        name = "chop",
        tags = {"prechop", "chopping", "working"},
        onenter = function(inst)
			inst.AnimState:PlayAnimation("chop_loop")        
        end,
        timeline=
        {
            TimeEvent(5*FRAMES, function(inst) 
                    inst:PerformBufferedAction() 
            end),
            TimeEvent(9*FRAMES, function(inst)
                    inst.sg:RemoveStateTag("prechop")
            end),
            TimeEvent(16*FRAMES, function(inst) 
                inst.sg:RemoveStateTag("chopping")
            end),
        },
        events=
        {
            EventHandler("animover", function(inst) 
                inst.sg:GoToState("idle")
            end ),            
        },        
		},

		State{ 
        name = "mine_start",
        tags = {"premine", "working"},
        onenter = function(inst)
            inst.equipfnp(inst, inst.items["PICKAXE"])
            inst.Physics:Stop()
            inst.AnimState:PlayAnimation("pickaxe_pre")
        end,
        events=
        {
            EventHandler("animover", function(inst) inst.sg:GoToState("mine") end),
        },
		},

		State{
        name = "mine",
        tags = {"premine", "mining", "working"},
        onenter = function(inst)
            inst.AnimState:PlayAnimation("pickaxe_loop")
        end,
        timeline=
        {
            TimeEvent(9*FRAMES, function(inst) 
                inst:PerformBufferedAction() 
                inst.sg:RemoveStateTag("premine") 
                inst.SoundEmitter:PlaySound("dontstarve/wilson/use_pick_rock")
            end),
        },
        events=
        {
            EventHandler("animover", function(inst) 
                inst.AnimState:PlayAnimation("pickaxe_pst") 
                inst.sg:GoToState("idle", true)
            end ),            
        },        
		},
		
		State{
        name = "open",
        tags = { "open", "busy", },
        onenter = function(inst)
		
		inst.Physics:Stop()
        inst.AnimState:PlayAnimation("emote_loop_sit4", true)
        
		end,
        timeline=
        {

        },
        events=
        {
            EventHandler("animover", function(inst) 

            end ),            
        },        
		},
}

return StateGraph("schtwin", states, events, "idle", actionhandlers)