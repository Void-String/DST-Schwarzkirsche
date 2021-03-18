local assets =
{
    Asset("ANIM", "anim/sch_compass.zip"),
    Asset("ANIM", "anim/sch_swap_compass.zip"),
    Asset("ANIM", "anim/sch_tracker_pointer.zip"),
	Asset( "ANIM", "anim/sch_ui_oneslot_1x1.zip" ),
	Asset("ATLAS", "images/inventoryimages/sch_compass.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_compass.tex"),
}

local function CanGiveLoot(inst, prefab)
    if not (inst.components.inventoryitem and (inst.components.inventoryitem.owner ~= nil)) and not inst:IsInLimbo() then
        if inst.prefab == prefab then
            return true
        elseif inst.components.pickable and inst.components.pickable:CanBePicked() and inst.components.pickable.product == prefab then
            return true
        elseif inst.components.harvestable and inst.components.harvestable:CanBeHarvested() and inst.components.harvestable.product == prefab then
            return true
        elseif inst.components.dryable and inst.components.dryable.product == prefab then
            return true
        elseif inst.components.shearable and inst.components.shearable:CanShear() and inst.components.shearable.product == prefab then
            return true
        elseif inst.components.dislodgeable and inst.components.dislodgeable:CanBeDislodged() and inst.components.dislodgeable.product == prefab then
            return true
        elseif inst.components.cookable and inst.components.cookable.product == prefab then
            return true
        elseif inst.components.lootdropper then
            local total_loot = inst.components.lootdropper:GetPotentialLoot()
            for i,v2 in ipairs(total_loot) do
                if v2 == prefab then
                    return true
                end
            end
        end
    end
    return false
end

local function TrackNext(inst, prefab)
    print ("TRACKING A ", prefab)
    local x,y,z = inst.Transform:GetWorldPosition()
    local found_ents = {}
    local ents = TheSim:FindEntities(x,y,z, 2500)
    for k,v in pairs(ents) do
        if CanGiveLoot(v, prefab) then
            table.insert(found_ents, v)
        end
    end
    local sorted_ents = {}
    local pos = inst:GetPosition()
    for k,v in pairs(found_ents) do
        local v_pt = v:GetPosition()
        table.insert(sorted_ents, {inst = v, distance = distsq(pos, v_pt)})
    end
    table.sort(sorted_ents, function(a,b) return (a.distance) < (b.distance) end)
    if next(sorted_ents) ~= nil then
        return sorted_ents[1].inst
    end
    print ("NO INSTANCES FOUND FOR TRACKING")
end

local function DeactivateTracking(inst)
    if inst.arrow_rotation_update then
        inst.arrow_rotation_update:Cancel()
        inst.arrow_rotation_update = nil
    end
    if inst.distance_update then
        inst.distance_update:Cancel()
        inst.distance_update = nil
    end
    if inst.arrow then
        inst.arrow:Remove()
        inst.arrow = nil
    end
end

local function ActivateTracking(inst)
	local owner = inst.components.inventoryitem.owner
	local item_to_track = inst.components.container:GetItemInSlot(1)
	local prefab_to_track = item_to_track.prefab
	local function update_item()
		local closer_item = TrackNext(inst, inst.tracked_item.prefab)
		if closer_item ~= inst.tracked_item then
			inst.tracked_item = closer_item
		end
	end
	if owner then
		if inst.tracked_item then
			if not inst.arrow then
				inst.arrow = SpawnPrefab("sch_tracker_pointer")
				owner:AddChild(inst.arrow)
			end
			if inst.arrow_rotation_update == nil then
				inst.arrow_rotation_update = inst:DoPeriodicTask(0, function() 
					if inst.tracked_item and (inst.tracked_item:IsInLimbo() or not CanGiveLoot(inst.tracked_item, prefab_to_track)) then
						inst.tracked_item = nil
					end
					if inst.tracked_item == nil or not inst.tracked_item:IsValid() then
						DeactivateTracking(inst)
						inst.tracked_item = TrackNext(inst, prefab_to_track)
						ActivateTracking(inst)
					else
						inst.arrow:UpdateRotation(inst.tracked_item.Transform:GetWorldPosition())
					end
				end)
			end
		else
			owner.components.talker:Say("Compass can't find the item.")
		end
	end
end

local function onequip(inst, owner)
    owner.AnimState:OverrideSymbol("swap_object", "sch_swap_compass", "swap_compass")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")

    if owner.components.maprevealable ~= nil then
        owner.components.maprevealable:AddRevealSource(inst, "compassbearer")
    end
    owner:AddTag("compassbearer")
	
	if inst.components.fueled then
       inst.components.fueled:StartConsuming()
	end
	
    if inst.components.container ~= nil then
        inst.components.container:Open(owner)
    end
    local item = inst.components.container:GetItemInSlot(1)
    if item then
		ActivateTracking(inst)
	end
end

local function onunequip(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

    if owner.components.maprevealable ~= nil then
        owner.components.maprevealable:RemoveRevealSource(inst)
    end
    owner:RemoveTag("compassbearer")
	
	if inst.components.fueled then
       inst.components.fueled:StopConsuming()
	end
    if inst.components.container ~= nil then
        inst.components.container:Close(owner)
    end
		DeactivateTracking(inst)
end

local function ondepleted(inst)
    if inst.components.inventoryitem ~= nil
        and inst.components.inventoryitem.owner ~= nil then
        local data = {
            prefab = inst.prefab,
            equipslot = inst.components.equippable.equipslot,
            announce = "ANNOUNCE_COMPASS_OUT",
        }
        inst.components.inventoryitem.owner:PushEvent("itemranout", data)
    end
    inst:Remove()
	if inst.components.container then
		inst.components.container:DropEverything(true) 
	end
end

local function CheckSlot(inst)
    for i = 1, inst.components.container:GetNumSlots() do
	    local item = inst.components.container:GetItemInSlot(i)
		if item ~= nil then
			if inst.components.equippable:IsEquipped() then
				inst.tracked_item = TrackNext(inst, inst.components.container:GetItemInSlot(1).prefab)
				ActivateTracking(inst)			
			end
		else
			DeactivateTracking(inst)
		end
    end
end

local function OnOpen(inst)

end 

local function OnClose(inst) 

end 

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("compass")
    inst.AnimState:SetBuild("sch_compass")
    inst.AnimState:PlayAnimation("idle", true)

    inst:AddTag("tracker")
    inst:AddTag("compass")
    inst:AddTag("smartcompass")
    inst:AddTag("schstuff")
    inst:AddTag("schcompass")
    inst:AddTag("sch_compass")
    inst:AddTag("nopunch")

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_compass.tex" )

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_compass"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_compass.xml" 

    inst:AddComponent("container")
	inst.components.container:WidgetSetup("smartcompass")
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("fueled")
    inst.components.fueled:InitializeFuelLevel(TUNING.COMPASS_FUEL)
    inst.components.fueled:SetDepletedFn(ondepleted)
    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)

    inst:AddComponent("inspectable")
	inst.components.inspectable:RecordViews()

    MakeHauntableLaunch(inst)

	inst:ListenForEvent("itemget", function(inst) 
	inst.CheckTask = inst:DoPeriodicTask(2.5, function()
			CheckSlot(inst) 
		end)
	end)
	inst:ListenForEvent("itemlose", function(inst) 
	if inst.CheckTask then
		inst.CheckTask:Cancel()
		inst.CheckTask = nil
	end
		CheckSlot(inst) 
	end)

    return inst
end

local function pointerfn(Sim)
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()
	-------------
    inst.AnimState:SetBuild("tracker_pointer")
    inst.AnimState:SetBank("tracker_pointer")
    inst.AnimState:PlayAnimation("idle")
	-------------
    inst.AnimState:SetOrientation(ANIM_ORIENTATION.OnGround)
    inst.AnimState:SetLayer(LAYER_BACKGROUND)
    inst.AnimState:SetSortOrder(1)
    inst.AnimState:SetFinalOffset(1)
	
    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end
	
    inst.AnimState:PushAnimation("idle")

    inst.persists = false
	

    inst.pos_target = ThePlayer
    inst.UpdateRotation = function(inst, x,y,z, owner)
        inst:FacePoint(x,y,z)
        inst.Transform:SetRotation(inst.Transform:GetRotation() + 90 - inst.parent.Transform:GetRotation())
    end

    return inst
end
------------ From Wheeler Hamlet (Wheeler Tracker aka Wheeler Toys)
return Prefab("common/inventory/sch_compass", fn, assets),
	   Prefab("common/inventory/sch_tracker_pointer", pointerfn, assets)
