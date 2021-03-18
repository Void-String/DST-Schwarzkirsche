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
}
for k,v in pairs(targets) do
	AddPrefabPostInit(v,function(inst)
		if GLOBAL.TheWorld.ismastersim then
			inst:AddComponent("schcastspells")
		end
	end)
end
----------------------------------------------------------------------------
--See sand_spike.lua
local SPIKE_SIZES =
{
    "short",
    "med",
    "tall",
}

local SPIKE_RADIUS =
{
    ["short"] = .2,
    ["med"] = .4,
    ["tall"] = .6,
    ["block"] = 1.1,
}

local function CanSpawnSpikeAt(pos, size)
    local radius = SPIKE_RADIUS[size]
    for i, v in ipairs(TheSim:FindEntities(pos.x, 0, pos.z, radius + 1.5, nil, { "antlion_sinkhole" }, { "groundspike", "antlion_sinkhole_blocker" })) do
        if v.Physics == nil then
            return false
        end
        local spacing = radius + v:GetPhysicsRadius(0)
        if v:GetDistanceSqToPoint(pos) < spacing * spacing then
            return false
        end
    end
    return true
end

local function SpawnSpikes(inst, pos, count)
    for i = #SPIKE_SIZES, 1, -1 do
        local size = SPIKE_SIZES[i]
        if CanSpawnSpikeAt(pos, size) then
            SpawnPrefab("sch_sandspike_"..size).Transform:SetPosition(pos:Get())
            count = count - 1
            break
        end
    end
    if count > 0 then
        local dtheta = PI * 2 / count
        for theta = math.random() * dtheta, PI * 2, dtheta do
            local size = SPIKE_SIZES[math.random(#SPIKE_SIZES)]
            local offset = FindWalkableOffset(pos, theta, 2 + math.random() * 2, 3, false, true,
                function(pt)
                    return CanSpawnSpikeAt(pt, size)
                end,
                false, true)
            if offset ~= nil then
                SpawnPrefab("sch_sandspike_"..size).Transform:SetPosition(pos.x + offset.x, 0, pos.z + offset.z)
            end
        end
    end
end

local function SpawnBlock(inst, x, z)
    SpawnPrefab("schsandblock").Transform:SetPosition(x, 0, z)
end

local function SpawnBlocks(inst, pos, count)
    if count > 0 then
        local dtheta = PI * 2 / count
        local thetaoffset = math.random() * PI * 2
        for theta = math.random() * dtheta, PI * 2, dtheta do
            local offset = FindWalkableOffset(pos, theta + thetaoffset, 8 + math.random(), 3, false, true,
                function(pt)
                    return CanSpawnSpikeAt(pt, "block")
                end)
            if offset ~= nil then
                if theta < dtheta then
                    SpawnBlock(inst, pos.x + offset.x, pos.z + offset.z)
                else
                    inst:DoTaskInTime(math.random() * .5, SpawnBlock, pos.x + offset.x, pos.z + offset.z)
                end
            end
        end
    end
end
---------------------------[[ ACTIONS : LIGHTNING ]]----------------------------
STRINGS.SCH_CAST_LIGHTNING = "Spell Lightning"
AddAction("SCHSPELLSBOOK", STRINGS.SCH_CAST_LIGHTNING, function(act)
if act.doer ~= nil and act.target ~= nil and 
	act.doer:HasTag("Schwarzkirsche") and 
		act.doer:HasTag("schcaster") and 
			act.doer:HasTag("ligtningpower") and 
				act.target.components.schcastspells and 
					act.doer.components.schwarlock and 
						act.doer.components.schwarlock.current >= (15) then
							act.target.components.schcastspells:Sorcery(act.doer)
				return true	
			else 
		return false
	end
end)
---------------------------[[ ACTIONS : SHADOW ]]----------------------------
STRINGS.SCH_CAST_SHADOW = "Summon Shadow"
AddAction("SCHSHADOWBOOK", STRINGS.SCH_CAST_SHADOW, function(act)
if act.doer ~= nil and act.target ~= nil and 
	act.doer:HasTag("Schwarzkirsche") and 
		act.doer:HasTag("schcaster") and 
			act.doer:HasTag("theshadowmaker") and 
				act.target.components.schcastspells and 
					act.doer.components.schwarlock and 
						act.doer.components.schwarlock.current >= (25) then
							act.target.components.schcastspells:Shadow(act.doer)
				return true	
			else 
		return false
	end
end)
---------------------------[[ ACTIONS : PET ]]----------------------------
STRINGS.SCH_MY_PET = "Piko-piko"
AddAction("SCHMYPET", STRINGS.SCH_MY_PET, function(act)
if act.doer ~= nil and act.target ~= nil and 
	act.doer:HasTag("Schwarzkirsche") and 
		act.doer:HasTag("schcaster") and 
			act.doer:HasTag("mypetcompaion") and 
				act.target.components.schcastspells and 
					act.doer.components.schwarlock and 
						act.doer.components.schwarlock.current >= (30) then
							act.target.components.schcastspells:LittleFriends(act.doer)
				return true	
			else 
		return false
	end
end)
---------------------------[[ ACTIONS : FREEZE ]]----------------------------
STRINGS.SCH_FREEZE_STR = "Freeze"
AddAction("SCHLANDOFICE", STRINGS.SCH_FREEZE_STR, function(act)
if act.doer ~= nil and act.target ~= nil and 
	act.doer:HasTag("Schwarzkirsche") and 
		act.doer:HasTag("schcaster") and 
			act.doer:HasTag("icemaiden") and 
				act.target.components.schcastspells and 
					act.doer.components.schwarlock and 
						act.doer.components.schwarlock.current >= (20) then
							act.target.components.schcastspells:Freeze(act.doer)
				return true	
			else 
		return false
	end
end)
---------------------------[[ ACTION : SUMMON WALL ]]-----------------------------
STRINGS.SCHWALLSTR = "Summon Wall"
AddAction("SCHWALL", STRINGS.SCHWALLSTR, function(act)
if act.doer ~= nil and act.target ~= nil and 
	act.doer:HasTag("Schwarzkirsche") and 
		act.doer:HasTag("schcaster") and 
			act.doer:HasTag("sandcaster") and 
				act.target.components.schcastspells and 
					act.doer.components.schwarlock and 
						act.doer.components.schwarlock.current >= (15) then
							act.target.components.schcastspells:SummonWall(act.doer)
				return true	
			else 
		return false
	end
end)
-----------------------------[[ ACTION : Extinguish ]]-------------------------------
STRINGS.EXTINGSHSRT = "Extinguish"
AddAction("ACEXTINGUISH", STRINGS.EXTINGSHSRT, function(act)
if act.doer ~= nil and act.target ~= nil and 
	act.doer:HasTag("Schwarzkirsche") and 
		act.doer:HasTag("schcaster") and 
			act.doer:HasTag("extinguisher") and 
				act.target.components.schcastspells and 
					act.doer.components.schwarlock and 
						act.doer.components.schbloomlevel.current >= (10) then
							act.target.components.schcastspells:PlayFlute(act.doer)
				return true	
			else 
		return false
	end
end)
---------------------------[[ Component : Cast Spells ]]----------------------------
AddComponentAction("SCENE", "schcastspells", function(inst, doer, actions, right)
	local rider = inst.components.rider
	if right then
		if inst:HasTag("Schwarzkirsche") and 
			inst:HasTag("schcaster") and inst:HasTag("ligtningpower") and
				inst == doer and (rider == nil or not rider:IsRiding()) then
			table.insert(actions, GLOBAL.ACTIONS.SCHSPELLSBOOK)	
		end
	end
	if right then
		if inst:HasTag("Schwarzkirsche") and 
			inst:HasTag("schcaster") and inst:HasTag("theshadowmaker") and
				inst == doer and (rider == nil or not rider:IsRiding()) then
			table.insert(actions, GLOBAL.ACTIONS.SCHSHADOWBOOK)	
		end
	end
	if right then
		if inst:HasTag("Schwarzkirsche") and 
			inst:HasTag("schcaster") and inst:HasTag("mypetcompaion") and
				inst == doer and (rider == nil or not rider:IsRiding()) then
			table.insert(actions, GLOBAL.ACTIONS.SCHMYPET)	
		end
	end
	if right then
		if inst:HasTag("Schwarzkirsche") and 
			inst:HasTag("schcaster") and inst:HasTag("icemaiden") and
				inst == doer and (rider == nil or not rider:IsRiding()) then
			table.insert(actions, GLOBAL.ACTIONS.SCHLANDOFICE)	
		end
	end
	if right then
		if inst:HasTag("Schwarzkirsche") and 
			inst:HasTag("schcaster") and inst:HasTag("sandcaster") and
				inst == doer and (rider == nil or not rider:IsRiding()) then
			table.insert(actions, GLOBAL.ACTIONS.SCHWALL)	
		end
	end
	if right then
		if inst:HasTag("Schwarzkirsche") and 
			inst:HasTag("schcaster") and inst:HasTag("extinguisher") and
				inst == doer and (rider == nil or not rider:IsRiding()) then
			table.insert(actions, GLOBAL.ACTIONS.ACEXTINGUISH)	
		end
	end
end)
---------------------------[[ STATE : LIGHTNING ]]----------------------------
local sch_spells_lightning = 
GLOBAL.State(
	{	name = "sch_spells_lightning",
        tags = { "doing", "busy", "notalking" },
	onenter = function(inst)
		inst.components.locomotor:Stop()
		if inst.components.schwarlock and inst.components.schwarlock.current >= (15) then
				inst.AnimState:PlayAnimation("action_uniqueitem_pre")
					inst.AnimState:PushAnimation("book", true)
				else
			inst.sg:GoToState("electrocute")
		end
        inst.AnimState:Show("ARM_normal")
        inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and (inst.bufferedaction.target or inst.bufferedaction.invobject) or nil)
		inst.sg:SetTimeout(3)   
     end,
        timeline =	{ -------------- [[NOT RIDING LMAO : WHY ADDED]]------------------
			TimeEvent(0, function(inst)
			local fxtoplay = inst.components.rider ~= nil and inst.components.rider:IsRiding() and "book_fx_mount" or "book_fx"
			local fx = SpawnPrefab(fxtoplay)
					fx.entity:SetParent(inst.entity)
					fx.Transform:SetPosition(0, 0.2, 0)
					inst.sg.statemem.book_fx = fx	
			end),
            TimeEvent(28 * FRAMES, function(inst)
			local fx1 = SpawnPrefab("sch_stalker_shield")
					fx1.Transform:SetScale(0.30, 0.30, 0.30)
					fx1.Transform:SetPosition(inst:GetPosition():Get())
					inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")	end),
            TimeEvent(54 * FRAMES, function(inst)
					inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
					inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(58 * FRAMES, function(inst)
					inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
					inst:PerformBufferedAction()
					inst.sg.statemem.book_fx = nil
            end),
        },
		events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
		ontimeout = function(inst)
		inst.sg:RemoveStateTag("doing")
		inst.sg:RemoveStateTag("notalking")
		inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
			end
        end,
        onexit = function(inst)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
			end
			inst.sg.statemem.action = nil
        end,
    }
)
local sch_spells_lightning_client = -----------[[ STATE : LIGHTNING for CLIENT ]]------------
GLOBAL.State(
	{	name = "sch_spells_lightning_client",
		tags = { "doing", "busy", "notalking" },
        onenter = function(inst)
		if inst.replica.health then
			--inst.replica.health:SetInvincible(true)
		end
		inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("action_uniqueitem_lag", false)
	      --inst.AnimState:PushAnimation("book", false)
            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(2.5)   
        end,
        timeline =	{
            TimeEvent(0, function(inst)
                local fxtoplay = inst.replica.rider ~= nil and inst.replica.rider:IsRiding() and "book_fx_mount" or "book_fx"
                local fx = SpawnPrefab(fxtoplay)
                fx.entity:SetParent(inst.entity)
                fx.Transform:SetPosition(0, 0.2, 0)
                inst.sg.statemem.book_fx = fx
            end),
            TimeEvent(28 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
            end),
            TimeEvent(54 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
				inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(58 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
                inst:PerformBufferedAction()
                inst.sg.statemem.book_fx = nil
            end),
        },
       events =	{
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),	},
		onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,
		ontimeout = function(inst)
            inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
            end
        end,
        onexit = function(inst)
            if inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
			end
			inst.sg.statemem.action = nil
        end,
    }
)
AddStategraphState("wilson", sch_spells_lightning)
AddStategraphState("wilson_client", sch_spells_lightning_client)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHSPELLSBOOK, "sch_spells_lightning"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHSPELLSBOOK, "sch_spells_lightning_client"))

---------------------------[[ STATE : SHADOW ]]----------------------------
local sch_spells_shadow = 
GLOBAL.State(
	{	name = "sch_spells_shadow",
        tags = { "doing", "busy", "notalking" },
	onenter = function(inst)
		inst.components.locomotor:Stop()
		if inst.components.schwarlock and inst.components.schwarlock.current >= (25) then
				inst.AnimState:PlayAnimation("action_uniqueitem_pre")
					inst.AnimState:PushAnimation("book", true)
				else
			inst.sg:GoToState("mindcontrolled")
		end
        inst.AnimState:Show("ARM_normal")
        inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and (inst.bufferedaction.target or inst.bufferedaction.invobject) or nil)
		inst.sg:SetTimeout(3)   
     end,
        timeline =	{ -------------- [[NOT RIDING LMAO : WHY ADDED]]------------------
			TimeEvent(0, function(inst)
			local fxtoplay = inst.components.rider ~= nil and inst.components.rider:IsRiding() and "book_fx_mount" or "book_fx"
			local fx = SpawnPrefab(fxtoplay)
					fx.entity:SetParent(inst.entity)
					fx.Transform:SetPosition(0, 0.2, 0)
					inst.sg.statemem.book_fx = fx	
			end),
            TimeEvent(28 * FRAMES, function(inst)
			local fx1 = SpawnPrefab("sch_stalker_shield")
					fx1.Transform:SetScale(0.30, 0.30, 0.30)
					fx1.Transform:SetPosition(inst:GetPosition():Get())
					inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")	end),
            TimeEvent(54 * FRAMES, function(inst)
					inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
					inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(58 * FRAMES, function(inst)
					inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
					inst:PerformBufferedAction()
					inst.sg.statemem.book_fx = nil
            end),
        },
		events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
		ontimeout = function(inst)
		inst.sg:RemoveStateTag("doing")
		inst.sg:RemoveStateTag("notalking")
		inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
			end
        end,
        onexit = function(inst)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
			end
			inst.sg.statemem.action = nil
        end,
    }
)
local sch_spells_shadow_client = -----------[[ STATE : SHADOW for CLIENT ]]------------
GLOBAL.State(
    {   name = "sch_spells_shadow_client",
		tags = { "doing", "busy", "notalking" },
        onenter = function(inst)
		if inst.replica.health then
			--inst.replica.health:SetInvincible(true)
		end
		inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("action_uniqueitem_lag", false)
	      --inst.AnimState:PushAnimation("book", false)
            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(2.5)   
        end,
        timeline =	{
            TimeEvent(0, function(inst)
                local fxtoplay = inst.replica.rider ~= nil and inst.replica.rider:IsRiding() and "book_fx_mount" or "book_fx"
                local fx = SpawnPrefab(fxtoplay)
                fx.entity:SetParent(inst.entity)
                fx.Transform:SetPosition(0, 0.2, 0)
                inst.sg.statemem.book_fx = fx
            end),
            TimeEvent(28 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
            end),
            TimeEvent(54 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
				inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(58 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
                inst:PerformBufferedAction()
                inst.sg.statemem.book_fx = nil
            end),
        },
       events =	{
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),	},
		onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,
		ontimeout = function(inst)
            inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
            end
        end,
        onexit = function(inst)
            if inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
			end
			inst.sg.statemem.action = nil
        end,
    }
)
AddStategraphState("wilson", sch_spells_shadow)
AddStategraphState("wilson_client", sch_spells_shadow_client)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHSHADOWBOOK, "sch_spells_shadow"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHSHADOWBOOK, "sch_spells_shadow_client"))
---------------------------[[ STATE : PET ]]----------------------------
local sch_spells_mypet = 
GLOBAL.State(
	{	name = "sch_spells_mypet",
        tags = { "doing", "busy", "notalking" },
	onenter = function(inst)
		inst.components.locomotor:Stop()
		if inst.components.schwarlock and inst.components.schwarlock.current >= (30) then
				inst.AnimState:PlayAnimation("action_uniqueitem_pre")
					inst.AnimState:PushAnimation("book", true)
				else
			--inst.sg:GoToState("hit_push")
			inst.sg:GoToState("electrocute")
		end
        inst.AnimState:Show("ARM_normal")
        inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and (inst.bufferedaction.target or inst.bufferedaction.invobject) or nil)
		inst.sg:SetTimeout(3)   
     end,
        timeline =	{ -------------- [[NOT RIDING LMAO : WHY ADDED]]------------------
			TimeEvent(0, function(inst)
			local fxtoplay = inst.components.rider ~= nil and inst.components.rider:IsRiding() and "book_fx_mount" or "book_fx"
			local fx = SpawnPrefab(fxtoplay)
					fx.entity:SetParent(inst.entity)
					fx.Transform:SetPosition(0, 0.2, 0)
					inst.sg.statemem.book_fx = fx	
			end),
            TimeEvent(28 * FRAMES, function(inst)
			local fx1 = SpawnPrefab("sch_stalker_shield")
					fx1.Transform:SetScale(0.30, 0.30, 0.30)
					fx1.Transform:SetPosition(inst:GetPosition():Get())
					inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")	end),
            TimeEvent(54 * FRAMES, function(inst)
					inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
					inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(58 * FRAMES, function(inst)
					inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
					inst:PerformBufferedAction()
					inst.sg.statemem.book_fx = nil
            end),
        },
		events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
		ontimeout = function(inst)
		inst.sg:RemoveStateTag("doing")
		inst.sg:RemoveStateTag("notalking")
		inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
			end
        end,
        onexit = function(inst)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
			end
			inst.sg.statemem.action = nil
        end,
    }
)
local sch_spells_mypet_client = -----------[[ STATE : PET for CLIENT ]]------------
GLOBAL.State(
    {   name = "sch_spells_mypet_client",
		tags = { "doing", "busy", "notalking" },
        onenter = function(inst)
		if inst.replica.health then
			--inst.replica.health:SetInvincible(true)
		end
		inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("action_uniqueitem_lag", false)
	      --inst.AnimState:PushAnimation("book", false)
            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(2.5)   
        end,
        timeline =	{
            TimeEvent(0, function(inst)
                local fxtoplay = inst.replica.rider ~= nil and inst.replica.rider:IsRiding() and "book_fx_mount" or "book_fx"
                local fx = SpawnPrefab(fxtoplay)
                fx.entity:SetParent(inst.entity)
                fx.Transform:SetPosition(0, 0.2, 0)
                inst.sg.statemem.book_fx = fx
            end),
            TimeEvent(28 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
            end),
            TimeEvent(54 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
				inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(58 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
                inst:PerformBufferedAction()
                inst.sg.statemem.book_fx = nil
            end),
        },
       events =	{
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),	},
		onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,
		ontimeout = function(inst)
            inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
            end
        end,
        onexit = function(inst)
            if inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
			end
			inst.sg.statemem.action = nil
        end,
    }
)
AddStategraphState("wilson", sch_spells_mypet)
AddStategraphState("wilson_client", sch_spells_mypet_client)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHMYPET, "sch_spells_mypet"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHMYPET, "sch_spells_mypet_client"))
---------------------------[[ STATE : FREEZE ]]----------------------------
local sch_spells_land_of_ice = 
GLOBAL.State(
	{	name = "sch_spells_land_of_ice",
        tags = { "doing", "busy", "notalking" },
	onenter = function(inst)
		inst.components.locomotor:Stop()
		if inst.components.schwarlock and inst.components.schwarlock.current >= (20) then
				inst.AnimState:PlayAnimation("action_uniqueitem_pre")
					inst.AnimState:PushAnimation("book", true)
				else
			--inst.sg:GoToState("frozen")
			inst.sg:GoToState("electrocute")
		end
        inst.AnimState:Show("ARM_normal")
        inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and (inst.bufferedaction.target or inst.bufferedaction.invobject) or nil)
		inst.sg:SetTimeout(3)   
     end,
        timeline =	{ -------------- [[NOT RIDING LMAO : WHY ADDED]]------------------
			TimeEvent(0, function(inst)
			local fxtoplay = inst.components.rider ~= nil and inst.components.rider:IsRiding() and "book_fx_mount" or "book_fx"
			local fx = SpawnPrefab(fxtoplay)
					fx.entity:SetParent(inst.entity)
					fx.Transform:SetPosition(0, 0.2, 0)
					inst.sg.statemem.book_fx = fx	
			end),
            TimeEvent(28 * FRAMES, function(inst)
			local fx1 = SpawnPrefab("sch_stalker_shield")
					fx1.Transform:SetScale(0.30, 0.30, 0.30)
					fx1.Transform:SetPosition(inst:GetPosition():Get())
					inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")	end),
            TimeEvent(54 * FRAMES, function(inst)
					inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
					inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(58 * FRAMES, function(inst)
					inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
					inst:PerformBufferedAction()
					inst.sg.statemem.book_fx = nil
            end),
        },
		events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
		ontimeout = function(inst)
		inst.sg:RemoveStateTag("doing")
		inst.sg:RemoveStateTag("notalking")
		inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
			end
        end,
        onexit = function(inst)
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
			end
			inst.sg.statemem.action = nil
        end,
    }
)
local sch_spells_land_of_ice_client = -----------[[ STATE : PET for CLIENT ]]------------
GLOBAL.State(
    {   name = "sch_spells_land_of_ice_client",
		tags = { "doing", "busy", "notalking" },
        onenter = function(inst)
		if inst.replica.health then
			--inst.replica.health:SetInvincible(true)
		end
		inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("action_uniqueitem_lag", false)
	      --inst.AnimState:PushAnimation("book", false)
            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(2.5)   
        end,
        timeline =	{
            TimeEvent(0, function(inst)
                local fxtoplay = inst.replica.rider ~= nil and inst.replica.rider:IsRiding() and "book_fx_mount" or "book_fx"
                local fx = SpawnPrefab(fxtoplay)
                fx.entity:SetParent(inst.entity)
                fx.Transform:SetPosition(0, 0.2, 0)
                inst.sg.statemem.book_fx = fx
            end),
            TimeEvent(28 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
            end),
            TimeEvent(54 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
				inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(58 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
                inst:PerformBufferedAction()
                inst.sg.statemem.book_fx = nil
            end),
        },
       events =	{
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),	},
		onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,
		ontimeout = function(inst)
            inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
            end
        end,
        onexit = function(inst)
            if inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
			end
			inst.sg.statemem.action = nil
        end,
    }
)
AddStategraphState("wilson", sch_spells_land_of_ice)
AddStategraphState("wilson_client", sch_spells_land_of_ice_client)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHLANDOFICE, "sch_spells_land_of_ice"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHLANDOFICE, "sch_spells_land_of_ice_client"))










---------------------------[[ STATE : SUMMON WALL & CLIENT ]]----------------------------

local summon_block = GLOBAL.State 
{
        name = "summon_wall",
        tags = { "attack", "busy" },

        onenter = function(inst)
		inst.components.locomotor:Stop()
		
		if inst.components.schwarlock and inst.components.schwarlock.current >= (15) then
			inst.AnimState:PlayAnimation("staff_pre")
				inst.AnimState:PushAnimation("staff", false)	
					inst.components.schwarlock:DoDelta(-15)
				else
			--inst.sg:GoToState("hit_push")
			inst.sg:GoToState("electrocute")
		end
       
		end,

        timeline =
        {
            TimeEvent(14 * FRAMES, function(inst)
                SpawnBlocks(inst, inst:GetPosition(), 19)
                inst.components.timer:StartTimer("sch_wall", TUNING.ANTLION_WALL_CD)
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
}
local summon_block_client = -----------[[ STATE : SUMMON WALL for CLIENT ]]------------
GLOBAL.State(
    {   name = "summon_wall_client",
		tags = { "doing", "busy", "notalking" },
        onenter = function(inst)
		if inst.replica.health then
			--inst.replica.health:SetInvincible(true)
		end
		inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("action_uniqueitem_lag", false)
	      --inst.AnimState:PushAnimation("book", false)
            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(2.5)   
        end,
        timeline =	{
            TimeEvent(0, function(inst)
                local fxtoplay = inst.replica.rider ~= nil and inst.replica.rider:IsRiding() and "book_fx_mount" or "book_fx"
                local fx = SpawnPrefab(fxtoplay)
                fx.entity:SetParent(inst.entity)
                fx.Transform:SetPosition(0, 0.2, 0)
                inst.sg.statemem.book_fx = fx
            end),
            TimeEvent(28 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
            end),
            TimeEvent(54 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
				inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(58 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
                inst:PerformBufferedAction()
                inst.sg.statemem.book_fx = nil
            end),
        },
       events =	{
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),	},
		onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,
		ontimeout = function(inst)
            inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
            end
        end,
        onexit = function(inst)
            if inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
			end
			inst.sg.statemem.action = nil
        end,
    }
)

AddStategraphState("wilson", summon_block)
AddStategraphState("wilson_client", summon_block_client)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHWALL, "summon_wall"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHWALL, "summon_wall_client"))

---------------------------[[ STATE : EXTINGUISH & FOR CLIENT ]]----------------------------

local state_extinguish = GLOBAL.State 
{
        name = "fire_extinguish",
        tags = { "doing", "playing" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
		if inst.components.schbloomlevel and inst.components.schbloomlevel.current >= (10) then
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("flute", false)
            inst.AnimState:OverrideSymbol("pan_flute01", "pan_flute", "pan_flute01")
            inst.AnimState:Hide("ARM_carry")
            inst.AnimState:Show("ARM_normal")
            inst.components.inventory:ReturnActiveActionItem(inst.bufferedaction ~= nil and inst.bufferedaction.invobject or nil)
				else
				inst.sg:GoToState("electrocute")
			end
        end,

        timeline =
        {
            TimeEvent(30 * FRAMES, function(inst)
                if inst:PerformBufferedAction() then
                    inst.SoundEmitter:PlaySound("dontstarve/wilson/flute_LP", "flute")
                else
                    inst.AnimState:SetTime(94 * FRAMES)
                end
            end),
            TimeEvent(85 * FRAMES, function(inst)
                inst.SoundEmitter:KillSound("flute")
            end),
        },

        events =
        {
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.SoundEmitter:KillSound("flute")
            if inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry")
                inst.AnimState:Hide("ARM_normal")
            end
        end,
}

local state_extinguish_client = -----------[[ STATE : FIRE EX. for CLIENT ]]------------
GLOBAL.State(
    {   name = "fire_extinguish_client",
		tags = { "doing", "busy", "notalking" },
        onenter = function(inst)
		if inst.replica.health then
			--inst.replica.health:SetInvincible(true)
		end
		inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("action_uniqueitem_pre")
            inst.AnimState:PushAnimation("action_uniqueitem_lag", false)
	      --inst.AnimState:PushAnimation("book", false)
            inst:PerformPreviewBufferedAction()
            inst.sg:SetTimeout(2.5)   
        end,
        timeline =	{
            TimeEvent(0, function(inst)
                local fxtoplay = inst.replica.rider ~= nil and inst.replica.rider:IsRiding() and "book_fx_mount" or "book_fx"
                local fx = SpawnPrefab(fxtoplay)
                fx.entity:SetParent(inst.entity)
                fx.Transform:SetPosition(0, 0.2, 0)
                inst.sg.statemem.book_fx = fx
            end),
            TimeEvent(28 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_light")
            end),
            TimeEvent(54 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/use_book_close")
				inst.sg:RemoveStateTag("busy")
            end),
            TimeEvent(58 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/book_spell")
                inst:PerformBufferedAction()
                inst.sg.statemem.book_fx = nil
            end),
        },
       events =	{
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),	},
		onupdate = function(inst)
            if inst:HasTag("doing") then
                if inst.entity:FlattenMovementPrediction() then
                    inst.sg:GoToState("idle", "noanim")
                end
            elseif inst.bufferedaction == nil then
                inst.sg:GoToState("idle")
            end
        end,
		ontimeout = function(inst)
            inst:ClearBufferedAction()
            if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle")
            end
        end,
        onexit = function(inst)
            if inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS) then
                inst.AnimState:Show("ARM_carry") 
                inst.AnimState:Hide("ARM_normal")
            end
            if inst.sg.statemem.book_fx then
                inst.sg.statemem.book_fx:Remove()
                inst.sg.statemem.book_fx = nil
            end
			if inst.bufferedaction == inst.sg.statemem.action then
			inst:ClearBufferedAction()
			end
			inst.sg.statemem.action = nil
        end,
    }
)

AddStategraphState("wilson", state_extinguish)
AddStategraphState("wilson_client", state_extinguish_client)
AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.ACEXTINGUISH, "fire_extinguish"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.ACEXTINGUISH, "fire_extinguish_client"))


