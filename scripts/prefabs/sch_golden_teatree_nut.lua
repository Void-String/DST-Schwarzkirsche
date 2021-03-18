local assets =
{ 		
	Asset("ANIM", "anim/sch_golden_teatree_nut.zip"),
	Asset("ATLAS", "images/map_icons/sch_golden_teatree_nut.xml"),
	Asset("IMAGE", "images/map_icons/sch_golden_teatree_nut.tex"),
	Asset("ATLAS", "images/inventoryimages/sch_golden_teatree_nut.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_golden_teatree_nut.tex"),
}
---------------------------------------------------------------
local function SpawnMypetPiko(inst)
if inst ~= nil and inst.components.petleash ~= nil and not inst.components.petleash:IsFull() then
		inst.components.petleash:SpawnPetAt(inst.Transform:GetWorldPosition())
		SpawnPrefab("small_puff").Transform:SetPosition(inst.Transform:GetWorldPosition())
    end
end
local function StartSpawn(inst)
	inst.AnimState:PlayAnimation("idle", true)
    inst:ListenForEvent("animover", SpawnMypetPiko)
end
local function OnDropped(inst, owner)
	inst.SoundEmitter:PlaySound("dontstarve/wilson/lighter_off")
	print("G. Teatree dropped")	StartSpawn(inst)
end
local function OnputIn(inst, owner)
		inst.SoundEmitter:PlaySound("dontstarve/wilson/equip_item_gold")
	print("G. Teatree picked up")
end
---------------------------------------------------------------
local function DoEffects(pet)
local x, y, z = pet.Transform:GetWorldPosition()
	SpawnPrefab("sand_puff").Transform:SetPosition(x, y, z)
end
local function OnSpawn(inst, pet)
if pet:HasTag("cutepiko") then
		pet:DoTaskInTime(0, DoEffects)
		inst:ListenForEvent("onremove", inst.OnPetLost, pet)
    end
end
local function OnDespawn(inst, pet)
if pet:HasTag("cutepiko") then
	DoEffects(pet) 
		pet:Remove()
		if pet.components.container then
			pet.components.container:DropEverything(true) 
		end
		inst:RemoveEventCallback("onremove", inst.OnPetLost, pet)
    end
end
local function OnPetLost(inst, pet)
    local remains = SpawnPrefab("sch_teatree_nut_piko")
    local owner = inst.components.inventoryitem.owner
    local holder = owner ~= nil and (owner.components.inventory or owner.components.container) or nil
if holder ~= nil then
	local slot = holder:GetItemSlot(inst)
        inst:Remove()
			holder:GiveItem(remains, slot)
			else
        StartSpawn(inst)
    end
end
--------------------------------------------------------------
local function RebuildTile(inst)
if inst.components.inventoryitem:IsHeld() then
	local owner = inst.components.inventoryitem.owner
		inst.components.inventoryitem:RemoveFromOwner(true)
		if owner.components.container then
			owner.components.container:GiveItem(inst)
		elseif owner.components.inventory then
			owner.components.inventory:GiveItem(inst)
        end
    end
end
---------------------------------------------------------------
local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end
local function SpawnPikos(inst, data)
    local theta = math.random() * 2 * PI
    local pt = inst:GetPosition()
    local radius = math.random(2, 4)
    local offset = FindWalkableOffset(pt, theta, radius, 8, true, true, NoHoles)
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end
	--inst.components.petleash:SpawnPetAt(pt.x, 0, pt.z, "sch_piko")
	--inst.HasPetWithPiko = "yPIKO"
end
--------------------------------------------------------------
local function ItemTradeTest(inst, item)
    if item == nil then
        return false
    elseif item.prefab ~= "sch_teatree_nut_piko" then
        return false
    end
    return true
end

local function OnItemGiven(inst, giver, item)
    inst.SoundEmitter:PlaySound("dontstarve/common/telebase_gemplace")
	inst.components.perishable:ReducePercent(-3)
end
--------------------------------------------------------------
local function OnSave(inst, data)
--	data.HasPetWithPiko = inst.HasPetWithPiko
end
local function OnPreload(inst, data)
if not data then return end
--if data.HasPetWithPiko == "yPIKO" then	
	--	print("Piko Spawn")
--	end
end
-------------------------------------------------------------
local function GetStatus(inst)
    return inst.respawntask ~= nil and "WAITING" or nil
end
-------------------------------------------------------------
local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:AddMiniMapEntity()
	MakeInventoryPhysics(inst)
    MakeHauntableLaunch(inst)
    inst.entity:AddDynamicShadow()
	inst.entity:AddSoundEmitter()
	
	inst.AnimState:SetBank("teatree_nut")
	inst.AnimState:SetBuild("sch_golden_teatree_nut")
	inst.AnimState:PlayAnimation("idle")     
	
	if not TheWorld.ismastersim then
        return inst
    end
	inst.MiniMapEntity:SetIcon( "sch_golden_teatree_nut.tex" )
	
	inst:AddTag("frozen")
	inst:AddTag("goldennut")
	inst:AddTag("teatreenut")
	inst:AddTag("teatreenutpiko")
	inst:AddTag("schteatrenut")
    inst:AddTag("icebox_valid")
    inst:AddTag("show_spoilage")
	
    inst.DynamicShadow:SetSize( 1, .5 )
	
	--SpawnPikos(inst)
	--inst.HasPetWithPiko = "nPIKO"
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_golden_teatree_nut"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_golden_teatree_nut.xml" 
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnputIn)

    inst:AddComponent("petleash")
	inst.components.petleash:SetMaxPets(1)
    inst.components.petleash:SetPetPrefab("sch_piko")
    inst.components.petleash:SetOnSpawnFn(OnSpawn)
    inst.components.petleash:SetOnDespawnFn(OnDespawn)
	
    inst:AddComponent("leader")
    inst:AddComponent("named")
	
	inst:AddComponent("perishable")
	inst.components.perishable:SetPerishTime(TUNING.PERISH_SUPERSLOW)
	inst.components.perishable:StartPerishing()
	inst.components.perishable:SetOnPerishFn(inst.Remove)

    inst:AddComponent("trader")
    inst.components.trader:SetAbleToAcceptTest(ItemTradeTest)
    inst.components.trader.onaccept = OnItemGiven    

    inst:AddComponent("inspectable")
    inst.components.inspectable.getstatus = GetStatus
	inst.components.inspectable:RecordViews()

	inst.OnSave = OnSave
	inst.OnPreLoad = OnPreload

	return inst
end

return Prefab( "common/inventory/sch_golden_teatree_nut", fn, assets, prefabs)
