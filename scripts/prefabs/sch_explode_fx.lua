local assets =
{
    Asset("ANIM", "anim/sch_explode_fx.zip"),
}

local function PlayFXAnim(proxy)
    local inst = CreateEntity()

    inst:AddTag("FX")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    inst.Transform:SetFromProxy(proxy.GUID)

    inst.AnimState:SetBank("explode")
    inst.AnimState:SetBuild("sch_explode_fx")
    inst.AnimState:PlayAnimation("small")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetFinalOffset(1)

    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")

    inst:ListenForEvent("animover", inst.Remove)
end
local function PlayFXAnim1(proxy)
    local inst = CreateEntity()

    inst:AddTag("FX")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()

    inst.Transform:SetFromProxy(proxy.GUID)

    inst.AnimState:SetBank("explode")
    inst.AnimState:SetBuild("sch_explode_fx")
    inst.AnimState:PlayAnimation("small_firecrackers")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetLightOverride(1)
    inst.AnimState:SetFinalOffset(1)

    inst.SoundEmitter:PlaySound("dontstarve/common/blackpowder_explo")

    inst:ListenForEvent("animover", inst.Remove)
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddNetwork()
    inst.entity:SetPristine()
	
    inst:AddTag("FX")

    if not TheNet:IsDedicated() then
        inst:DoTaskInTime(0, PlayFXAnim)
    end

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end
local function fn1()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddNetwork()
    inst.entity:SetPristine()
	
    inst:AddTag("FX")

    if not TheNet:IsDedicated() then
        inst:DoTaskInTime(0, PlayFXAnim1)
    end

    if not TheWorld.ismastersim then
        return inst
    end

    return inst
end


return Prefab("sch_explode_fx_1", fn, assets),
		Prefab("sch_explode_fx_2", fn1, assets),
		Prefab("sch_explode_fx", fn1, assets) ---- Client LOG