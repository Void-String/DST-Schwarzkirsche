local assets =
{
   Asset("ANIM", "anim/sch_markfx.zip"),
}

local function PlayerProxOnClose(inst)
    inst.AnimState:PlayAnimation("weak_fx")
    inst.AnimState:PushAnimation("weak_fx", true)
end

local function PlayerProxOnFar(inst)
	inst:DoTaskInTime(1, inst.Remove)
end

local function kill_fx(inst)
    inst:DoTaskInTime(0, inst.Remove)
end

local function weakfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst:AddTag("NOCLICK")

    inst.AnimState:SetBank("weak_fx")
    inst.AnimState:SetBuild("sch_markfx")
    inst.AnimState:PlayAnimation("weak_fx")
    inst.AnimState:PushAnimation("weak_fx", true)

    inst.entity:SetPristine()

    inst.kill_fx = kill_fx
	
    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(5, 10)
    inst.components.playerprox:SetOnPlayerNear(PlayerProxOnClose)
    inst.components.playerprox:SetOnPlayerFar(PlayerProxOnFar)
	
    return inst
end

return Prefab("sch_markfx", weakfn, assets)