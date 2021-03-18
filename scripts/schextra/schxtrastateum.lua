local require = GLOBAL.require
local ACTIONS = GLOBAL.ACTIONS
local TheInput = GLOBAL.TheInput
local ThePlayer = GLOBAL.ThePlayer
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local IsServer = GLOBAL.TheNet:GetIsServer()


local SCHUSEITEMS = Action({ priority = 1, instant = false })
SCHUSEITEMS.str = "Heal"
SCHUSEITEMS.id = "SCHUSEITEMS"
AddAction(SCHUSEITEMS)
SCHUSEITEMS.fn = function(act)
if act.doer ~= nil and 
	act.target ~= nil and 
		act.doer:HasTag("GemsMaker") and
			act.target.components.schuseitems and 
				act.target.components.inventoryitem then
					act.target.components.schuseitems:Activate(act.doer)
				return true
			else
		return false
	end
end

AddComponentAction("SCENE", "schuseitems", function(inst, doer, actions, right)
if right then
	if inst:HasTag("MysteriousGems") and doer:HasTag("GemsMaker") then
			table.insert(actions, GLOBAL.ACTIONS.SCHUSEITEMS)
		end
	end
end)

local on_use_items = GLOBAL.State({ 
        name = "useitems",
        tags = { "doing", "busy", "nodangle" },
        onenter = function(inst)
		inst.AnimState:PlayAnimation("build_pre")
		inst.AnimState:PushAnimation("build_loop", true)
        inst.components.locomotor:Stop()
		inst.sg:SetTimeout(1)
		inst.SoundEmitter:PlaySound("dontstarve/wilson/make_trap", "make")
        end,

        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
        },

        ontimeout = function(inst)
            inst.SoundEmitter:KillSound("make")
            inst.AnimState:PlayAnimation("build_pst")
            inst:PerformBufferedAction()
        end,

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("make")
			inst:ClearBufferedAction()
        end,
}
)
AddStategraphState("wilson",on_use_items)
AddStategraphState("wilson_client",on_use_items)


AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHUSEITEMS, "useitems"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHUSEITEMS, "useitems"))
