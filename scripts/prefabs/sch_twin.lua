local brain = require "brains/schtwinbrain"
local assets = 
{
	Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset( "ANIM", "anim/player_basic.zip" ),
	Asset( "ANIM", "anim/player_idles_shiver.zip" ),
	Asset( "ANIM", "anim/player_actions.zip" ),
	Asset( "ANIM", "anim/player_actions_axe.zip" ),
	Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
	Asset( "ANIM", "anim/player_actions_shovel.zip" ),
	Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
	Asset( "ANIM", "anim/player_actions_eat.zip" ),
	Asset( "ANIM", "anim/player_actions_item.zip" ),
	Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
	Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
	Asset( "ANIM", "anim/player_actions_fishing.zip" ),
	Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
	Asset( "ANIM", "anim/player_bush_hat.zip" ),
	Asset( "ANIM", "anim/player_attacks.zip" ),
	Asset( "ANIM", "anim/player_idles.zip" ),
	Asset( "ANIM", "anim/player_rebirth.zip" ),
	Asset( "ANIM", "anim/player_jump.zip" ),
	Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
	Asset( "ANIM", "anim/player_teleport.zip" ),
	Asset( "ANIM", "anim/wilson_fx.zip" ),
	Asset( "ANIM", "anim/player_one_man_band.zip" ),
	Asset( "ANIM", "anim/shadow_hands.zip" ),
	Asset( "SOUND", "sound/sfx.fsb" ),
	Asset("SOUND", "sound/maxwell.fsb"),
	Asset("SOUND", "sound/willow.fsb"),   
	----------------------------------------------
	Asset("ANIM", "anim/swap_shovel.zip"),
	Asset("ANIM", "anim/swap_axe.zip"),
	Asset("ANIM", "anim/swap_pickaxe.zip"),
	Asset("ANIM", "anim/swap_nightmaresword.zip"),
    Asset("ANIM", "anim/swap_krampus_sack.zip"),
    Asset("ANIM", "anim/ui_krampusbag_2x5.zip"),
	----------------------------------------------
    Asset("ANIM", "anim/schwarzkirsche_blue.zip"), 
}

local prefabs = { }

local items =
{
	AXE = "swap_axe",
	PICKAXE = "swap_pickaxe",
	SHOVEL = "swap_shovel",
    SWORD = "swap_nightmaresword",
    BAGPCK = "swap_krampus_sack",
}

local PLAYERPROX_NEAR_LEADER_DISTANCE = 15
local MY_CHANCE = 0.3

local function OnAttacked(inst, data)
	if data.attacker ~= nil then
		if data.attacker.components.petleash ~= nil and
				data.attacker.components.petleash:IsPet(inst) and 
					data.attacker:HasTag("ShadowMaster") then
						data.attacker.components.petleash:DespawnPet(inst)
        elseif data.attacker.components.combat ~= nil then
            inst.components.combat:SuggestTarget(data.attacker)
        end
    end
end

local function OnDeath(inst)
	SpawnPrefab("chester_transform_fx").Transform:SetPosition(inst:GetPosition():Get())
	inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	if inst.components.container then
		inst.components.container:DropEverything(true) 
	end
	if inst.components.inventory then
		inst.components.inventory:DropEverything(true) 
	end
end 

local function EquipItem(inst, item)
	if item then
	    inst.AnimState:OverrideSymbol("swap_object", item, item)
	    inst.AnimState:Show("ARM_carry") 
	    inst.AnimState:Hide("ARM_normal")
	end
end

local function EquipBPack(inst, item)

end



local function entitydeathfn(inst, data)
    if data.inst:HasTag("player") then
        inst:DoTaskInTime(math.random(), function() inst.components.health:Kill() end)
    end
end

local function MyMaster(inst, data)
local leader = inst.components.follower.leader
if not inst.components.follower.leader then
--		inst.components.health:Kill() ------ Future Update
		inst.components.followersitcommand:SetStaying(true)
	end 	
end

local function OnKilled(inst, data)
	local victim = data.victim
end

local function FireElement(inst, data)
local other = data.target
if math.random() < MY_CHANCE then
if inst.prefab == "sch_twin" then
if not (other:HasTag("smashable")) then
		if other and other.components.burnable then
				other.components.health:DoDelta(-10)
				other.components.burnable:Ignite()
		elseif other and other:HasTag("ShadowLeader") then
				inst.components.combat:SetTarget(nil)
				inst.components.combat:GiveUp()
		end
		if other.components.burnable and other.components.burnable:IsBurning() then
			other.components.burnable:Extinguish()
		end
	end
		end
	end
end

local function PlayerProxOnClose(inst)
local leader = inst.components.follower.leader
	if inst.components.follower:IsNearLeader(PLAYERPROX_NEAR_LEADER_DISTANCE) then
			inst.components.locomotor.runspeed = TUNING.SHADOWWAXWELL_SPEED
	end 
end

local function PlayerProxOnFar(inst)
local leader = inst.components.follower.leader
	if inst.components.follower:IsNearLeader(PLAYERPROX_NEAR_LEADER_DISTANCE) then
			inst.components.locomotor.runspeed = (TUNING.SHADOWWAXWELL_SPEED*1.5)
			inst.components.combat:GiveUp()
	end 
end
--[[
local function retargetfn(inst)
    local leader = inst.components.follower:GetLeader()
    return leader ~= nil and FindEntity(leader, TUNING.SHADOWWAXWELL_TARGET_DIST,
		function(guy)
			return guy ~= inst
				and (guy.components.combat:TargetIs(leader) or
					guy.components.combat:TargetIs(inst))
				and inst.components.combat:CanTarget(guy)
            end,
            { "_combat" }, -- see entityreplica.lua
            { "playerghost", "INLIMBO" })
	or nil
end

local function keeptargetfn(inst, target)
    return inst.components.follower:IsNearLeader(PLAYERPROX_NEAR_LEADER_DISTANCE)
        and inst.components.combat:CanTarget(target)
		and target.components.minigame_participator == nil
end

local function KeepTarget(isnt, target)
    return target and target:IsValid()
end
]]

local function KeepTarget(isnt, target)
    return false
end

local function OnOpen(inst)
    if not inst.components.health:IsDead() then
		inst.sg:GoToState("open")
    end
end 

local function OnClose(inst) 
    if not inst.components.health:IsDead() then
        inst.sg:GoToState("idle")
    end
end 

local function maketwinfn()
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

	inst.Transform:SetFourFaced(inst)

	MakeGhostPhysics(inst, 50, .5)
--	MakeCharacterPhysics(inst, 50, .5)
	inst.Transform:SetScale(1, 1, 1)
	inst.entity:SetPristine()

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "schwarzkirsche.tex" )
	inst.MiniMapEntity:SetCanUseCache(false)

	inst.AnimState:SetBank("wilson")
	inst.AnimState:SetBuild("schwarzkirsche_blue")
	inst.AnimState:PlayAnimation("idle")
	--inst.AnimState:SetMultColour(0, 0, 0, .5)
    
	inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Hide("hat")
    inst.AnimState:Hide("hat_hair")
	
    inst.AnimState:OverrideSymbol("swap_body", "swap_krampus_sack", "backpack")
    inst.AnimState:OverrideSymbol("swap_body", "swap_krampus_sack", "swap_body")
	
    inst:AddTag("twin")
    inst:AddTag("carrier")
	inst:AddTag("companion")
    inst:AddTag("noauradamage")
 	inst:AddTag("sch_twin")
	inst:AddTag("schshadow")	
	inst:AddTag("SchwarzkirscheShadow")
	
    inst:AddTag("flying")
	if inst.DLC2_fly then
		MakeAmphibiousCharacterPhysics(inst, 2, .5)
	end

	inst:AddComponent("talker")
	inst.components.talker.colour = Vector3(0.7, 0.75, 0.95, 1)

   	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("follower")
	inst.components.follower:KeepLeaderOnAttacked()
	inst:DoPeriodicTask(1, MyMaster)

	inst:AddComponent("followersitcommand")

	inst:AddComponent("inspectable")
	inst:AddComponent("locomotor")
    inst.components.locomotor.pathcaps = { allowocean = true }
    inst.components.locomotor.runspeed = TUNING.SHADOWWAXWELL_SPEED

    inst:AddComponent("combat")
    inst.components.combat:SetRange(1, 7)
    inst.components.combat.playerdamagepercent = 0
    inst.components.combat.hiteffectsymbol = "torso"
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetAttackPeriod(1.25)
    inst.components.combat:SetDefaultDamage(50)
--    inst.components.combat:SetRetargetFunction(1, retargetfn)
--    inst.components.combat:SetKeepTargetFunction(keeptargetfn)

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(370)
	inst.components.health:SetAbsorptionAmount(0.9)
	inst.components.health:StartRegen(3, 15)
	inst.components.health.nofadeout = true
	inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("death", OnDeath)

--[[
	inst:AddComponent("inventory")
	inst.components.inventory.dropondeath = true
]]
    inst:AddComponent("container")
	inst.components.container:WidgetSetup("sch_twin")
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
--[[
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(5, 10)
    inst.components.playerprox:SetOnPlayerNear(PlayerProxOnClose)
    inst.components.playerprox:SetOnPlayerFar(PlayerProxOnFar)
]]
    inst.items = items
    inst.equipfn = EquipItem
	EquipItem(inst)

	inst:ListenForEvent("killed", OnKilled)
	inst:ListenForEvent("onhitother", FireElement)
    inst:ListenForEvent("entity_death", function(world, data) entitydeathfn(inst, data) end, TheWorld)

	inst:SetBrain(brain)
	inst:SetStateGraph("SGschtwin")

	return inst
end

return Prefab("sch_twin", maketwinfn, assets, prefabs)
		