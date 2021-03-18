local brain = require "brains/schgemsbrain"

local assets =
{
	Asset("ANIM", "anim/sch_gems.zip"),
	Asset("IMAGE", "images/inventoryimages/sch_gems.tex"),
	Asset("ATLAS", "images/inventoryimages/sch_gems.xml"),
}


local function OnTakeFuel(inst, data)

end

local function OnDurability(inst, data)

end

local function PlayerProxOnClose(inst, data)
	inst.components.locomotor.groundspeedmultiplier = .3 
end

local function PlayerProxOnFar(inst, data)
	inst.components.locomotor.groundspeedmultiplier = 1 
end

local function OnStopFollowing(inst) 
 --   inst:RemoveTag("companion")
end

local function OnStartFollowing(inst) 
 --   inst:AddTag("companion")
end

local function MyMaster(inst, data)
local leader = inst.components.follower.leader
if not inst.components.follower.leader then
				if inst.components.container then
				   inst.components.container:DropEverything(true)
				end
			inst:Remove()
		SpawnPrefab("lucy_transform_fx").Transform:SetPosition(inst:GetPosition():Get())
	end 	
end

local function OnDropped(inst, data)
	inst.AnimState:PlayAnimation("proximity_pre")
    inst.AnimState:PushAnimation("proximity_loop", true)
	inst.components.inventoryitem.canbepickedup = false
    inst.components.container.canbeopened = true
end 

local function OnPutIn(inst, data)
    inst.components.container.canbeopened = false
end 

local function OnGetItemFromPlayer(inst, giver, item)
	local current1 = inst.components.fueled:GetPercent() + 0.2
	local current2 = inst.components.fueled:GetPercent() + 0.3
	local current3 = inst.components.fueled:GetPercent() + 0.4
	if inst.components.fueled ~= nil then
		if item.prefab == "nightmarefuel" then
			inst.components.fueled:SetPercent(current1)
		elseif item.prefab == "healingsalve" then
			inst.components.fueled:SetPercent(current2)
		elseif item.prefab == "bandage" then
			inst.components.fueled:SetPercent(current3)
		end
	end
end

local function OnChosen(inst,owner)
	return owner.prefab == "schwarzkirsche"
end 

local function OnOpen(inst)

		inst.sg:GoToState("open")

end 

local function OnClose(inst) 

        inst.sg:GoToState("idle")

end 

local function fn()
	local inst = CreateEntity()
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
	inst.entity:AddNetwork()
	inst.entity:SetPristine()
    inst.entity:AddSoundEmitter()
	inst.entity:AddDynamicShadow()
	inst.DynamicShadow:SetSize(1, 0.75)
	
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_gems.tex" )
	inst.MiniMapEntity:SetCanUseCache(false)

	inst.AnimState:SetBank("moonrock_seed")
	inst.AnimState:SetBuild("sch_gems")
    inst.AnimState:PlayAnimation("proximity_pre")
    inst.AnimState:PushAnimation("proximity_loop", true)

    inst:AddTag("Gems")
    inst:AddTag("SchGems")
    inst:AddTag("LuxuryGems")
    inst:AddTag("MysteriousGems")
    inst:AddTag("LuxuryHealer")
    inst:AddTag("companion")
    inst:AddTag("flyingstuff")
	inst:AddTag("fridge")

    inst:AddTag("flying")
	if inst.DLC2_fly then
		MakeAmphibiousCharacterPhysics(inst, 2, .5)
	end

	MakeGhostPhysics(inst, 1, .5)
	RemovePhysicsColliders(inst)
	MakeInventoryPhysics(inst)

	if not TheWorld.ismastersim then
		return inst
	end

	inst:AddComponent("inspectable")
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.nobounce = true
	inst.components.inventoryitem.canbepickedup = false
    inst.components.inventoryitem.canonlygoinpocket = true
	inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
	inst.components.inventoryitem:SetOnPickupFn(OnPutIn)
	inst.components.inventoryitem.imagename = "sch_gems"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_gems.xml"

    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = 400
    inst.components.fueled.fueltype = "LUXURYGEMS"
    inst.components.fueled.accepting = true
    inst.components.fueled:StopConsuming()
    inst.components.fueled:SetTakeFuelFn(OnTakeFuel)
	inst.components.fueled:SetDepletedFn(OnDurability)
    inst.components.fueled:InitializeFuelLevel(400)

    inst:AddComponent("schuseitems")
    inst.components.schuseitems:OnActivate(TUNING.HEALING_LARGE)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(function(inst, item) return item.prefab == "nightmarefuel" or item.prefab == "healingsalve" or item.prefab == "bandage" end)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.deleteitemonaccept = true

    inst:AddComponent("playerprox")
    inst.components.playerprox:SetDist(2, 4)
    inst.components.playerprox:SetOnPlayerNear(PlayerProxOnClose)
    inst.components.playerprox:SetOnPlayerFar(PlayerProxOnFar)

    inst:AddComponent("container")
	inst.components.container:WidgetSetup("chest5x5")
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose

	----------[[ HELL YEAH LOL I'M A MADNESS MODDERS LMAO BUT THIS COOL YOU KNOW]]------------------
	inst:AddComponent("locomotor")
	inst.components.locomotor.walkspeed = 6
	inst.components.locomotor.runspeed = 8
    inst.components.locomotor.pathcaps = { allowocean = true }
    inst.components.locomotor:EnableGroundSpeedMultiplier(false)
    inst.components.locomotor:SetTriggersCreep(false)

	inst:SetBrain(brain)
	inst:SetStateGraph("SGschgems")

    inst:AddComponent("follower")
	inst.components.follower:KeepLeaderOnAttacked()
    inst:ListenForEvent("stopfollowing", OnStopFollowing)
    inst:ListenForEvent("startfollowing", OnStartFollowing)
	inst:DoPeriodicTask(0, MyMaster)

    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

	return inst
end


local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

local function onbuilt(inst, builder)
    local theta = math.random() * 2 * PI
    local pt = builder:GetPosition()
    local radius = math.random(3, 6)
    local offset = FindWalkableOffset(pt, theta, radius, 12, true, true, NoHoles)
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end
	if not builder.components.leader:IsBeingFollowedBy("sch_gems") then
		builder.components.petleash:SpawnPetAt(pt.x, 0, pt.z, inst.pettype)
	elseif builder.components.leader:IsBeingFollowedBy("sch_gems") then
		builder.components.talker:Say("I don't need 2", 5)
	end

    inst:Remove()
end

local function MakeBuilder(prefab)
    local function fn()
        local inst = CreateEntity()

        inst.entity:AddTransform()

        inst:AddTag("CLASSIFIED")

        inst.persists = false

        inst:DoTaskInTime(0, inst.Remove)

        if not TheWorld.ismastersim then
            return inst
        end

		inst.pettype = prefab
        inst.OnBuiltFn = onbuilt

        return inst
    end

    return Prefab(prefab.."_onbuild", fn, nil, { prefab })
end

return Prefab("common/inventory/sch_gems", fn, assets),
	   MakeBuilder("sch_gems")