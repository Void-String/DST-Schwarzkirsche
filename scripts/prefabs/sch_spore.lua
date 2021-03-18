local assets =
{
    Asset("ANIM", "anim/sch_spore.zip"),
    Asset("ANIM", "anim/sch_spore_red.zip"),
    Asset("ANIM", "anim/sch_spore_blue.zip"),
}

local brain = require "brains/schsporebrain"

local data =
{
    grensp =
    { --Green
        build = "sch_spore",
        lightcolour = {146/255, 225/255, 146/255},
    },
    redsp =
    { --Red
        build = "sch_spore_red",
        lightcolour = {197/255, 126/255, 126/255},
    },
    bluesp =
    { --Blue
        build = "sch_spore_blue",
        lightcolour = {111/255, 111/255, 227/255},
    },
}

local function depleted(inst)
    if inst:IsInLimbo() then
        inst:Remove()
    else
        inst:PushEvent("death")
        inst:RemoveTag("spore")
        inst.persists = false
        inst:DoTaskInTime(3, inst.Remove)
    end
end

local function RedDead(inst)
    if inst:IsInLimbo() then
        inst:Remove()
    else
        inst:PushEvent("death")
        inst:RemoveTag("spore")
        inst.persists = false
        inst:DoTaskInTime(3, inst.Remove)
    end
	inst.RedSporeisDead = true
end

local function MyMaster(inst, data)
local leader = inst.components.follower.leader
if not inst.components.follower.leader then
		depleted(inst)
	end 	
end

local function checkforcrowding(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local spores = TheSim:FindEntities(x,y,z, TUNING.MUSHSPORE_MAX_DENSITY_RAD, {"spore"})
    if #spores > TUNING.MUSHSPORE_MAX_DENSITY then
        inst.components.perishable:SetPercent(0)
    else
        inst.crowdingtask = inst:DoTaskInTime(TUNING.MUSHSPORE_DENSITY_CHECK_TIME + math.random()*TUNING.MUSHSPORE_DENSITY_CHECK_VAR, checkforcrowding)
    end
end

local function onload(inst)
    inst.Light:Enable(true)
    inst.DynamicShadow:Enable(true)
end

local function makespore(data)
	local function fn()
	local inst = CreateEntity()
		
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.entity:AddLight()
	inst.entity:AddNetwork()

	inst.AnimState:SetBuild(data.build)
	inst.AnimState:SetBank("mushroom_spore")
	inst.AnimState:PlayAnimation("flight_cycle", true)

	inst.DynamicShadow:Enable(true)
	inst.DynamicShadow:SetSize(.8, .5)
	MakeCharacterPhysics(inst, 1, .5)

	inst.Light:SetColour(unpack(data.lightcolour))
	inst.Light:SetIntensity(0.75)
	inst.Light:SetFalloff(0.5)
	inst.Light:SetRadius(2)
	inst.Light:Enable(true)

	inst:AddTag("spore")
	inst:AddTag("schspore")
	inst:AddTag("greenspore")
	inst:AddTag("counterspore")
	inst:AddTag("schstuff")

	inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("follower")
	inst.components.follower:KeepLeaderOnAttacked()
--	inst:DoPeriodicTask(0, MyMaster)

	inst:AddComponent("inspectable")
	inst:AddComponent("knownlocations")

	inst:AddComponent("locomotor")
	inst.components.locomotor:EnableGroundSpeedMultiplier(false)
	inst.components.locomotor:SetTriggersCreep(false)
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 9
	
	inst:AddComponent("perishable")
	inst.components.perishable:StartPerishing()
	inst.components.perishable:SetOnPerishFn(depleted)
	inst.components.perishable:SetPerishTime(20)

	inst:SetStateGraph("SGschspore")
	inst:SetBrain(brain)
	
	inst.crowdingtask = inst:DoTaskInTime(1 + math.random()*TUNING.MUSHSPORE_DENSITY_CHECK_VAR, checkforcrowding)

	inst.OnLoad = onload

        return inst
	end

	return fn
end

local function makesporeblue(data)
	local function fn()
	local inst = CreateEntity()
		
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.entity:AddLight()
	inst.entity:AddNetwork()

	inst.AnimState:SetBuild(data.build)
	inst.AnimState:SetBank("mushroom_spore")
	inst.AnimState:PlayAnimation("flight_cycle", true)

	inst.DynamicShadow:Enable(true)
	inst.DynamicShadow:SetSize(.8, .5)
	MakeCharacterPhysics(inst, 1, .5)

	inst.Light:SetColour(unpack(data.lightcolour))
	inst.Light:SetIntensity(0.75)
	inst.Light:SetFalloff(0.5)
	inst.Light:SetRadius(2)
	inst.Light:Enable(true)

	inst:AddTag("spore")
	inst:AddTag("schspore")
	inst:AddTag("bluespore")
	inst:AddTag("counterspore")
	inst:AddTag("schstuff")

	inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("follower")
	inst.components.follower:KeepLeaderOnAttacked()
--	inst:DoPeriodicTask(0, MyMaster)

	inst:AddComponent("inspectable")
	inst:AddComponent("knownlocations")

	inst:AddComponent("locomotor")
	inst.components.locomotor:EnableGroundSpeedMultiplier(false)
	inst.components.locomotor:SetTriggersCreep(false)
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 9
	
	inst:AddComponent("perishable")
	inst.components.perishable:StartPerishing()
	inst.components.perishable:SetOnPerishFn(depleted)
	inst.components.perishable:SetPerishTime(30)

	inst:SetStateGraph("SGschspore")
	inst:SetBrain(brain)
	
	inst.crowdingtask = inst:DoTaskInTime(1 + math.random()*TUNING.MUSHSPORE_DENSITY_CHECK_VAR, checkforcrowding)

	inst.OnLoad = onload

        return inst
	end

	return fn
end

local function makesporered(data)
	local function fn()
	local inst = CreateEntity()
		
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.entity:AddLight()
	inst.entity:AddNetwork()

	inst.AnimState:SetBuild(data.build)
	inst.AnimState:SetBank("mushroom_spore")
	inst.AnimState:PlayAnimation("flight_cycle", true)

	inst.DynamicShadow:Enable(true)
	inst.DynamicShadow:SetSize(.8, .5)
	MakeCharacterPhysics(inst, 1, .5)

	inst.Light:SetColour(unpack(data.lightcolour))
	inst.Light:SetIntensity(0.75)
	inst.Light:SetFalloff(0.5)
	inst.Light:SetRadius(2)
	inst.Light:Enable(true)

	inst:AddTag("spore")
	inst:AddTag("schspore")
	inst:AddTag("redspore")
	inst:AddTag("counterspore")
	inst:AddTag("schstuff")

	inst.entity:SetPristine()
	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("follower")
	inst.components.follower:KeepLeaderOnAttacked()
--	inst:DoPeriodicTask(0, MyMaster)

	inst:AddComponent("inspectable")
	inst:AddComponent("knownlocations")

	inst:AddComponent("locomotor")
	inst.components.locomotor:EnableGroundSpeedMultiplier(false)
	inst.components.locomotor:SetTriggersCreep(false)
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 9
	
	inst:AddComponent("perishable")
	inst.components.perishable:StartPerishing()
	inst.components.perishable:SetOnPerishFn(RedDead)
	inst.components.perishable:SetPerishTime(40)

	inst:SetStateGraph("SGschspore")
	inst:SetBrain(brain)
	
	inst.crowdingtask = inst:DoTaskInTime(1 + math.random()*TUNING.MUSHSPORE_DENSITY_CHECK_VAR, checkforcrowding)

	inst.OnLoad = onload

        return inst
	end

	return fn
end

return Prefab("sch_spore_blue", makesporeblue(data.bluesp), assets),
    Prefab("sch_spore_red", makesporered(data.redsp), assets),
    Prefab("sch_spore", makespore(data.grensp), assets)
