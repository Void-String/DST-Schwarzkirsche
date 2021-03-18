local assets =
{
    Asset("ANIM", "anim/sch_hat.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_hat.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_hat.tex"),
}

local prefabs =
{

}

local ARMOR_LEVEL = 999999999999999999999999999999999999999999999999999999999999999999999 ------ (-_-') -- Oh Hellyeah

local function levelexp(inst, data)

	local max_exp = 1000
	local exp = math.min(inst.hat_level, max_exp)

--[[
if inst.hat_level >= 1000 then
	inst.components.talker:Say("[Armor Exp]".. (inst.hat_level))
end
]]

if inst.hat_level >= 0 and inst.hat_level < 100 then
	inst.components.talker:Say("[ Armor Level ] : [ 1 ]\n[ Defense ] : [ 45% ]\n[ Level Exp ] : ".. (inst.hat_level))
elseif inst.hat_level >= 100 and inst.hat_level < 200 then
	inst.components.talker:Say("[ Armor Level ] : [ 2 ]\n[ Defense ] : [ 50% ]\n[ Level Exp ] : ".. (inst.hat_level))
elseif inst.hat_level >= 200 and inst.hat_level < 300 then
	inst.components.talker:Say("[ Armor Level ] : [ 3 ]\n[ Defense ] : [ 55%]\n[ Level Exp ] : ".. (inst.hat_level))
elseif inst.hat_level >= 300 and inst.hat_level < 400 then
	inst.components.talker:Say("[ Armor Level ] : [ 4 ]\n[ Defense ] : [ 60% ]\n[ Level Exp ] : ".. (inst.hat_level))
elseif inst.hat_level >= 400 and inst.hat_level < 500 then
	inst.components.talker:Say("[ Armor Level ] : [ 5 ]\n[ Defense ] : [ 65% ]\n[ Level Exp ] : ".. (inst.hat_level))
elseif inst.hat_level >= 500 and inst.hat_level < 600 then
	inst.components.talker:Say("[ Armor Level ] : [ 6 ]\n[ Defense ] : [ 70% ]\n[ Level Exp ] : ".. (inst.hat_level))
elseif inst.hat_level >= 600 and inst.hat_level < 700 then
	inst.components.talker:Say("[ Armor Level ] : [ 7 ]\n[ Defense ] : [ 75% ]\n[ Level Exp ] : ".. (inst.hat_level))
elseif inst.hat_level >= 700 and inst.hat_level < 800 then
	inst.components.talker:Say("[ Armor Level ] : [ 8 ]\n[ Defense ] : [ 80% ]\n[ Level Exp ] : ".. (inst.hat_level))
elseif inst.hat_level >= 800 and inst.hat_level < 900 then
	inst.components.talker:Say("[ Armor Level ] : [ 9 ]\n[ Defense ] : [ 85% ]\n[ Level Exp ] : ".. (inst.hat_level))
elseif inst.hat_level >= 900 then
	inst.components.talker:Say("[ Armor Level ] : [ MAX ]\n[ Defense ] : [ 90% ]")
	end
end

local function CheckArmor(inst, data)
if not inst.NoCharge then 
	if inst.hat_level >= 0 and inst.hat_level < 100 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.45)
		elseif inst.hat_level >= 100 and inst.hat_level < 200 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.50)
		elseif inst.hat_level >= 200 and inst.hat_level < 300 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.55)
		elseif inst.hat_level >= 300 and inst.hat_level < 400 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.60)
		elseif inst.hat_level >= 400 and inst.hat_level < 500 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.65)
		elseif inst.hat_level >= 500 and inst.hat_level < 600 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.70)
		elseif inst.hat_level >= 600 and inst.hat_level < 700 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.75)
		elseif inst.hat_level >= 700 and inst.hat_level < 800 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.80)
		elseif inst.hat_level >= 800 and inst.hat_level < 900 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.85)
		elseif inst.hat_level >= 900 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.90)
		end
	end
	if inst.NoCharge then 
		inst.components.armor:InitCondition(ARMOR_LEVEL, 0.15)
	end
end

local function OnTakeFuel(inst, data)
	print("Fuel Taken")
	inst.NoCharge = false
	CheckArmor(inst)
end

local function OnDurability(inst, data)
	if inst.components.fueled:IsEmpty() then
		inst.NoCharge = true CheckArmor(inst)
		inst.components.talker:Say("[ Armor Need Charge ]\n[ Defense ] : [ 15% ]")
	elseif not inst.components.fueled:IsEmpty() then
		inst.NoCharge = false
		CheckArmor(inst)
	end
end

local function OnGetItemFromPlayer(inst, giver, item)
		local max_fuel = 700
		local min_fuel = 0
		local hat_armor = inst.components.fueled.currentfuel
				local mx2 = math.floor(max_fuel - min_fuel)
				local cur2 = math.floor(hat_armor - min_fuel)
				local armorhat = ""..math.floor(cur2*700/mx2).."%/700%"
if item.prefab == "sch_dark_soul" then
		inst.components.talker:Say("[ Soul Fuel ]\n[ Hat Exp Point ] : [ +25 ]\n[ Current Fuel ] : "..(armorhat))
		inst.components.fueled:DoDelta(25)
		inst.hat_level = inst.hat_level + 25
		CheckArmor(inst) inst.NoCharge = false
	end
if item:HasTag("LUXURYFUEL") then
		inst.components.talker:Say("[ Luxury Fuel ]\n[ Hat Exp Point ] : [ +50 ]\n[ Current Fuel ] : "..(armorhat))
		inst.components.fueled:DoDelta(50)
		inst.hat_level = inst.hat_level + 50
		CheckArmor(inst) inst.NoCharge = false
	end
end

local function IsEmptyToUse(inst, owner)
    local current = inst.components.fueled:GetPercent()
    if current <= 0 then
		inst.components.talker:Say("Hat need Fuel")
	end
	if inst.FuelRegen then
	   inst.FuelRegen:Cancel()
	   inst.FuelRegen = nil
	end
end

local function StartRegent(inst, owner)
		local max_fuel = 700
		local min_fuel = 0
		local hat_armor = inst.components.fueled.currentfuel
				local mx2 = math.floor(max_fuel - min_fuel)
				local cur2 = math.floor(hat_armor - min_fuel)
				local armorhat = ""..math.floor(cur2*700/mx2).."%/700%"
				
	inst.FuelRegen = inst:DoPeriodicTask(20, function(inst) 
local current = inst.components.fueled:GetPercent() + 0.1
    if current > 1 then
		inst.components.talker:Say("Armor Charge is Full")
			inst.components.fueled:SetPercent(1) 
				IsEmptyToUse(inst) 
					CheckArmor(inst)
						inst.NoCharge = false
						else
					inst.components.fueled:SetPercent(current)
				inst.hat_level = inst.hat_level + 2
			inst.components.talker:Say("[ Armor Charge ] : "..(armorhat))
		end
	end)
end


local function OnStopUsingItem(inst, data)
local hat = inst.components.inventory ~= nil and inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HEAD) or nil
	if hat ~= nil and data.statename ~= "hide" then
	   hat.components.useableitem:StopUsingItem()
	end
end

local function OnEquiped(inst, owner)
  owner.AnimState:OverrideSymbol("swap_hat", "sch_hat", "swap_hat")   	
  owner.AnimState:Show("HAT")   
  owner.AnimState:Hide("HAIR_HAT") 
  owner.AnimState:Show("HAIR_NOHAT")  
  owner.AnimState:Show("HAIR") 
		CheckArmor(inst)
		
	if not inst.NoCharge then
	
		local max_fuel = 700
		local min_fuel = 0
		local hat_armor = inst.components.fueled.currentfuel
				local mx2 = math.floor(max_fuel - min_fuel)
				local cur2 = math.floor(hat_armor - min_fuel)
				local armorhat = ""..math.floor(cur2*700/mx2).."%/700%"
				
		inst.components.talker:Say("[ Hat Armor Charge ] : "..(armorhat))
			inst:DoTaskInTime(3, levelexp)
			
	end
	
	if not inst.components.fueled:IsEmpty() then
			inst.FuelConsume = inst:DoPeriodicTask(3, function(inst) inst.components.fueled:DoDelta(-1)  end)
		else
		if inst.FuelConsume then
			inst.FuelConsume:Cancel()
			inst.FuelConsume = nil
		end	
	end
		local attractor = owner.components.birdattractor
        if attractor then
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_MAXDELTA_FEATHERHAT, "maxbirds")
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_DELAYDELTA_FEATHERHAT.MIN, "mindelay")
            attractor.spawnmodifier:SetModifier(inst, TUNING.BIRD_SPAWN_DELAYDELTA_FEATHERHAT.MAX, "maxdelay")
            
            local birdspawner = TheWorld.components.birdspawner
            if birdspawner ~= nil then
                birdspawner:ToggleUpdate(true)
            end
        end
		
--	inst:ListenForEvent("newstate", OnStopUsingItem, owner)
	
end

local function OnUnEquiped(inst, owner)
  owner.AnimState:ClearOverrideSymbol("swap_hat")  
  owner.AnimState:Hide("HAT")   	
  owner.AnimState:Hide("HAIR_HAT")   	
  owner.AnimState:Show("HAIR_NOHAT")   
  owner.AnimState:Show("HAIR") 
		
	if inst.FuelConsume then
	   inst.FuelConsume:Cancel()
	   inst.FuelConsume = nil
	end	
		
        local attractor = owner.components.birdattractor
        if attractor then
            attractor.spawnmodifier:RemoveModifier(inst)

            local birdspawner = TheWorld.components.birdspawner
            if birdspawner ~= nil then
                birdspawner:ToggleUpdate(true)
            end
        end

--	inst:RemoveEventCallback("newstate", OnStopUsingItem, owner)
end

local function OnUseItem(inst)
local owner = inst.components.inventoryitem.owner
	if owner then
	   owner.sg:GoToState("hide")
       inst.AnimState:PlayAnimation("anim")
	end
end

local function OnChosen(inst,owner)
	return owner.prefab == "schwarzkirsche"
end 

local function onsave(inst, data)
	data.hat_level = inst.hat_level
end

local function onpreload(inst, data)
	if data then
		if data.hat_level then
			inst.hat_level = data.hat_level
			levelexp(inst)
		end
	end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddNetwork()
    inst.entity:AddAnimState()
    inst.entity:SetPristine()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    MakeHauntableLaunch(inst)
	
    inst.AnimState:SetBank("sweet_cookie")
    inst.AnimState:SetBuild("sch_hat")
    inst.AnimState:PlayAnimation("anim")
	
    inst:AddTag("hats")
    inst:AddTag("schhat")
    inst:AddTag("ArmoredHat")
    inst:AddTag("schwarzhat")
    inst:AddTag("Headband")

    if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_hat.tex" )

    inst:AddComponent("inspectable")
	inst.components.inspectable:RecordViews()
--[[
	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(OnUseItem)
]]
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_hat"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_hat.xml" 

	inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(TUNING.INSULATION_LARGE)
--	inst.components.insulator:SetWinter()
	inst.components.insulator:SetSummer()
	
	inst:AddComponent("waterproofer")
	inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_MED)

	inst:AddComponent("armor")

    inst:AddComponent("equippable")
	inst.components.equippable.equipslot = EQUIPSLOTS.HEAD
    inst.components.equippable:SetOnEquip(OnEquiped)
    inst.components.equippable:SetOnUnequip(OnUnEquiped)
    inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED_LARGE
    inst.components.equippable.insulated = true

	inst:AddComponent("periodicspawner")
	inst.components.periodicspawner:SetPrefab("spore_small")
	inst.components.periodicspawner:SetRandomTimes(20, 1, true)

    inst:AddComponent("talker")
    inst.components.talker.fontsize = 22
    inst.components.talker.font = TALKINGFONT
	inst.components.talker.colour = Vector3(1, 0.8, 0.95, 1)
    inst.components.talker.offset = Vector3(0,-500,0)
    inst.components.talker.symbol = "swap_object"

	inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = 700
    inst.components.fueled.fueltype = FUELTYPE.LUXURYGEMS
    inst.components.fueled.accepting = true
    inst.components.fueled:StopConsuming()
    inst.components.fueled:SetTakeFuelFn(OnTakeFuel)
	inst.components.fueled:SetDepletedFn(OnDurability)
    inst.components.fueled:InitializeFuelLevel(700)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(function(inst, item) return item.prefab == "sch_dark_soul" or item:HasTag("LUXURYFUEL") end)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.deleteitemonaccept = true

	inst:ListenForEvent("equipped", IsEmptyToUse)
	inst:ListenForEvent("unequipped", StartRegent)

    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

	inst.hat_level = 0
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	inst:ListenForEvent("levelup", levelexp)

    return inst
end

return Prefab("common/inventory/sch_hat", fn, assets, prefabs)