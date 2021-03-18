local assets =
{
        Asset("ANIM", "anim/sch_dead_gems.zip"),
        Asset("IMAGE", "images/inventoryimages/sch_dead_gems.tex"),
        Asset("ATLAS", "images/inventoryimages/sch_dead_gems.xml"),
}
    
local function fn()
	local inst = CreateEntity()

	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()

	MakeInventoryPhysics(inst)

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_dead_gems.tex" )

	inst.AnimState:SetBank("armorcoin")
	inst.AnimState:SetBuild("sch_dead_gems")
	inst.AnimState:PlayAnimation("idle")

	inst.entity:SetPristine()

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_dead_gems.xml"
	inst.components.inventoryitem.imagename = "sch_dead_gems"

	return inst
end

return Prefab("sch_dead_gems", fn, assets)