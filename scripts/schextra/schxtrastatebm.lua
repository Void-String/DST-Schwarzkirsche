local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local ACTIONS = GLOBAL.ACTIONS

STRINGS.BLOOMSRT = "Blumenkranze"
AddAction("ACTBLOOM", STRINGS.BLOOMSRT, function(act)
if act.doer ~= nil and act.target ~= nil and 
	act.doer:HasTag("Schwarzkirsche") and 
		act.doer:HasTag("schcaster") and 
			act.doer:HasTag("fullbloom") and 
				act.target.components.schbloomlevel and 
					act.doer.components.schbloomlevel.current >= (200) then
						act.target.components.schbloomlevel:StartBloom(act.doer)
				return true	
			else 
		return false
	end
end)
AddComponentAction("SCENE", "schbloomlevel", function(inst, doer, actions, right)
	if right then
		if inst:HasTag("Schwarzkirsche") and 
			inst:HasTag("schcaster") and inst:HasTag("fullbloom") and
				inst == doer and (rider == nil or not rider:IsRiding()) then
			table.insert(actions, GLOBAL.ACTIONS.ACTBLOOM)	
		end
	end
end)

local state_bloom = GLOBAL.State 
{
        name = "start_blooming",
      --tags = { "doing", "playing" },
        tags = { "busy", "pausepredict", "nomorph", "nodangle" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
		if inst.components.schbloomlevel and inst.components.schbloomlevel.current >= (200) then
--[[        inst.AnimState:PlayAnimation("bell")
            inst.AnimState:OverrideSymbol("bell01", "bell", "bell01")
          --inst.AnimState:Hide("ARM_carry")
            inst.AnimState:Show("ARM_normal")	]]
            inst.AnimState:OverrideSymbol("shadow_hands", "shadow_skinchangefx", "shadow_hands")
            inst.AnimState:OverrideSymbol("shadow_ball", "shadow_skinchangefx", "shadow_ball")
            inst.AnimState:OverrideSymbol("splode", "shadow_skinchangefx", "splode")
            inst.AnimState:PlayAnimation("pickup", false)
			inst.AnimState:PushAnimation("skin_change", false)
            inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and inst.bufferedaction.invobject or nil)
				else
				inst.sg:GoToState("electrocute")
			end
        end,

        timeline =
        {
		--[[
            TimeEvent(15 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve_DLC001/common/glommer_bell")
            end),
		]]
			TimeEvent(16 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/together/skin_change")
            end),
            TimeEvent(60 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry")
                inst.AnimState:Hide("ARM_normal")
            end
	  --inst.AnimState:OverrideSymbol("shadow_hands", "shadow_hands", "shadow_hands")
        end,
}

AddStategraphState("wilson", state_bloom)
AddStategraphState("wilson_client", state_bloom)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.ACTBLOOM, "start_blooming"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.ACTBLOOM, "start_blooming"))