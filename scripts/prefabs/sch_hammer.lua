local assets=
{
	Asset("ANIM", "anim/sch_hammer.zip"),
	Asset("ANIM", "anim/sch_swap_hammer.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_hammer.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_hammer.tex"),
}
local prefabs =
{

}

local function OnEquiped(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "sch_swap_hammer", "frosthammer")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
end

local function OnUnequied(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
end

local function OnPutInInventory(inst, data)

end

local function OnAttack(inst, owner, target)
if target ~= nil and target:IsValid() then
local x, y, z = target.Transform:GetWorldPosition()
	if not inst.ActiveWeapon then
		local fx = SpawnPrefab("groundpoundring_fx")
		local fx2 = SpawnPrefab("groundpoundring_fx")
		local pos = Vector3(target.Transform:GetWorldPosition())
			fx.Transform:SetScale(0.3, 0.3, 0.3)
			fx2.Transform:SetScale(0.45, 0.45, 0.45)
			fx.Transform:SetPosition(pos:Get())
			TheWorld:DoTaskInTime(0.2, function() fx2.Transform:SetPosition(pos:Get()) end)
	elseif inst.ActiveWeapon then
		local fx_1 = SpawnPrefab("hammer_mjolnir_crackle")
		local fx_2 = SpawnPrefab("hammer_mjolnir_cracklebase")
		      fx_1.Transform:SetPosition(x, y, z)
		      fx_2.Transform:SetPosition(x, y, z)
			  target.components.health:DoDelta(-80)
		end
	end
end

local function OnActivate(inst, data)
	if not inst.ActiveWeapon then
		inst:RemoveTag("hammerweaps")
		inst:AddTag("splitrweaps")
		inst.ActiveWeapon = true
		inst.components.useableitem:StopUsingItem()
	elseif inst.ActiveWeapon then
		inst:AddTag("hammerweaps")
		inst:RemoveTag("splitrweaps")
		inst.ActiveWeapon = false
		inst.components.useableitem:StopUsingItem()
	end
end

local function ReticuleTargetFn()
    local player = ThePlayer
    local ground = TheWorld.Map
    local pos = Vector3()
    for r = 7, 0, -.25 do
        pos.x, pos.y, pos.z = player.entity:LocalToWorldSpace(r, 0, 0)
        if ground:IsPassableAtPoint(pos:Get()) and not ground:IsGroundTargetBlocked(pos) then
            return pos
        end
    end
    return pos
end

local function OnChosen(inst,owner)
	return owner.prefab == "schwarzkirsche"
end 

local function fn()
local inst = CreateEntity()
	inst.entity:AddTransform()
    inst.entity:AddAnimState()
	inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:AddMiniMapEntity()
	inst.entity:SetPristine()	

	MakeInventoryPhysics(inst)  

	inst:AddTag("tools")
	inst:AddTag("hammer")
	inst:AddTag("schitems")
	inst:AddTag("modifieditem")
	inst:AddTag("sunnyitem")
	inst:AddTag("hammerweaps")

    inst.AnimState:SetBank("frosthammer")
    inst.AnimState:SetBuild("sch_hammer")
    inst.AnimState:PlayAnimation("idle")
	inst.MiniMapEntity:SetIcon( "sch_hammer.tex" )

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.HAMMER)
	
	inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(30)
    inst.components.weapon:SetOnAttack(OnAttack)
	inst.components.weapon:SetRange(1.6, 2)
--[[
    inst:AddComponent("aoetargeting")
    inst.components.aoetargeting.reticule.reticuleprefab = "reticuleaoe"
    inst.components.aoetargeting.reticule.pingprefab = "reticuleaoeping"
    inst.components.aoetargeting.reticule.targetfn = ReticuleTargetFn
    inst.components.aoetargeting.reticule.validcolour = { 1, .75, 0, 1 }
    inst.components.aoetargeting.reticule.invalidcolour = { .5, 0, 0, 1 }
    inst.components.aoetargeting.reticule.ease = true
    inst.components.aoetargeting.reticule.mouseenabled = true
]]
    if not TheWorld.ismastersim then
		return inst
	end
	
    inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_hammer"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_hammer.xml"
	inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutInInventory)

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquiped)
    inst.components.equippable:SetOnUnequip(OnUnequied)

    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetMaxUses(TUNING.MULTITOOL_AXE_PICKAXE_USES)
    inst.components.finiteuses:SetUses(TUNING.MULTITOOL_AXE_PICKAXE_USES)
    inst.components.finiteuses:SetOnFinished(inst.Remove)

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(OnActivate)

    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

    MakeHauntableLaunch(inst)
 
    return inst

end

return Prefab( "common/inventory/sch_hammer", fn, assets, prefabs) 