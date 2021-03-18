local brain = require "brains/shadowschbrain"
local assets = 
{
    Asset("ANIM", "anim/player_basic.zip" ),
    Asset("ANIM", "anim/schwarzkirsche_black.zip"),
	Asset("SOUND", "sound/maxwell.fsb"),
	Asset("SOUND", "sound/willow.fsb"),    
	Asset("ANIM", "anim/swap_shovel.zip"),
	Asset("ANIM", "anim/swap_axe.zip"),
	Asset("ANIM", "anim/swap_pickaxe.zip"),
	Asset("ANIM", "anim/swap_nightmaresword.zip"),
}

local prefabs = { }

local items =
{
	AXE = "swap_axe",
	PICKAXE = "swap_pickaxe",
	SHOVEL = "swap_shovel",
    SWORD = "swap_nightmaresword"

}

local PLAYERPROX_NEAR_LEADER_DISTANCE = 15
local MY_CHANCE = 0.1

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
	SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get()) inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	if inst.components.container then
		inst.components.container:DropEverything(true) 
	end
end 

local function EquipItem(inst, item)
	if item then
	    inst.AnimState:OverrideSymbol("swap_object", item, item)
	    inst.AnimState:Show("ARM_carry") 
	    inst.AnimState:Hide("ARM_normal")
	end
end

local function KeepTarget(isnt, target)
    return target and target:IsValid()
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
		--inst.components.followersitcommand:SetStaying(true)
	end 	
end

local function OnHit(inst, data)
local other =  data.target
if not (other:HasTag("smashable")) then
local fx = SpawnPrefab("statue_transition_2")
	fx.Transform:SetPosition(other:GetPosition():Get())
elseif other and other:HasTag("ShadowLeader") then
			inst.components.combat:SetTarget(nil)
		inst.components.combat:GiveUp()
	end
end

local function OnKilled(inst, data)
	local victim = data.victim
end

local function IceElement(inst, data)
local other = data.target
if math.random() < MY_CHANCE then
if inst.prefab == "shadow_sch_digger" then
if not other:HasTag("smashable") then
	if other and other.components.freezable then
	local pref = "icespike_fx_"..math.random(1,4)
	local fx = SpawnPrefab(pref)
	local shards = math.random(0.75,1.25)
			fx.Transform:SetScale(shards, shards, shards)
			fx.Transform:SetPosition(other:GetPosition():Get())
			other.components.freezable:AddColdness(0.3)
			other.components.freezable:SpawnShatterFX()
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

local function FireElement(inst, data)
local other = data.target
if math.random() < MY_CHANCE then
if inst.prefab == "shadow_sch_timber" then
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

local function LightningElement(inst, data)
local other = data.target
if math.random() < MY_CHANCE then
if inst.prefab == "shadow_sch_miner" then
if not (other:HasTag("smashable")) then
		if other and other.components.burnable then
			local fx1 = SpawnPrefab("lightning")
			local scale = math.random(0.75,0.85)
					fx1.Transform:SetScale(scale, scale, scale)
					fx1.Transform:SetPosition(other:GetPosition():Get())
				other.components.health:DoDelta(-10)
		elseif other and other:HasTag("ShadowLeader") then
				inst.components.combat:SetTarget(nil)
				inst.components.combat:GiveUp()
				inst.firstblood = true
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

local function makeshadowfn()
local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddNetwork()

	inst.Transform:SetFourFaced(inst)

	MakeGhostPhysics(inst, 1, .5)
	--MakeCharacterPhysics(inst, 50, .5)
	RemovePhysicsColliders(inst)
	inst.Transform:SetScale(1, 1, 1)
	inst.entity:SetPristine()

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "schwarzkirsche.tex" )
	inst.MiniMapEntity:SetCanUseCache(false)

	inst.AnimState:SetBank("wilson")
	inst.AnimState:SetBuild("schwarzkirsche_black")
	inst.AnimState:PlayAnimation("idle")
	--inst.AnimState:SetMultColour(0, 0, 0, .5)
    
	inst.AnimState:Hide("ARM_carry")
    inst.AnimState:Hide("hat")
    inst.AnimState:Hide("hat_hair")

    --inst:AddTag("shadow")
    inst:AddTag("scarytoprey")
	inst:AddTag("companion")
    inst:AddTag("noauradamage")
 	inst:AddTag("sch_shadowsch")
	inst:AddTag("schshadow")	
	inst:AddTag("SchwarzkirscheShadow")
	
    inst:AddTag("flying")
	if inst.DLC2_fly then
		MakeAmphibiousCharacterPhysics(inst, 2, .5)
	end

	inst:AddComponent("colourtweener")
	inst.components.colourtweener:StartTween({1,1,1,.7}, 0)

	inst:AddComponent("talker")
	inst.components.talker.fontsize = 20
	inst.components.talker.colour = Vector3(0.7, 0.75, 0.95, 1)
   	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("follower")
	inst.components.follower:KeepLeaderOnAttacked()
	inst:DoPeriodicTask(1, MyMaster)
	
	--inst:AddComponent("followersitcommand")
	
	inst:AddComponent("inspectable")
	inst:AddComponent("locomotor")
    inst.components.locomotor.pathcaps = { ignorecreep = true }
    inst.components.locomotor.runspeed = TUNING.SHADOWWAXWELL_SPEED

    inst:AddComponent("combat")
    inst.components.combat:SetRange(1, 7)
    inst.components.combat.playerdamagepercent = 0
    inst.components.combat.hiteffectsymbol = "torso"
    inst.components.combat:SetKeepTargetFunction(KeepTarget)
    inst.components.combat:SetAttackPeriod(1.25)
    inst.components.combat:SetDefaultDamage(25)
    inst.components.combat:SetRetargetFunction(1, retargetfn) --Look for leader's target.
    inst.components.combat:SetKeepTargetFunction(keeptargetfn) --Keep attacking while leader is near.

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.SPIDER_HEALTH+50)
	inst.components.health:SetAbsorptionAmount(TUNING.SNURTLE_SHELL_ABSORB)
	inst.components.health:StartRegen(3, 10)
	inst.components.health.nofadeout = true
	inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("death", OnDeath)

	inst:AddComponent("inventory")
	inst.components.inventory.dropondeath = false

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(4, 7)
    inst.components.playerprox:SetOnPlayerNear(PlayerProxOnClose)
    inst.components.playerprox:SetOnPlayerFar(PlayerProxOnFar)

    inst.items = items
    inst.equipfn = EquipItem
	EquipItem(inst)

	inst:ListenForEvent("killed", OnKilled)
	inst:ListenForEvent("onhitother", OnHit)
	inst:ListenForEvent("onhitother", IceElement)
	inst:ListenForEvent("onhitother", FireElement)
	inst:ListenForEvent("onhitother", LightningElement)
    inst:ListenForEvent("entity_death", function(world, data) entitydeathfn(inst, data) end, TheWorld)

	inst:SetBrain(brain)
	inst:SetStateGraph("SGshadowsch")
	return inst
end

return Prefab("shadow_sch_timber", makeshadowfn, assets, prefabs),
		Prefab("shadow_sch_digger", makeshadowfn, assets, prefabs),
		Prefab("shadow_sch_miner", makeshadowfn, assets, prefabs),
		Prefab("sch_shadowsch", makeshadowfn, assets, prefabs) ------- Client LOG
		