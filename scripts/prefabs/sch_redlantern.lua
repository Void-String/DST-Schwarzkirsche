local assets =
{
    Asset("ANIM", "anim/sch_redlantern.zip"),
    Asset("ANIM", "anim/sch_swap_redlantern.zip"),
	Asset( "IMAGE", "images/inventoryimages/sch_redlantern.tex" ),
    Asset( "ATLAS", "images/inventoryimages/sch_redlantern.xml" ),
}

local prefabs =
{
    "redlanternlight",
    "redlanternbody",
}

local LIGHT_RADIUS = 1.7
local LIGHT_COLOUR = Vector3(200 / 255, 100 / 255, 100 / 255)
local LIGHT_INTENSITY = .8
local LIGHT_FALLOFF = .5

local function OnUpdateFlicker(inst, starttime)
    local time = starttime ~= nil and (GetTime() - starttime) * 15 or 0
    local flicker = (math.sin(time) + math.sin(time + 2) + math.sin(time + 0.7777)) * .5 -- range = [-1 , 1]
    flicker = (1 + flicker) * .5 -- range = 0:1
    inst.Light:SetRadius(LIGHT_RADIUS + .1 * flicker)
    flicker = flicker * 2 / 255
    inst.Light:SetColour(LIGHT_COLOUR.x + flicker, LIGHT_COLOUR.y + flicker, LIGHT_COLOUR.z + flicker)
end

local function onremovelight(light)
    light._lantern._light = nil
end

local function stoptrackingowner(inst)
    if inst._owner ~= nil then
        inst:RemoveEventCallback("equip", inst._onownerequip, inst._owner)
        inst._owner = nil
    end
end

local function starttrackingowner(inst, owner)
    if owner ~= inst._owner then
        stoptrackingowner(inst)
        if owner ~= nil and owner.components.inventory ~= nil then
            inst._owner = owner
            inst:ListenForEvent("equip", inst._onownerequip, owner)
        end
    end
end

local function turnon(inst)
    if not inst.components.fueled:IsEmpty() then
        inst.components.fueled:StartConsuming()

        if inst._light == nil then
            inst._light = SpawnPrefab("redlanternlight")
            inst._light._lantern = inst
            inst:ListenForEvent("onremove", onremovelight, inst._light)
        end
        inst._light.entity:SetParent((inst._body or inst.components.inventoryitem.owner or inst).entity)

        inst.AnimState:Show("LIGHT")

        if inst._body ~= nil then
            inst._body.AnimState:Show("LIGHT")
        end

        if not (inst._body ~= nil and inst._body.entity:IsVisible()) and
            inst.components.equippable:IsEquipped() and
            inst.components.inventoryitem.owner ~= nil then
            inst.components.inventoryitem.owner.AnimState:Show("LANTERN_OVERLAY")
        end

        --inst.components.inventoryitem:ChangeImageName("redlantern_lit")
    end
end

local function turnoff(inst)
    stoptrackingowner(inst)

    inst.components.fueled:StopConsuming()

    if inst._light ~= nil then
        inst._light:Remove()
    end

    inst.AnimState:Hide("LIGHT")

    if inst._body ~= nil then
        inst._body.AnimState:Hide("LIGHT")
    end

    if inst.components.equippable:IsEquipped() then
        inst.components.inventoryitem.owner.AnimState:Hide("LANTERN_OVERLAY")
    end

    --inst.components.inventoryitem:ChangeImageName("redlantern")
end

local function OnRemove(inst)
    if inst._light ~= nil then
        inst._light:Remove()
    end
    if inst._body ~= nil then
        inst._body:Remove()
    end
end

local function ondropped(inst)
    turnoff(inst)
    turnon(inst)
end

local function ToggleOverrideSymbols(inst, owner)
    if owner.sg:HasStateTag("nodangle") or (owner.components.rider ~= nil and owner.components.rider:IsRiding() and not owner.sg:HasStateTag("forcedangle")) then
        owner.AnimState:OverrideSymbol("swap_object", "sch_swap_redlantern", "swap_redlantern")
        if not inst.components.fueled:IsEmpty() then
            owner.AnimState:Show("LANTERN_OVERLAY")
        end
        inst._body:Hide()
    else
        owner.AnimState:OverrideSymbol("swap_object", "sch_swap_redlantern", "swap_redlantern_stick")
        owner.AnimState:Hide("LANTERN_OVERLAY")
        inst._body:Show()
    end
end

local function onremovebody(body)
    body._lantern._body = nil
end

local function onequip(inst, owner)
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
    owner.AnimState:OverrideSymbol("lantern_overlay", "sch_swap_redlantern", "redlantern_overlay")

    if inst._body ~= nil then
        inst._body:Remove()
    end
    inst._body = SpawnPrefab("redlanternbody")
    inst._body._lantern = inst
    inst:ListenForEvent("onremove", onremovebody, inst._body)

    inst._body.entity:SetParent(owner.entity)
    inst._body.entity:AddFollower()
    inst._body.Follower:FollowSymbol(owner.GUID, "swap_object", 68, -126, 0)
    inst._body:ListenForEvent("newstate", function(owner, data)
        ToggleOverrideSymbols(inst, owner)
    end, owner)

    ToggleOverrideSymbols(inst, owner)

    if owner.components.bloomer ~= nil then
        owner.components.bloomer:AttachChild(inst._body)
    end
    if owner.components.colouradder ~= nil then
        owner.components.colouradder:AttachChild(inst._body)
    end

    if inst.components.fueled:IsEmpty() then
        inst._body.AnimState:Hide("LIGHT")
        owner.AnimState:Hide("LANTERN_OVERLAY")
    else
        if inst._body.entity:IsVisible() then
            owner.AnimState:Hide("LANTERN_OVERLAY")
        else
            owner.AnimState:Show("LANTERN_OVERLAY")
        end
        turnon(inst)
    end
end

local function onunequip(inst, owner)
    if inst._body ~= nil then
        if inst._body.entity:IsVisible() then
            owner.AnimState:OverrideSymbol("swap_object", "sch_swap_redlantern", "swap_redlantern")
        end
        if inst._light ~= nil then
            inst._light.entity:SetParent((inst.components.inventoryitem.owner or inst).entity)
        end
        inst._body:Remove()
    end

    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")
    owner.AnimState:ClearOverrideSymbol("lantern_overlay")
    owner.AnimState:Hide("LANTERN_OVERLAY")

    if inst.components.fueled.consuming then
        starttrackingowner(inst, owner)
    end
end

local function nofuel(inst)
    if inst.components.equippable:IsEquipped() and inst.components.inventoryitem.owner ~= nil then
        local data =
        {
            prefab = inst.prefab,
            equipslot = inst.components.equippable.equipslot,
        }
        turnoff(inst)
        inst.components.inventoryitem.owner:PushEvent("torchranout", data)
    else
        turnoff(inst)
    end
end

local function onupdatefueledraining(inst)
    local owner = inst.components.inventoryitem.owner
    inst.components.fueled.rate =
        owner ~= nil and
        owner.components.sheltered ~= nil and
        owner.components.sheltered.sheltered and
        1 or 1 + TUNING.REDLANTERN_RAIN_RATE * TheWorld.state.precipitationrate
end

local function onisraining(inst, israining)
    if israining then
        inst.components.fueled:SetUpdateFn(onupdatefueledraining)
        onupdatefueledraining(inst)
    else
        inst.components.fueled:SetUpdateFn()
        inst.components.fueled.rate = 1
    end
end

local function OnLoad(inst, data)
    if inst.components.fueled:IsEmpty() then
        nofuel(inst)
    end
end

local function lanternlightfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst:AddTag("FX")

    inst.Light:SetIntensity(LIGHT_INTENSITY)
	inst.Light:SetFalloff(LIGHT_FALLOFF)
	inst.Light:EnableClientModulation(true)

    inst:DoPeriodicTask(.1, OnUpdateFlicker, nil, GetTime())
    OnUpdateFlicker(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.persists = false

    return inst
end

local function ondeath(inst, deadthing, killer)
	if  TheNet:GetIsClient() then return end
	-- print("Death comming:",inst,deadthing,killer)
    if 	deadthing ~= nil and
        not (deadthing:HasTag("wall") or deadthing:HasTag("smashable")) and deadthing:HasTag("player") then

        if deadthing:IsValid() then
            if not inst:IsNear(deadthing, 32) then
                return
            end
        end

        local ghost = SpawnPrefab("ghost", "butterfly")
        if ghost ~= nil then
            ghost.Transform:SetPosition(deadthing:GetPosition():Get())
            ghost.SoundEmitter:PlaySound("dontstarve/common/ghost_spawn")
			if ghost.components.follower then 
				ghost.components.follower:SetLeader(inst)
			end
        end
    end
end

local function rebingghost(inst)
	local x,y,z = inst:GetPosition():Get()
	local ghosts = TheSim:FindEntities(x,y,z,32,{"ghost"})
	for k,v in pairs(ghosts) do 
		if v and v.components.follower and v.components.follower:GetLeader() == nil then 
			v.components.follower:SetLeader(inst)
		end
	end 
end 

local function ontakefuel(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/nightmareAddFuel")
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
	inst.MiniMapEntity:SetIcon( "sch_redlantern.tex" )

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("redlantern_ghost")
    inst.AnimState:SetBuild("sch_redlantern")
    inst.AnimState:PlayAnimation("idle_loop", true)

    inst:AddTag("light")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:SetTime(math.random() * inst.AnimState:GetCurrentAnimationLength())
	
	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

    inst:AddComponent("inspectable")
	inst.components.inspectable:SetDescription("Uhm What ?")
	
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem:SetOnDroppedFn(ondropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(turnoff)
	inst.components.inventoryitem.imagename = "sch_redlantern"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_redlantern.xml"

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

    inst:AddComponent("fueled")
	inst.components.fueled.accepting = true
    inst.components.fueled.fueltype = FUELTYPE.NIGHTMARE
	inst.components.fueled:SetTakeFuelFn(ontakefuel)
    inst.components.fueled:InitializeFuelLevel(TUNING.REDLANTERN_LIGHTTIME*2) ------ \('-')
    inst.components.fueled:SetDepletedFn(nofuel)
    inst.components.fueled:SetFirstPeriod(TUNING.TURNON_FUELED_CONSUMPTION, TUNING.TURNON_FULL_FUELED_CONSUMPTION)

    inst:AddComponent("fuel")
    inst.components.fuel.fuelvalue = TUNING.LARGE_FUEL

    inst:WatchWorldState("israining", onisraining)
    onisraining(inst, TheWorld.state.israining)

    MakeHauntableLaunch(inst)

    inst.OnRemoveEntity = OnRemove
    inst.OnLoad = OnLoad

    inst._light = nil
    turnon(inst)

    inst._onownerequip = function(owner, data)
        if data.item ~= inst and
            (   data.eslot == EQUIPSLOTS.HANDS or
                (data.eslot == EQUIPSLOTS.BODY and data.item:HasTag("heavy"))
            ) then
            turnoff(inst)
        end
    end
	
    inst._onentitydeath = function(world, data)
        ondeath(inst, data.inst)
    end	
	
	inst:ListenForEvent("entity_death", inst._onentitydeath, TheWorld) 
	rebingghost(inst) 
	inst:DoPeriodicTask(3,function()rebingghost(inst)end ) 
    return inst
end

local function lanternbodyfn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    inst.AnimState:SetBank("redlantern_ghost")
    inst.AnimState:SetBuild("sch_redlantern")
    inst.AnimState:PlayAnimation("idle_body_loop", true)

    inst:AddTag("FX")

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.AnimState:SetTime(math.random() * inst.AnimState:GetCurrentAnimationLength())

    inst.persists = false

    return inst
end
return Prefab("sch_redlantern", fn, assets, prefabs),
		Prefab("redlanternlight", lanternlightfn),
		Prefab("redlanternbody", lanternbodyfn)
