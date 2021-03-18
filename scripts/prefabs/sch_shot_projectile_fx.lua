local assets =
{
    Asset("ANIM", "anim/sch_shot_projectile_fx.zip"),
}

local function PlayImpactAnim(proxy)
    local inst = CreateEntity()

    inst:AddTag("FX")
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    inst.Transform:SetFromProxy(proxy.GUID)
    
    inst.AnimState:SetBank("cannonshot")
    inst.AnimState:SetBuild("sch_shot_projectile_fx")
    inst.AnimState:PlayAnimation("cannon_shot_explode")
    
    inst:ListenForEvent("animover", inst.Remove)
end



local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddNetwork()

    if not TheNet:IsDedicated() then
        inst:DoTaskInTime(0, PlayImpactAnim)
    end

    inst.Transform:SetTwoFaced()

    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false
    inst:DoTaskInTime(0.5, inst.Remove)

    return inst
end

return Prefab("common/fx/sch_shot_projectile_fx", fn, assets)