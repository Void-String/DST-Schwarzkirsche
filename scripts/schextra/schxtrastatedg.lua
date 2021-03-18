local require = GLOBAL.require
local ACTIONS = GLOBAL.ACTIONS
local TheInput = GLOBAL.TheInput
local ThePlayer = GLOBAL.ThePlayer
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local IsServer = GLOBAL.TheNet:GetIsServer()

	---------------------------[[ Dodge Action ]]----------------------------
-- local SCHDODGE = GLOBAL.Action({}, -5, nil, nil, 2, nil, true) -- dodge not follow the mouse position
local SCHDODGE = GLOBAL.Action({}, -5, nil, nil, 3, nil, true)
SCHDODGE.str = "Dodge"
SCHDODGE.id = "SCHDODGE"
AddAction(SCHDODGE)
AddStategraphEvent("wilson",
	GLOBAL.EventHandler("redirect_locomote", function(inst)
        local bufferedaction = inst:GetBufferedAction()
        if bufferedaction and bufferedaction.action.id == "SCHDODGE" then
            inst.sg:GoToState("dodge")
        end
    end)
)
AddStategraphEvent("wilson", 
	GLOBAL.EventHandler("locomote", function(inst, data)
        if inst.sg:HasStateTag("busy") or inst.sg:HasStateTag("armorbroke") or inst.sg:HasStateTag("toolbroke") or inst.sg:HasStateTag("tool_slip") then
            return
        end
        local is_moving = inst.sg:HasStateTag("moving")
        local should_move = inst.components.locomotor:WantsToMoveForward()
		local bufferedaction = inst:GetBufferedAction()
        if inst.sg:HasStateTag("bedroll") or inst.sg:HasStateTag("tent") or inst.sg:HasStateTag("waking") then -- wakeup on locomote
            if inst.sleepingbag ~= nil and inst.sg:HasStateTag("sleeping") then
                inst.sleepingbag.components.sleepingbag:DoWakeUp()
                inst.sleepingbag = nil
            end
		elseif bufferedaction and bufferedaction.action.id == "SCHDODGE" then
            inst.sg:GoToState("dodge")
        elseif is_moving and not should_move then
            inst.sg:GoToState("run_stop")
        elseif not is_moving and should_move then
            inst.sg:GoToState("run_start")
        elseif data.force_idle_state and not (is_moving or should_move or inst.sg:HasStateTag("idle")) then
            inst.sg:GoToState("idle")
        end
    end)
)
------------------------------[[Met problem when every armorbroke state. the health keep invicible]]-----------------------------
AddStategraphState("wilson", 
	GLOBAL.State 
	{
        name = "dodge",
        tags = {"busy", "evade", "no_stun" },
        onenter = function(inst)
            inst.sg:SetTimeout(0.25) -- 0.15
            inst.components.locomotor:Stop()
			inst.components.schthirsty:DoDelta(-3)
            inst.AnimState:PlayAnimation("slide_pre")
            inst.AnimState:PushAnimation("slide_loop")
            inst.SoundEmitter:PlaySound("dontstarve_DLC003/characters/wheeler/slide")
            inst.Physics:SetMotorVelOverride(25,0,0)
            inst.components.locomotor:EnableGroundSpeedMultiplier(false)
            inst.components.health:SetInvincible(true)
            inst:PerformBufferedAction()
			inst.last_dodge_time = GLOBAL.GetTime()
			inst:AddTag("dodging")
        end,
        ontimeout = function(inst)
            inst.sg:GoToState("dodge_pst")
        end,
        onexit = function(inst)
            inst.components.locomotor:EnableGroundSpeedMultiplier(true)
            inst.Physics:ClearMotorVelOverride()
            inst.components.locomotor:Stop()
        end,        
    } 
)
AddStategraphState("wilson", 
	GLOBAL.State
    {
        name = "dodge_pst",
        tags = {"evade","no_stun"},
        onenter = function(inst)
			inst:RemoveTag("dodging")
            inst.AnimState:PlayAnimation("slide_pst")
            inst.components.locomotor:SetBufferedAction(nil)
			inst.components.health:SetInvincible(false)
        end,
		ontimeout = function(inst)
   			--inst.components.health:SetInvincible(false)
        end,
        onexit = function(inst)
			--inst.components.health:SetInvincible(false)
        end,  
		timeline =
        {
            TimeEvent(0, function(inst)
                --inst.components.health:SetInvincible(false)
            end),
        },
        events =
        {
            GLOBAL.EventHandler("animover", function(inst)
                inst.sg:GoToState("idle")
            end ),
        }
    }
)