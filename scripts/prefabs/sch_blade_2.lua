local assets = {

	Asset("ANIM", "anim/sch_blade_2.zip"),
	Asset("ANIM", "anim/sch_swap_blade_2.zip"),

	Asset("ATLAS", "images/inventoryimages/sch_blade_2.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_blade_2.tex"),

}

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "sch_swap_blade_2", "bladeclaw")
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function onunequip(inst, owner)
	owner.AnimState:Hide("ARM_carry")
	owner.AnimState:Show("ARM_normal")
end

local function OnHit(inst, owner, target)
if target ~= nil and target:IsValid() then
local x, y, z = target.Transform:GetWorldPosition()
		if math.random() < 0.4 then
	  local fx = SpawnPrefab("sch_shot_projectile_fx")
			fx.Transform:SetPosition(x, y, z)
			target.components.health:DoDelta(-60)
		end
	end
    if not target:HasTag("wall") then
		if owner.components.sanity then
		   owner.components.sanity:DoDelta(-0.5)
		end
	end
end

local function OnUseItem(inst, data)
	if not inst.Combo_Mode then
		inst:AddTag("splitrweaps")
		inst.Combo_Mode = true
		inst.components.useableitem:StopUsingItem()
	elseif inst.Combo_Mode then
		inst:RemoveTag("splitrweaps")
		inst.Combo_Mode = false
		inst.components.useableitem:StopUsingItem()
	end
end 

local function OnChosen(inst,owner)
	return owner.prefab == "schwarzkirsche"
end 

local function fn(Sim)
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
	inst.AnimState:SetBank("bladeclaw")
    inst.AnimState:SetBuild("sch_blade_2")
    inst.AnimState:PlayAnimation("idle")  
    
    MakeInventoryPhysics(inst)

    if not TheWorld.ismastersim then
    	return inst
    end

    inst.entity:SetPristine()
    
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(TUNING.WATHGRITHR_SPEAR_USES)
	inst.components.finiteuses:SetUses(TUNING.WATHGRITHR_SPEAR_USES)
	inst.components.finiteuses:SetOnFinished(inst.Remove)
	
	inst:AddTag("sharp")

--	inst:AddComponent("useableitem")
--	inst.components.useableitem:SetOnUseFn(OnUseItem)

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_blade_2.tex" )

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(30) ----------- Fair Damage ? 
	inst.components.weapon:SetRange(.5, 2)
	inst.components.weapon:SetOnAttack(OnHit)

	inst:AddComponent("equippable")
--	inst.components.equippable.keepondeath = true
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")
--	inst.components.inventoryitem.keepondeath = true
	inst.components.inventoryitem.imagename = "sch_blade_2"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_blade_2.xml"
	
    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

	MakeHauntableLaunch(inst)

	return inst
end

return Prefab("common/inventory/sch_blade_2", fn, assets)
