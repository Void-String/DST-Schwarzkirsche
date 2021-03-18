local assets =
{
    Asset("ANIM", "anim/sch_tentacle_arm.zip"),
    Asset("ANIM", "anim/sch_tentacle_arm_black_build.zip"),
    Asset("SOUND", "sound/tentacle.fsb"),
}

local function shouldKeepTarget()
    return true
end

local MY_CHANCE = 0.4

local function IceTentacle(inst, data)
local other = data.target
if math.random() < MY_CHANCE then
if inst.prefab == "sch_shadowtentacle_ice" then
if not other:HasTag("smashable") then
	if other and other.components.freezable then
				 other.components.freezable:AddColdness(0.2)
				 other.components.freezable:SpawnShatterFX()
					if other.components.burnable and 
					   other.components.burnable:IsBurning() then
					   other.components.burnable:Extinguish()
					end
				end
			end
		end
	end
end

local function FireTentacle(inst, data)
local other = data.target
if math.random() < MY_CHANCE then
if inst.prefab == "sch_shadowtentacle_fire" then
if not (other:HasTag("smashable")) then
				if other and other.components.burnable then
				   other.components.burnable:Ignite()
				end
				if other.components.burnable and other.components.burnable:IsBurning() then
				   other.components.burnable:Extinguish()
				end
			end
		end
	end
end
	
local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

    inst.entity:AddPhysics()
    inst.Physics:SetCylinder(0.25, 2)

    inst.Transform:SetScale(0.5, 0.5, 0.5)

    inst.AnimState:SetMultColour(1, 1, 1, 0.5)

    inst.AnimState:SetBank("tentacle_arm")
    inst.AnimState:SetBuild("sch_tentacle_arm_black_build")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("shadow")
    inst:AddTag("notarget")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("health")
    inst.components.health:SetMaxHealth(TUNING.TENTACLE_HEALTH)

    inst:AddComponent("combat")
    inst.components.combat:SetRange(2)
    inst.components.combat:SetDefaultDamage(TUNING.TENTACLE_DAMAGE)
    inst.components.combat:SetAttackPeriod(TUNING.TENTACLE_ATTACK_PERIOD)
    inst.components.combat:SetKeepTargetFunction(shouldKeepTarget)
	
	inst:ListenForEvent("onhitother", IceTentacle)
	inst:ListenForEvent("onhitother", FireTentacle)

    MakeLargeFreezableCharacter(inst)

    inst:AddComponent("sanityaura")
    inst.components.sanityaura.aura = -TUNING.SANITYAURA_MED

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot({})

    inst:SetStateGraph("SGschshadowtentacle")

    inst:DoTaskInTime(9, inst.Remove)
	inst.persists = false

    return inst
end

return Prefab("marsh/monsters/sch_shadowtentacle_ice", fn, assets),
		Prefab("marsh/monsters/sch_shadowtentacle_fire", fn, assets),
		Prefab("marsh/monsters/sch_shadowtentacle", fn, assets) ------------- Client LOG
