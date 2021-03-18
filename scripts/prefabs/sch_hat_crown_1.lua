local assets={  
    Asset("ANIM", "anim/sch_hat_crown_1.zip"),
    Asset("ATLAS", "images/inventoryimages/sch_hat_crown_1.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_hat_crown_1.tex"),
}

local prefabs = { }

local function StopHidding(inst, data)
	local hat = inst.components.inventory ~= nil and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) or nil
	if hat ~= nil and data.statename ~= "hide" then
		hat.components.useableitem:StopUsingItem()
	end
end

local function OnEquip(inst, owner) 
	owner.AnimState:OverrideSymbol("swap_hat", "sch_hat_crown_1", "swap_hat")
	owner.AnimState:Show("HAT")
	owner.AnimState:Show("HAT_HAIR")
	owner.AnimState:Hide("HAIR_NOHAT")
	owner.AnimState:Hide("HAIR")
	inst:ListenForEvent("newstate", StopHidding, owner)
	inst.components.fueled:StartConsuming()
end

local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
	inst:RemoveEventCallback("newstate", StopHidding, owner)
	inst.components.fueled:StopConsuming()
end

local function OnUse(inst)
	local owner = inst.components.inventoryitem.owner
	if owner then
		owner.sg:GoToState("hide")
	end
end

local function OnChosen(inst,owner)
	return owner.prefab == "schwarzkirsche"
end 

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddNetwork()
    inst.entity:AddAnimState()
    inst.entity:SetPristine()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    MakeHauntableLaunch(inst)
    
    inst.AnimState:SetBank("bushhat")
    inst.AnimState:SetBuild("sch_hat_crown_1")
    inst.AnimState:PlayAnimation("anim")

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon("sch_hat_crown_1.tex")

	inst:AddTag("hat")
	inst:AddTag("crown")
	inst:AddTag("schstuff")
	inst:AddTag("queencrown")
	
	if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine()

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_hat_crown_1"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_hat_crown_1.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_MED)

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.ONEMANBAND
	inst.components.fueled:InitializeFuelLevel(TUNING.UMBRELLA_PERISHTIME)
    inst.components.fueled:SetDepletedFn(inst.Remove)

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(OnUse)
	
    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

    inst:AddComponent("inspectable")
	
    return inst
end


return Prefab("common/inventory/sch_hat_crown_1", fn, assets, prefabs)