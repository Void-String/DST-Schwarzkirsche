local assets =
{ 		
	Asset("ANIM", "anim/sch_dark_soul_fx.zip"),
	
}

local TINT = { r = 154 / 255, g = 23 / 255, b = 19 / 255 }

local function OnUpdateTargetTint(inst)--, dt)
    if inst._tinttarget:IsValid() then
        local curframe = inst.AnimState:GetCurrentAnimationTime() / FRAMES
        if curframe < 10 then
            local k = curframe / 10 * .5
            if inst._tinttarget.components.colouradder ~= nil then
                inst._tinttarget.components.colouradder:PushColour(inst, TINT.r * k, TINT.g * k, TINT.b * k, 0)
            end
        elseif curframe < 40 then
            local k = (curframe - 10) / 30
            k = (1 - k * k) * .5
            if inst._tinttarget.components.colouradder ~= nil then
                inst._tinttarget.components.colouradder:PushColour(inst, TINT.r * k, TINT.g * k, TINT.b * k, 0)
            end
        else
            inst.components.updatelooper:RemoveOnUpdateFn(OnUpdateTargetTint)
            if inst._tinttarget.components.colouradder ~= nil then
                inst._tinttarget.components.colouradder:PopColour(inst)
            end
        end
    else
        inst.components.updatelooper:RemoveOnUpdateFn(OnUpdateTargetTint)
    end
end

local function Setup(inst, target)
    if inst.components.updatelooper == nil then
        inst:AddComponent("updatelooper")
        inst.components.updatelooper:AddOnUpdateFn(OnUpdateTargetTint)
        inst._tinttarget = target
    end
    if target.SoundEmitter ~= nil then
        target.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/heal")
    end
end

local function fn()
	local inst = CreateEntity()
	
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("wortox_soul_heal_fx")
	inst.AnimState:SetBuild("sch_dark_soul_fx")
	inst.AnimState:PlayAnimation("heal")
    inst.AnimState:SetScale(.8, .8)
    inst.AnimState:SetFinalOffset(-1)
    inst.AnimState:SetScale(1.5, 1.5)
    inst.AnimState:SetDeltaTimeMultiplier(2)

	inst.entity:SetPristine()
	
	if not TheWorld.ismastersim then
        return inst
    end

    inst:AddTag("FX")
	inst:AddTag("schsoulfx")
	inst:AddTag("darksoulfx")
	inst:AddTag("schwarzkirschesoulfx")
	
     if not TheWorld.ismastersim then
        return inst
    end

    if math.random() < .5 then
        inst.AnimState:SetScale(-1.5, 1.5)
    end

    inst:ListenForEvent("animover", inst.Remove)
    inst.persists = false
    inst.Setup = Setup

    return inst
end

return Prefab( "common/inventory/sch_dark_soul_fx", fn, assets, prefabs)
