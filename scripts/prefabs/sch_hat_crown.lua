local assets={  
    Asset("ANIM", "anim/sch_hat_crown.zip"),
    Asset("ANIM", "anim/sch_swap_hat_crown.zip"), 
    Asset("ATLAS", "images/inventoryimages/sch_hat_crown.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_hat_crown.tex"),
}

local prefabs = { }

local function disable_crown_task(inst)
    if inst.updatetask ~= nil then
        inst.updatetask:Cancel()
        inst.updatetask = nil
    end
end

local function pigqueen_update( inst )  --돼지 팔로워 
    local owner = inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner ~= nil and inst.components.inventoryitem.owner.components.leader ~= nil and inst.components.inventoryitem.owner

    local x,y,z = owner.Transform:GetWorldPosition()
    local ents = TheSim:FindEntities(x,y,z, TUNING.ONEMANBAND_RANGE, { "pig" }, { "werepig" })
    for k,v in pairs(ents) do
        if v.components.follower ~= nil and not v.components.follower.leader ~= nil and not owner.components.leader:IsFollower(v) and owner.components.leader.numfollowers < 10 then
            owner.components.leader:AddFollower(v)
        end
    end
		
    for k,v in pairs(owner.components.leader.followers) do
        if k:HasTag("pig") and k.components.follower ~= nil then
            k.components.follower:AddLoyaltyTime(1.5)
        end
    end	
end

local function sendi_hat_crown_enable(inst) --돼지 팔로워 
    inst.updatetask = inst:DoPeriodicTask(1, pigqueen_update, 1)
end


local function band_perish(inst)
    disable_crown_task(inst)
    inst:Remove()
end

local function OnEquip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_hat", "sch_swap_hat_crown", "swap_hat")
	owner.AnimState:OverrideSymbol("swap_hat", "sch_hat_crown", "swap_hat")
    owner.AnimState:Show("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Hide("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
	
	sendi_hat_crown_enable(inst)	
	owner:AddTag("ignoreMeat")
	
	inst.isWeared = true
	inst.isDropped = false	
	
	inst.components.fueled:StartConsuming()

end

local function OnUnequip(inst, owner) 
    owner.AnimState:Hide("HAT")
    owner.AnimState:Hide("HAT_HAIR")
    owner.AnimState:Show("HAIR_NOHAT")
    owner.AnimState:Show("HAIR")
	
	disable_crown_task(inst)
	owner:RemoveTag("ignoreMeat")
	
	inst.isWeared = false
	inst.isDropped = false
	
	inst.components.fueled:StopConsuming()
	
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
    
    inst.AnimState:SetBank("sendi_hat_crown")
    inst.AnimState:SetBuild("sch_hat_crown")
    inst.AnimState:PlayAnimation("idle")

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon("sch_hat_crown.tex")

	inst:AddTag("hat")
	inst:AddTag("crown")
	
	if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine()

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_hat_crown"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_hat_crown.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)

	inst:AddComponent("waterproofer")
    inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_SMALLMED)

    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.ONEMANBAND
	inst.components.fueled:InitializeFuelLevel(TUNING.GRASS_UMBRELLA_PERISHTIME)
    inst.components.fueled:SetDepletedFn(band_perish)

    inst:AddComponent("inspectable")
	
    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 
	
	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)
	
    return inst
end


return  Prefab("sch_hat_crown", fn, assets, prefabs)