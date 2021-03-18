local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local ACTIONS = GLOBAL.ACTIONS
local targets = 
{  
"character", 		"pigman", 			"bunnyman", 		"frog", 
"monkey", 			"bat", 				"minotaur", 		"bishop", 
"krampus", 			"mossling", 		"tallbird", 		"deerclopse", 
"bearger", 			"dragonfly", 		"moose", 			"leif", 
"spat", 			"birchnutdrake", 	"deerclops", 		"toadstool", 
"beequeen", 		"klaus", 			"stalker", 			"antlion", 
"beefalo", 			"perd", 			"spider", 			"spider_warrior", 
"spiderqueen", 		"spider_spitter", 	"spider_dropper", 	"hound", 
"firehound", 		"icehound", 		"warg", 			"tentacle", 
"walrus", 			"merm", 			"knight", 			"rook", 
"pigguard", 		"leif_sparse",
}

local function OnStartControlling(inst, stranger)
    inst.stranger = stranger.components.sanity ~= nil and stranger or nil
    if inst.stranger ~= nil then
        inst.stranger.components.sanity:DoDelta(-TUNING.SANITY_SMALL)
        inst.stranger.components.sanity.externalmodifiers:SetModifier(inst, -TUNING.DAPPERNESS_HUGE)
    end
end

local function OnStopControlling(inst, stranger)
    if inst.stranger ~= nil and inst.stranger:IsValid() and inst.stranger.components.sanity ~= nil then
        inst.stranger.components.sanity.externalmodifiers:RemoveModifier(inst)
    end
end

for k,v in pairs(targets) do
	AddPrefabPostInit(v,function(inst)
		if GLOBAL.TheWorld.ismastersim then ---------------- Global is master sim : my Own Server for All Character = Only on Your Server
			inst:AddComponent("schpower")
			inst.components.schpower:SetControllingFn(OnStartControlling, OnStopControlling)
			inst:AddTag("myVictim")
		end
	end)
end 

--[[
AddPlayerPostInit(function(inst)
	if GLOBAL.TheWorld.ismastersim then
		inst:AddComponent("schpower")
	end
end)
]]

--[[ ----------------------- Long Range ---------------------- ]]--
--------[[ New Method ]]--------
local SCHSTARTCONTROLLING = GLOBAL.Action({ distance = 36 })
SCHSTARTCONTROLLING.str = "Start Controlling"
SCHSTARTCONTROLLING.id = "SCHSTARTCONTROLLING"
AddAction(SCHSTARTCONTROLLING)
SCHSTARTCONTROLLING.fn = function(act)
	if act.doer ~= nil and 
		act.target ~= nil and 
			act.doer:HasTag("SoulController") and 
				act.target.components.schpower and 
					act.target:HasTag("myVictim") then
		return act.target.components.schpower:StartControlling(act.doer)
	end
end
local SCHSTOPCONTROLLING = GLOBAL.Action({ instant = true, distance = 36 })
SCHSTOPCONTROLLING.str = "Stop Controlling"
SCHSTOPCONTROLLING.id = "SCHSTOPCONTROLLING"
AddAction(SCHSTOPCONTROLLING)
SCHSTOPCONTROLLING.fn = function(act)
	if act.doer ~= nil and 
		act.target ~= nil and 
			act.doer:HasTag("SoulController") and 
				act.target.components.schpower and 
					act.target:HasTag("myVictim") then
		return act.target.components.schpower:StopControlling(act.doer)
	end
end
----------------- Stil same as before (Old Method) :  Component Action -------
AddComponentAction("SCENE", "schpower", function(inst, doer, actions, right)
if right then
	if inst:HasTag("myVictim") and not doer.sg:HasStateTag("controlling") and doer:HasTag("SoulController") then
			table.insert(actions, GLOBAL.ACTIONS.SCHSTARTCONTROLLING)
		end
	end
if right then
	if inst:HasTag("myVictim") and doer.sg:HasStateTag("controlling") and doer:HasTag("SoulController") then
			table.insert(actions, GLOBAL.ACTIONS.SCHSTOPCONTROLLING)
		end
	end
end)


--------[[ Old Method ]]--------
--[[ --------------------- Short Range ----------------------
AddAction("SCHSTARTCONTROLLING", "Start Controlling", function(act)
	if act.doer ~= nil and 
		act.target ~= nil and 
			act.doer:HasTag('player') and 
				act.target.components.schpower and 
					act.target:HasTag("schpower") then
		return act.target.components.schpower:StartControlling(act.doer)
	end
end)

AddAction("SCHSTOPCONTROLLING", "Stop Controlling", function(act)
	if act.doer ~= nil and 
		act.target ~= nil and 
			act.doer:HasTag('player') and 
				act.target.components.schpower and 
					act.target:HasTag("schpower") then
		return act.target.components.schpower:StopControlling(act.doer)
	end
end)

AddComponentAction("SCENE", "schpower", function(inst, doer, actions, right)
if right then
	if inst:HasTag("schpower") and not doer.sg:HasStateTag("controlling") then
			table.insert(actions, GLOBAL.ACTIONS.SCHSTARTCONTROLLING)
		end
	end
if right then
	if inst:HasTag("schpower") and doer.sg:HasStateTag("controlling") then
			table.insert(actions, GLOBAL.ACTIONS.SCHSTOPCONTROLLING)
		end
	end
end)
]]

local start_controlling = GLOBAL.State{ 
		name = "startcontrolling",
		tags = { "doing", "busy", "precontrolling", "nodangle" },
        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("channel_pre")
            inst.AnimState:PushAnimation("channel_loop", true)
            inst.sg:SetTimeout(.7)
        end,
        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(9 * FRAMES, function(inst)
                inst:PerformBufferedAction()
            end),
        },
        ontimeout = function(inst)
            inst.AnimState:PlayAnimation("channel_pst")
        end,
        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
		},
}
AddStategraphState("wilson",start_controlling)
AddStategraphState("wilson_client",start_controlling)

local controlling_state = GLOBAL.State{
        name = "controlling",
        tags = { "doing", "controlling", "nodangle" },
        onenter = function(inst, target)
            inst:AddTag("controlling")
            inst.components.locomotor:Stop()
            if not inst.AnimState:IsCurrentAnimation("channel_loop") then
                inst.AnimState:PlayAnimation("channel_loop", true)
            end
            inst.sg.statemem.target = target
        end,
        onupdate = function(inst)
            if not CanEntitySeeTarget(inst, inst.sg.statemem.target) then
                inst.sg:GoToState("stopcontrolling")
            end
        end,
        events =
        {
            EventHandler("ontalk", function(inst)
                if not (inst.AnimState:IsCurrentAnimation("channel_dial_loop") or inst:HasTag("mime")) then
                    inst.AnimState:PlayAnimation("channel_dial_loop", true)
                end
            end),
            EventHandler("donetalking", function(inst)
                if not inst.AnimState:IsCurrentAnimation("channel_loop") then
                    inst.AnimState:PlayAnimation("channel_loop", true)
                end
            end),
        },
        onexit = function(inst)
            inst:RemoveTag("controlling")
            if not inst.sg.statemem.stopcontrolling and
                inst.sg.statemem.target ~= nil and
                inst.sg.statemem.target:IsValid() and
                inst.sg.statemem.target.components.schpower ~= nil then
                inst.sg.statemem.target.components.schpower:StopControlling(true)
            end
        end,
}

AddStategraphState("wilson", controlling_state)
AddStategraphState("wilson_client", controlling_state)

local stop_controlling = GLOBAL.State {
        name = "stopcontrolling",
        tags = { "idle", "nodangle" },
        onenter = function(inst)
            inst.AnimState:PlayAnimation("channel_pst")
        end,
        events =
        {
		EventHandler("animover", function(inst)
			if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
			end
		end),
		},
}

AddStategraphState("wilson", stop_controlling)
AddStategraphState("wilson_client", stop_controlling)

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHSTARTCONTROLLING, "startcontrolling"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHSTARTCONTROLLING, "startcontrolling"))

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHSTOPCONTROLLING, "stopcontrolling"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHSTOPCONTROLLING, "stopcontrolling"))