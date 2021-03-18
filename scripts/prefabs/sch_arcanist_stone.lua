local assets =
{ 		
	Asset("ANIM", "anim/sch_arcanist_stone.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_arcanist_stone.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_arcanist_stone.tex"),
}

local function HeatFn(inst, observer)
    return 40
end

local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	
	MakeInventoryPhysics(inst)
	
	inst.AnimState:SetBank("purplegem")
	inst.AnimState:SetBuild("sch_arcanist_stone")
	inst.AnimState:PlayAnimation("idle")     
	
	if not TheWorld.ismastersim then
        return inst
    end
	
	inst:AddTag("gems")
	inst:AddTag("arcaniststone")
	inst:AddTag("schwarzkirschestone")
	
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_arcanist_stone.tex" )
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_arcanist_stone"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_arcanist_stone.xml" 
		
    inst:AddComponent("fueled")
    inst.components.fueled.fueltype = FUELTYPE.USAGE
    inst.components.fueled:InitializeFuelLevel(100)
    inst.components.fueled:SetDepletedFn(inst.Remove)
	
    inst:AddComponent("heater")
    inst.components.heater.heatfn = HeatFn
    inst.components.heater.carriedheatfn = HeatFn
    inst.components.heater.carriedheatmultiplier = TUNING.HEAT_ROCK_CARRIED_BONUS_HEAT_FACTOR
    inst.components.heater:SetThermics(false, false)

	inst:AddComponent("inspectable")

	return inst
end

return Prefab( "common/inventory/sch_arcanist_stone", fn, assets, prefabs)
