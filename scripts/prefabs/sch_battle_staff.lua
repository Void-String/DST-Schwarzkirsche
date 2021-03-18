local assets = {

	Asset("ANIM", "anim/sch_battle_staff.zip"),
	Asset("ANIM", "anim/sch_swap_battle_staff.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_battle_staff.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_battle_staff.tex"),
	
}

local function onequip(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "sch_swap_battle_staff", "icestaff")
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
		if inst.BattleActivate then
	  local fx = SpawnPrefab("sch_shot_projectile_fx")
			fx.Transform:SetPosition(x, y, z)
		local fx2 = SpawnPrefab("groundpoundring_fx")
		local pos = Vector3(target.Transform:GetWorldPosition())
			  fx2.Transform:SetScale(0.45, 0.45, 0.45)
			  TheWorld:DoTaskInTime(0.2, function() fx2.Transform:SetPosition(pos:Get()) end)
              target.components.health:DoDelta(-70)
			if target.components.locomotor and not target:HasTag("ghost") then
			   target.components.locomotor.groundspeedmultiplier = 0.1
			end
			if target.components.burnable then
			   target.components.burnable:Ignite()
			end
			if target.components.burnable and target.components.burnable:IsBurning() then
			   target.components.burnable:Extinguish()
			end
		end
	end
end

local function OnUseItem(inst, data)
	if not inst.BattleActivate then
		inst:AddTag("staffz")
		inst.BattleActivate = true
		inst.components.useableitem:StopUsingItem()
		inst.components.weapon:SetProjectile(nil)
	elseif inst.BattleActivate then
		inst:RemoveTag("staffz")
		inst.BattleActivate = false
		inst.components.weapon:SetProjectile("fire_projectile")
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
	
	inst.AnimState:SetBank("icestaff")
    inst.AnimState:SetBuild("sch_battle_staff")
    inst.AnimState:PlayAnimation("idle_90s")  
    
    MakeInventoryPhysics(inst)

    if not TheWorld.ismastersim then
    	return inst
    end

    inst.entity:SetPristine()
    
	inst:AddComponent("finiteuses")
	inst.components.finiteuses:SetMaxUses(TUNING.AXE_USES)
	inst.components.finiteuses:SetUses(TUNING.AXE_USES)
	inst.components.finiteuses:SetOnFinished(inst.Remove)
	
	inst:AddTag("staff")
	inst:AddTag("meteorstaff")
	inst:AddTag("schstuff")

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(OnUseItem)

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_battle_staff.tex" )

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(25) ----------- Fair Damage Please 
    inst.components.weapon:SetRange(10)
	inst.components.weapon:SetOnAttack(OnHit)
	inst.components.weapon:SetProjectile("fire_projectile")

	inst:AddComponent("equippable")
--	inst.components.equippable.keepondeath = true
	inst.components.equippable:SetOnEquip(onequip)
	inst.components.equippable:SetOnUnequip(onunequip)
	
	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")
--	inst.components.inventoryitem.keepondeath = true
	inst.components.inventoryitem.imagename = "sch_battle_staff"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_battle_staff.xml"
	
    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

	MakeHauntableLaunch(inst)

	return inst
end

return Prefab("common/inventory/sch_battle_staff", fn, assets)
