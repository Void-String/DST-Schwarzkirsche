local assets = 
{
   Asset("ANIM", "anim/sch_darkshield_fx.zip")
}

local function kill_fx(inst)
    inst.AnimState:PlayAnimation("close")
    inst.components.lighttweener:StartTween(nil, 0, .9, 0.9, nil, .2)
    inst:DoTaskInTime(0.6, inst.Remove)
end

local function fn(Sim)
local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
	inst.entity:AddLight()
	inst.entity:AddNetwork()
    inst.AnimState:SetBank("forcefield")
    inst.AnimState:SetBuild("sch_darkshield_fx")
    inst.AnimState:PlayAnimation("open")
    inst.AnimState:PushAnimation("idle_loop", true)
    inst:AddComponent("lighttweener")
    inst.components.lighttweener:StartTween(inst.Light, 0, .9, 0.9, {1,1,1}, 0)
    inst.components.lighttweener:StartTween(nil, 3, .9, 0.9, nil, .2)
    inst.kill_fx = kill_fx
    inst.SoundEmitter:PlaySound("dontstarve/wilson/forcefield_LP", "loop")
    if not TheWorld.ismastersim then
        return inst
    end
	inst.entity:SetPristine()
    return inst
end

return Prefab( "common/sch_darkshield_fx", fn, assets) 
