local assets =
{
    Asset("ANIM", "anim/sch_dress_2.zip"),
    Asset("ATLAS", "images/inventoryimages/sch_dress_2.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_dress_2.tex"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "sch_dress_2", "swap_body")
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
end

local function OnChosen(inst,owner)
	return owner.prefab == "schwarzkirsche"
end 

local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sendi_armor_02")
    inst.AnimState:SetBuild("sch_dress_2")
    inst.AnimState:PlayAnimation("anim")

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_dress_2.tex" )

	inst:AddTag("sleevefix") 
	inst:AddTag("sendis") 

    if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine()

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_dress_2"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_dress_2.xml"

	inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.DAPPERNESS_SMALL) 

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_TINY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)
	
	inst:AddComponent("armor")
	inst.components.armor:InitCondition(TUNING.ARMORWOOD, TUNING.ARMORWOOD_ABSORPTION)
	
	MakeHauntableLaunch(inst)

    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

    return inst
end

return Prefab("common/inventory/sch_dress_2", fn, assets)