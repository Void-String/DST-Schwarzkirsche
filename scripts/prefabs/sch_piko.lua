local brain = require "brains/schpikobrain"
local fbrain = require "brains/schfpikobrain"
local abrain = require "brains/schapikobrain"
require "prefabutil"

local assets =
{
	---- Piko : Normal
	Asset( "ANIM", "anim/sch_squirrel_build.zip" ),
	Asset( "ANIM", "anim/sch_squirrel_cheeks_build.zip" ),
	---- Piko : Orange
	Asset( "ANIM", "anim/sch_squirrel_orange_build.zip" ),
	Asset( "ANIM", "anim/sch_squirrel_orange_cheeks_build.zip" ),
	---- Piko : Red
	Asset( "ANIM", "anim/sch_squirrel_red_build.zip" ),
	Asset( "ANIM", "anim/sch_squirrel_red_cheeks_build.zip" ),
	----- Piko : Build
	Asset( "ANIM", "anim/sch_ds_squirrel_basic.zip" ),
	----- UI
	Asset( "ANIM", "anim/sch_ui_chest_3x2.zip"),
	---- Sound
	Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"), 
	Asset("SOUND", "sound/DLC003_sfx.fsb"), 
}

local prefabs =
{
	"sch_teatree_nut_piko",
}

local WAKE_TO_FOLLOW_DISTANCE = 14
local SLEEP_NEAR_LEADER_DISTANCE = 7
local PLAYERPROX_NEAR_LEADER_DISTANCE = 15

local pikosounds = 
{
	scream = "dontstarve_DLC003/creatures/piko/scream",
	hurt = "dontstarve_DLC003/creatures/piko/scream",
	idle = "dontstarve_DLC003/creatures/piko/idle",
	attack = "dontstarve_DLC003/creatures/piko/attack",
	steal = "dontstarve_DLC003/creatures/piko/steal",
	death = "dontstarve_DLC003/creatures/piko/death",
}

local function UpdateBuild(inst)
if inst.PIko2ndState == "UP" then
	if inst.components.container:NumItems() > 0 then
		inst.AnimState:SetBuild("sch_squirrel_orange_cheeks_build")
			else
			inst.AnimState:SetBuild("sch_squirrel_orange_build")
		end	
	end
if inst.PIko2ndState == "NO" then
	if inst.components.container:NumItems() > 0 then
		inst.AnimState:SetBuild("sch_squirrel_cheeks_build")
			else
			inst.AnimState:SetBuild("sch_squirrel_build")
		end	
	end
end

local function FarmerUpdateBuild(inst)
if inst.components.inventory:NumItems() > 0 then
	inst.AnimState:SetBuild("sch_squirrel_cheeks_build")
		else
		inst.AnimState:SetBuild("sch_squirrel_build")
	end	
end

local function entitydeathfn(inst, data)
if data.inst:HasTag("player") then
	inst.components.health:Kill() 
	if inst.components.container then
		inst.components.container:DropEverything(true)
		end
	end
end

local function ShouldKeepTarget(inst, target)
    return false
end

local function OnOpen(inst)
	if inst.MorphTask then
		inst.MorphTask:Cancel()
		inst.MorphTask = nil
	end
    if not inst.components.health:IsDead() then
		inst.sg:GoToState("stunned")
    end
end 

local function OnClose(inst) 
    if not inst.components.health:IsDead() then
        inst.sg:GoToState("hit")
    end
end 

local function OnStopFollowing(inst) 
    inst:RemoveTag("companion")
end

local function OnStartFollowing(inst) 
    inst:AddTag("companion")
end

local function MorphUpPiko(inst, dofx)

	inst:AddTag("fridge")

    inst.AnimState:SetBank("squirrel")
    inst.AnimState:SetBuild("sch_squirrel_orange_build")
	inst.AnimState:PlayAnimation("idle", true)
	
	inst.AnimState:Hide("eye_red")
	inst.AnimState:Hide("eye2_red")
	
	inst.MiniMapEntity:SetIcon("sch_piko_orange.tex")
	
	inst.components.container:WidgetSetup("sch_piko2nd")
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8

	inst.Transform:SetScale(1,1,1)
    inst.PIko2ndState = "UP"
    inst._ispiko2nd:set(true)
	
end

local function MorphNoPiko(inst, dofx)
	inst.Transform:SetScale(1,1,1)
    inst.PIko2ndState = "NO"
end

local function CanMorph(inst)
    if inst.PIko2ndState ~= "NO" then -- or not TheWorld.state.isfullmoon then
        return false
    end

    local container = inst.components.container
    if container:IsOpen() then
        return false
    end

    local canUP = true

    for i = 1, container:GetNumSlots() do
        local item = container:GetItemInSlot(i)
        if item == nil then
            return false
        end

        canUP = canUP and item.prefab == "sch_dead_gems"

        if not canUP then
            return false
        end
    end

    return canUP
end

local function MorphPiko(inst)
    local canUP = inst:CanMorph()
    if not canUP then
        return
    end

    local container = inst.components.container
    for i = 1, container:GetNumSlots() do
        container:RemoveItem(container:GetItemInSlot(i)):Remove()
    end

	MorphUpPiko(inst, true)
end

local function CheckForMorph(inst)
    local piko2nd = inst:CanMorph()
    if piko2nd then
        if inst.MorphTask then
            inst.MorphTask:Cancel()
            inst.MorphTask = nil
        end
        inst.MorphTask = inst:DoTaskInTime(2, function(inst)
            inst.sg:GoToState("action")
        end)
    end
end

local function OnSave(inst, data)
    data.PIko2ndState = inst.PIko2ndState
end

local function OnPreLoad(inst, data)
    if not data then return end
    if data.PIko2ndState == "UP" then
        MorphUpPiko(inst)
    end
end

local function OnIsPikoUPDirty(inst)
    if inst._ispiko2nd:value() ~= inst._clientpikoup then
        inst._clientpikoup = inst._ispiko2nd:value()
        inst.replica.container:WidgetSetup(inst._clientpikoup and "sch_piko2nd" or nil)
    end
end

local function OnHaunt(inst)
    if math.random() <= TUNING.HAUNT_CHANCE_ALWAYS then
        inst.components.hauntable.panic = true
        inst.components.hauntable.panictimer = TUNING.HAUNT_PANIC_TIME_SMALL
        inst.components.hauntable.hauntvalue = TUNING.HAUNT_SMALL
        return true
    end
    return false
end

local function MyMaster(inst, data)
local leader = inst.components.follower.leader
if not inst.components.follower.leader then
--		inst.components.health:Kill() ------ Future Update
		--inst.components.followersitcommand:SetStaying(true)
--[[
	if inst.components.container then
		inst.components.container:DropEverything(true)
		end
]]
	if inst.components.inventory then
		inst.components.inventory:DropEverything(true)
		end
	end 	
end

local function ShouldWakeUp(inst)
    return DefaultWakeTest(inst) or not 
			inst.components.follower:IsNearLeader(WAKE_TO_FOLLOW_DISTANCE)
end

local function ShouldSleep(inst)
    return DefaultSleepTest(inst) and not 
			inst.sg:HasStateTag("stunned") and 
			inst.components.follower:IsNearLeader(SLEEP_NEAR_LEADER_DISTANCE) and not 
			TheWorld.state.isfullmoon
end

local function IsTurnOff(inst, data)
if inst.components.machine then
	if inst.components.inventory then
	--if inst.components.container then
		--	inst.InventoryIsFull = false
			inst.CanPickEdibleItem = false
			inst.InventoryIsFull = true
			inst.components.inventory:DropEverything(true)
			inst.components.talker:Say("Farm : Off")
		end
	end
end
local function IsTurnOn(inst, data)
if inst.components.machine then
	if inst.components.inventory then
	--if inst.components.container then
		--inst.sg:GoToState("giveitem") 
			inst.CanPickEdibleItem = true
			inst.InventoryIsFull = false
			--inst.components.inventory:DropEverything(true)
			--inst.components.container:DropEverything(true)
			inst.components.talker:Say("Farm : On")
		end
	end
end
local function TakeItem(inst)
if inst.components.inventory:IsFull() then 
--if inst.components.container:IsFull() then 
	if not inst.InventoryIsFull then 
		inst.InventoryIsFull = true
		if inst.CanPickEdibleItem then
			inst.sg:GoToState("hit")
				inst.CanPickEdibleItem = false	
				inst.components.talker:Say("Inventory is Full!")
			end
		end
	end
end

local function retargetfn(inst)
    --Find things attacking leader
    local leader = inst.components.follower:GetLeader()
    return leader ~= nil
        and FindEntity(
            leader,
            TUNING.SHADOWWAXWELL_TARGET_DIST,
            function(guy)
                return guy ~= inst
                    and (guy.components.combat:TargetIs(leader) or
                        guy.components.combat:TargetIs(inst))
                    and inst.components.combat:CanTarget(guy)
            end,
            { "_combat" }, -- see entityreplica.lua
            { "playerghost", "INLIMBO" }
        )
        or nil
end

local function KeepTarget(isnt, target)
    return target and target:IsValid()
end

local function OnAttacked(inst, data)
	if data.attacker ~= nil then
		if data.attacker.components.petleash ~= nil and
			data.attacker.components.petleash:IsPet(inst) and 
				data.attacker:HasTag("QueenAnimator") then
			if inst.components.inventory then
				inst.components.inventory:DropEverything(true) 
			end
			if inst.components.container then
				inst.components.container:DropEverything(true) 
			end
			data.attacker.components.petleash:DespawnPet(inst)
        elseif data.attacker.components.combat ~= nil then
            inst.components.combat:SuggestTarget(data.attacker)
        end
    end
end

local function OnDeath(inst)
--	SpawnPrefab("sand_puff").Transform:SetPosition(inst:GetPosition():Get()) inst.SoundEmitter:PlaySound("dontstarve/common/fireOut")
	if inst.components.inventory then
		inst.components.inventory:DropEverything(true) 
	end
	if inst.components.container then
		inst.components.container:DropEverything(true) 
	end
end

local function OnKilled(inst, data)
	local victim = data.victim
	if victim.components.health:IsDead() then
		inst.components.health:DoDelta(170, 2, true, nil, false)
	end
end

local function OnHit(inst, data)
local other = data.target
if not (other:HasTag("smashable")) then
local fx = SpawnPrefab("tauntfire_fx") fx.Transform:SetScale(0.5, 0.5, 0.5) fx.Transform:SetPosition(other:GetPosition():Get())
		if other and other.components.burnable then
				other.components.health:DoDelta(-10)
				other.components.burnable:Ignite()
		elseif other and other:HasTag("myMaster") then
				inst.components.combat:SetTarget(nil)
				inst.components.combat:GiveUp()
		end
		if other.components.burnable and other.components.burnable:IsBurning() then
			other.components.burnable:Extinguish()
		end
	end
end

local function PlayerProxOnClose(inst)
local leader = inst.components.follower.leader
	if inst.components.follower:IsNearLeader(PLAYERPROX_NEAR_LEADER_DISTANCE) then
			inst.components.locomotor.runspeed = 8
	end 
end

local function PlayerProxOnFar(inst)
local leader = inst.components.follower.leader
	if inst.components.follower:IsNearLeader(PLAYERPROX_NEAR_LEADER_DISTANCE) then
			inst.components.locomotor.runspeed = 10
			inst.components.combat:GiveUp()
	end 
end

local function makefn()
    local inst = CreateEntity()
	inst.entity:AddLight()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeGhostPhysics(inst, 40, .5)
	RemovePhysicsColliders(inst)
--[[
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
]]
    inst:AddTag("_named")
	
	inst:AddTag("piko")
    inst:AddTag("cute")
	inst:AddTag("light")
    inst:AddTag("cutepiko")
    inst:AddTag("companion")
    --inst:AddTag("chester")
    inst:AddTag("notraptrigger")
    inst:AddTag("noauradamage")

	inst.MiniMapEntity:SetIcon("sch_piko_normal.tex")
	inst.MiniMapEntity:SetCanUseCache(false)

    inst.AnimState:SetBank("squirrel")
    inst.AnimState:SetBuild("sch_squirrel_build")
	inst.AnimState:PlayAnimation("idle", true)
	inst.AnimState:Hide("eye_red")
	inst.AnimState:Hide("eye2_red")

    inst.DynamicShadow:SetSize(1, 0.75)
	
	inst.Transform:SetFourFaced()

    inst._ispiko2nd = net_bool(inst.GUID, "_ispiko2nd", "onispikoupdirty")
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        inst._clientpikoup = false
        inst:ListenForEvent("onispikoupdirty", OnIsPikoUPDirty)
        return inst
    end
	
    inst:AddComponent("maprevealable")
    inst.components.maprevealable:SetIconPrefab("globalmapiconunderfog")
	
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "chest"
    inst.components.combat:SetKeepTargetFunction(ShouldKeepTarget)

    inst:AddComponent("health")
	inst.components.health.nofadeout = true
	inst.components.health:SetAbsorptionAmount(0.7)
    inst.components.health:SetMaxHealth(TUNING.CHESTER_HEALTH*2)
    inst.components.health:StartRegen(TUNING.CHESTER_HEALTH_REGEN_AMOUNT, TUNING.CHESTER_HEALTH_REGEN_PERIOD)
	inst.components.health.fire_damage_scale = 0
	
    inst:AddComponent("inspectable")
	inst.components.inspectable:RecordViews()
	
    inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8
    inst.components.locomotor.pathcaps = { allowocean = true }

    inst:AddComponent("follower")
	inst.components.follower:KeepLeaderOnAttacked()
    inst:ListenForEvent("stopfollowing", OnStopFollowing)
    inst:ListenForEvent("startfollowing", OnStartFollowing)
	inst:DoPeriodicTask(1, MyMaster)

	--inst:AddComponent("followersitcommand")

    inst:AddComponent("knownlocations")

    inst:AddComponent("container")
	inst.components.container:WidgetSetup("sch_piko")
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose

	inst.Light:Enable(false)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(150/255, 40/255, 40/255)
    inst.Light:SetFalloff(0.9)
    inst.Light:SetRadius(2)    
	
    inst:AddComponent("named")

	inst.sounds = pikosounds

    MakeHauntableDropFirstItem(inst)
   -- AddHauntableCustomReaction(inst, OnHaunt, false, false, true)
	
	inst.PIko2ndState = "NO"
    inst.CanMorph = CanMorph
    inst.MorphPiko = MorphPiko
    inst:WatchWorldState("phase", CheckForMorph)
--  inst:WatchWorldState("isfullmoon", CheckForMorph)
    inst:ListenForEvent("onclose", CheckForMorph)
	
	inst:DoPeriodicTask(0, UpdateBuild)
	inst:ListenForEvent("gotnewitem", UpdateBuild)

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(2)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

    inst:SetBrain(brain)
--[[	
	inst:AddComponent("talker")
	inst.components.talker.fontsize = 20
	]]
	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(0)
	inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("death", OnDeath)
	
	inst:SetStateGraph("SGpikosch")
    inst.sg:GoToState("idle")
    inst:ListenForEvent("entity_death", function(world, data) entitydeathfn(inst, data) end, TheWorld)


    inst.OnSave = OnSave
    inst.OnPreLoad = OnPreLoad
	
    return inst
end
--------------------------------------------------------------------------------
local function makefarmerfn()
    local inst = CreateEntity()
	inst.entity:AddLight()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeGhostPhysics(inst, 40, .5)
	RemovePhysicsColliders(inst)
--[[
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
]]
    inst:AddTag("_named")
	
	inst:AddTag("piko")
    inst:AddTag("cute")
    inst:AddTag("cutepiko")
    inst:AddTag("companion")
	inst:AddTag("pikofarmer")
	inst:AddTag("noauradamage")
	inst:AddTag("notraptrigger")

	inst.MiniMapEntity:SetIcon("sch_piko_normal.tex")
	inst.MiniMapEntity:SetCanUseCache(false)
	
    inst.AnimState:SetBank("squirrel")
    inst.AnimState:SetBuild("sch_squirrel_build")
	inst.AnimState:PlayAnimation("idle", true)
	
	inst.AnimState:Hide("eye_red")
	inst.AnimState:Hide("eye2_red")

    inst.DynamicShadow:SetSize(1, 0.75)
	
	inst.Transform:SetFourFaced()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("maprevealable")
    inst.components.maprevealable:SetIconPrefab("globalmapiconunderfog")
	
    inst:AddComponent("combat")
    inst.components.combat.hiteffectsymbol = "chest"
    inst.components.combat:SetKeepTargetFunction(ShouldKeepTarget)

    inst:AddComponent("health")
	inst.components.health.nofadeout = true
	inst.components.health:SetAbsorptionAmount(0.9)
    inst.components.health:SetMaxHealth(TUNING.CHESTER_HEALTH)
    inst.components.health:StartRegen(TUNING.CHESTER_HEALTH_REGEN_AMOUNT, TUNING.CHESTER_HEALTH_REGEN_PERIOD)
	inst.components.health.fire_damage_scale = 0
	
    inst:AddComponent("inspectable")
	inst.components.inspectable:RecordViews()
	
    inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8
    inst.components.locomotor.pathcaps = { allowocean = true }

    inst:AddComponent("follower")
	inst.components.follower:KeepLeaderOnAttacked()
    inst:ListenForEvent("stopfollowing", OnStopFollowing)
    inst:ListenForEvent("startfollowing", OnStartFollowing)
	inst:DoPeriodicTask(1, MyMaster)

	--inst:AddComponent("followersitcommand")

    inst:AddComponent("knownlocations")

	inst:AddComponent("inventory")
	inst.components.inventory.maxslots = 400 ---- The power of Stealin' -`- ---> Creator so Lazy
	inst.components.inventory.dropondeath = true
--[[
	inst:AddComponent("machine")
	inst.components.machine.turnonfn = IsTurnOn
	inst.components.machine.turnofffn = IsTurnOff
	inst.components.machine.cooldowntime = 0
	]]
    inst.TakeItem = inst:DoPeriodicTask(1, TakeItem) 

	inst.Light:Enable(false)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(150/255, 40/255, 40/255)
    inst.Light:SetFalloff(0.9)
    inst.Light:SetRadius(2)    
	
    inst:AddComponent("named")

	inst.sounds = pikosounds

    MakeHauntableDropFirstItem(inst)
   -- AddHauntableCustomReaction(inst, OnHaunt, false, false, true)
	
	inst:DoPeriodicTask(0, FarmerUpdateBuild)
	inst:ListenForEvent("gotnewitem", FarmerUpdateBuild)
	inst:ListenForEvent("death", OnDeath)
	
    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(3)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)

    inst:SetBrain(fbrain)

	inst:AddComponent("talker")
	inst.components.talker.fontsize = 20
	inst:ListenForEvent("attacked", OnAttacked)

	inst:SetStateGraph("SGpikosch")
    inst.sg:GoToState("idle")
    inst:ListenForEvent("entity_death", function(world, data) entitydeathfn(inst, data) end, TheWorld)
	
    return inst
end
--------------------------------------------------------------------------------
local function makeattackerfn()
    local inst = CreateEntity()
	inst.entity:AddLight()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddDynamicShadow()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    MakeGhostPhysics(inst, 40, .5)
	RemovePhysicsColliders(inst)
	--MakeCharacterPhysics(inst, 1, 0.12)
--[[
    inst.Physics:SetCollisionGroup(COLLISION.CHARACTERS)
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
]]
    inst:AddTag("_named")
	
	inst:AddTag("piko")
    inst:AddTag("cute")
    inst:AddTag("cutepiko")
    inst:AddTag("companion")
	inst:AddTag("pikoattacker")
	inst:AddTag("noauradamage")
	inst:AddTag("notraptrigger")

	inst.MiniMapEntity:SetIcon("sch_piko_red.tex")
	inst.MiniMapEntity:SetCanUseCache(false)
	
    inst.AnimState:SetBank("squirrel")
    inst.AnimState:SetBuild("sch_squirrel_red_build")
	inst.AnimState:PlayAnimation("idle", true)
	
	inst.AnimState:Hide("eye_red")
	inst.AnimState:Hide("eye2_red")

    inst.DynamicShadow:SetSize(1, 0.75)
	
	inst.Transform:SetFourFaced()

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("maprevealable")
    inst.components.maprevealable:SetIconPrefab("globalmapiconunderfog")
	
    inst:AddComponent("combat")
    inst.components.combat:SetRange(1, 0.7)
    inst.components.combat:SetAttackPeriod(2)
    inst.components.combat:SetDefaultDamage(10)
    inst.components.combat.hiteffectsymbol = "chest"
    inst.components.combat.playerdamagepercent = 0
    inst.components.combat:SetRetargetFunction(1, retargetfn)
    inst.components.combat:SetKeepTargetFunction(KeepTarget)

    inst:AddComponent("health")
	inst.components.health.nofadeout = true
	inst.components.health:SetAbsorptionAmount(0.5)
    inst.components.health:SetMaxHealth(TUNING.CHESTER_HEALTH+TUNING.PIG_HEALTH)
	inst.components.health.fire_damage_scale = 0
	
    inst:AddComponent("inspectable")
	inst.components.inspectable:RecordViews()
	
    inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8
    inst.components.locomotor.pathcaps = { allowocean = true }

    inst:AddComponent("follower")
	inst.components.follower:KeepLeaderOnAttacked()
    inst:ListenForEvent("stopfollowing", OnStopFollowing)
    inst:ListenForEvent("startfollowing", OnStartFollowing)
	inst:DoPeriodicTask(1, MyMaster)

	--inst:AddComponent("followersitcommand")

    inst:AddComponent("knownlocations")
	inst:ListenForEvent("attacked", OnAttacked)
	inst:ListenForEvent("death", OnDeath)
	inst:ListenForEvent("killed", OnKilled)
	inst:ListenForEvent("onhitother", OnHit)

	inst.Light:Enable(false)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.5)
    inst.Light:SetColour(150/255, 40/255, 40/255)
    inst.Light:SetFalloff(0.9)
    inst.Light:SetRadius(2)    
	
    inst:AddComponent("named")

	inst.sounds = pikosounds

    MakeHauntableDropFirstItem(inst)
   -- AddHauntableCustomReaction(inst, OnHaunt, false, false, true)

    inst:AddComponent("sleeper")
    inst.components.sleeper:SetResistance(5)
    inst.components.sleeper.testperiod = GetRandomWithVariance(6, 2)
    inst.components.sleeper:SetSleepTest(ShouldSleep)
    inst.components.sleeper:SetWakeTest(ShouldWakeUp)
	
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(2, 7)
    inst.components.playerprox:SetOnPlayerNear(PlayerProxOnClose)
    inst.components.playerprox:SetOnPlayerFar(PlayerProxOnFar)

    inst:SetBrain(abrain)

	inst:AddComponent("talker")
	inst.components.talker.fontsize = 20

	inst:SetStateGraph("SGpikosch")
    inst.sg:GoToState("idle")
    inst:ListenForEvent("entity_death", function(world, data) entitydeathfn(inst, data) end, TheWorld)
		
    return inst
end
return Prefab( "sch_piko", makefn, assets, prefabs),
		Prefab( "sch_piko_farmer", makefarmerfn, assets, prefabs),
		Prefab( "sch_piko_attacker", makeattackerfn, assets, prefabs)