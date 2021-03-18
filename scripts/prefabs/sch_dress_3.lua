local assets =
{
    Asset("ANIM", "anim/sch_dress_3.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_dress_3.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_dress_3.tex"),
}

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "sch_dress_3", "swap_body")
    if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end
    if owner.components.health ~= nil then
        owner.components.health.externalfiredamagemultipliers:SetModifier(inst, 1 - TUNING.ARMORDRAGONFLY_FIRE_RESIST)
    end
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end
    if owner.components.health ~= nil then
        owner.components.health.externalfiredamagemultipliers:RemoveModifier(inst)
    end
end

local function ChangeInsulation(inst, temperature)
	if temperature < 5 then 
		inst.components.insulator:SetWinter()
	else
		inst.components.insulator:SetSummer()
	end
end

local function OnChosen(inst,owner)
	return owner.prefab == "schwarzkirsche"
end 

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_dress_3.tex" )

    MakeInventoryPhysics(inst)

	inst:AddTag("Dress")
	inst:AddTag("Dress3rd")
	inst:AddTag("SchDress")
	inst:AddTag("BattleDress")
	inst:AddTag("BattleDress")
	
    inst.AnimState:SetBank("backpack1")
    inst.AnimState:SetBuild("sch_dress_3")
    inst.AnimState:PlayAnimation("anim")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst:AddComponent("inspectable")
	
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.canonlygoinpocket = true
	inst.components.inventoryitem.imagename = "sch_dress_3"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_dress_3.xml"

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

	inst:AddComponent("insulator")
    inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE) 
--[[
    inst:AddComponent("heater")
    inst.components.heater:SetThermics(true, true)
    inst.components.heater.equippedheat = TUNING.BLUEGEM_COOLER
]]
	ChangeInsulation(inst, TheWorld.state.temperature) 
	inst:WatchWorldState("temperature", ChangeInsulation)

    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)
	
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("krampus_sack")

    return inst
end

return Prefab("common/inventory/sch_dress_3", fn, assets)