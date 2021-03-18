local assets =
{
    Asset("ANIM", "anim/sch_dress_1.zip"),
    Asset("ATLAS", "images/inventoryimages/sch_dress_1.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_dress_1.tex"),
}
local ARMOR_LEVEL = 999999999999999999999999999999999999999999999999999999999999999999999 ------ (-_-') -- Oh Hellyeah

local function levelexp(inst, data)

	local max_exp = 1000
	local exp = math.min(inst.dress_level, max_exp)

--[[
if inst.dress_level >= 1000 then
	inst.components.talker:Say("[Armor Exp]".. (inst.dress_level))
end
]]

if inst.dress_level >= 0 and inst.dress_level < 100 then
	inst.components.talker:Say("[ Armor Level ] : [ 1 ]\n[ Defense ] : [ 45% ]\n[ Level Exp ] : ".. (inst.dress_level))
elseif inst.dress_level >= 100 and inst.dress_level < 200 then
	inst.components.talker:Say("[ Armor Level ] : [ 2 ]\n[ Defense ] : [ 50% ]\n[ Level Exp ] : ".. (inst.dress_level))
elseif inst.dress_level >= 200 and inst.dress_level < 300 then
	inst.components.talker:Say("[ Armor Level ] : [ 3 ]\n[ Defense ] : [ 55%]\n[ Level Exp ] : ".. (inst.dress_level))
elseif inst.dress_level >= 300 and inst.dress_level < 400 then
	inst.components.talker:Say("[ Armor Level ] : [ 4 ]\n[ Defense ] : [ 60% ]\n[ Level Exp ] : ".. (inst.dress_level))
elseif inst.dress_level >= 400 and inst.dress_level < 500 then
	inst.components.talker:Say("[ Armor Level ] : [ 5 ]\n[ Defense ] : [ 65% ]\n[ Level Exp ] : ".. (inst.dress_level))
elseif inst.dress_level >= 500 and inst.dress_level < 600 then
	inst.components.talker:Say("[ Armor Level ] : [ 6 ]\n[ Defense ] : [ 70% ]\n[ Level Exp ] : ".. (inst.dress_level))
elseif inst.dress_level >= 600 and inst.dress_level < 700 then
	inst.components.talker:Say("[ Armor Level ] : [ 7 ]\n[ Defense ] : [ 75% ]\n[ Level Exp ] : ".. (inst.dress_level))
elseif inst.dress_level >= 700 and inst.dress_level < 800 then
	inst.components.talker:Say("[ Armor Level ] : [ 8 ]\n[ Defense ] : [ 80% ]\n[ Level Exp ] : ".. (inst.dress_level))
elseif inst.dress_level >= 800 and inst.dress_level < 900 then
	inst.components.talker:Say("[ Armor Level ] : [ 9 ]\n[ Defense ] : [ 85% ]\n[ Level Exp ] : ".. (inst.dress_level))
elseif inst.dress_level >= 900 then
	inst.components.talker:Say("[ Armor Level ] : [ MAX ]\n[ Defense ] : [ 90% ]")
	end
end

local function CheckArmor(inst, data)
if not inst.NoCharge then 
	if inst.dress_level >= 0 and inst.dress_level < 100 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.45)
		elseif inst.dress_level >= 100 and inst.dress_level < 200 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.50)
		elseif inst.dress_level >= 200 and inst.dress_level < 300 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.55)
		elseif inst.dress_level >= 300 and inst.dress_level < 400 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.60)
		elseif inst.dress_level >= 400 and inst.dress_level < 500 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.65)
		elseif inst.dress_level >= 500 and inst.dress_level < 600 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.70)
		elseif inst.dress_level >= 600 and inst.dress_level < 700 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.75)
		elseif inst.dress_level >= 700 and inst.dress_level < 800 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.80)
		elseif inst.dress_level >= 800 and inst.dress_level < 900 then
			inst.components.armor:InitCondition(ARMOR_LEVEL, 0.85)
		elseif inst.dress_level >= 900 then
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
		local dress_armor = inst.components.fueled.currentfuel
				local mx2 = math.floor(max_fuel - min_fuel)
				local cur2 = math.floor(dress_armor - min_fuel)
				local armordress = ""..math.floor(cur2*700/mx2).."%/700%"
if item.prefab == "sch_dark_soul" then
		inst.components.talker:Say("[ Soul Fuel ]\n[ Dress Exp Point ] : [ +15 ]\n[ Current Fuel ] : "..(armordress))
		inst.components.fueled:DoDelta(25)
		inst.dress_level = inst.dress_level + 15
		CheckArmor(inst) inst.NoCharge = false
	end
if item:HasTag("LUXURYFUEL") then
		inst.components.talker:Say("[ Luxury Fuel ]\n[ Dress Exp Point ] : [ +30 ]\n[ Current Fuel ] : "..(armordress))
		inst.components.fueled:DoDelta(50)
		inst.dress_level = inst.dress_level + 30
		CheckArmor(inst) inst.NoCharge = false
	end
end

local function IsEmptyToUse(inst, owner)
    local current = inst.components.fueled:GetPercent()
    if current <= 0 then
		inst.components.talker:Say("Dress need Fuel")
	end
	if inst.FuelRegen then
	   inst.FuelRegen:Cancel()
	   inst.FuelRegen = nil
	end
end

local function StartRegent(inst, owner)
		local max_fuel = 700
		local min_fuel = 0
		local dress_armor = inst.components.fueled.currentfuel
				local mx2 = math.floor(max_fuel - min_fuel)
				local cur2 = math.floor(dress_armor - min_fuel)
				local armordress = ""..math.floor(cur2*700/mx2).."%/700%"
				
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
			inst.components.talker:Say("[ Armor Charge ] : "..(armordress))
		end
	end)
end

local function onequip(inst, owner) 
    owner.AnimState:OverrideSymbol("swap_body", "sch_dress_1", "swap_body")
	
	CheckArmor(inst)
	
	if not inst.NoCharge then
	
		local max_fuel = 700
		local min_fuel = 0
		local dress_armor = inst.components.fueled.currentfuel
				local mx2 = math.floor(max_fuel - min_fuel)
				local cur2 = math.floor(dress_armor - min_fuel)
				local armordress = ""..math.floor(cur2*700/mx2).."%/700%"
				
		inst.components.talker:Say("[ Dress Armor Charge ] : "..(armordress))
			inst:DoTaskInTime(3, levelexp)
			
	end

	if not inst.components.fueled:IsEmpty() then
			inst.FuelConsume = inst:DoPeriodicTask(2, function(inst) inst.components.fueled:DoDelta(-1)  end)
		else
		if inst.FuelConsume then
			inst.FuelConsume:Cancel()
			inst.FuelConsume = nil
		end	
	end
end

local function onunequip(inst, owner) 
    owner.AnimState:ClearOverrideSymbol("swap_body")
	if inst.FuelConsume then
	   inst.FuelConsume:Cancel()
	   inst.FuelConsume = nil
	end	
end

local function OnChosen(inst,owner)
	return owner.prefab == "schwarzkirsche"
end 

local function onsave(inst, data)
	data.dress_level = inst.dress_level
end

local function onpreload(inst, data)
	if data then
		if data.dress_level then
			inst.dress_level = data.dress_level
			levelexp(inst)
		end
	end
end

local function fn()

    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("sendi_armor_01")
    inst.AnimState:SetBuild("sch_dress_1")
    inst.AnimState:PlayAnimation("anim")

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_dress_1.tex" )

	inst:AddTag("sleevefix")
	inst:AddTag("sendis")

    if not TheWorld.ismastersim then
        return inst
    end

	inst.entity:SetPristine()

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_dress_1"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_dress_1.xml"
	
    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_TINY
    inst.components.equippable:SetOnEquip(onequip)
    inst.components.equippable:SetOnUnequip(onunequip)

	inst:AddComponent("armor")

	inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = 700
    inst.components.fueled.fueltype = FUELTYPE.LUXURYGEMS
    inst.components.fueled.accepting = true
    inst.components.fueled:StopConsuming()
    inst.components.fueled:SetTakeFuelFn(OnTakeFuel)
	inst.components.fueled:SetDepletedFn(OnDurability)
    inst.components.fueled:InitializeFuelLevel(700)

	inst:AddComponent("waterproofer")
	inst.components.waterproofer:SetEffectiveness(TUNING.WATERPROOFNESS_LARGE)

	inst:AddComponent("insulator")
	inst.components.insulator:SetInsulation(TUNING.INSULATION_MED)
	inst.components.insulator:SetWinter()

	inst:AddComponent("talker")
    inst.components.talker.fontsize = 20
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.9, 1, 0.75, 1)
    inst.components.talker.offset = Vector3(0,100,0)
    inst.components.talker.symbol = "swap_object"

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(function(inst, item) return item.prefab == "sch_dark_soul" or item:HasTag("LUXURYFUEL") end)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.deleteitemonaccept = true
	
    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

	inst:ListenForEvent("equipped", IsEmptyToUse)
	inst:ListenForEvent("unequipped", StartRegent)

	inst.dress_level = 0
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	inst:ListenForEvent("levelup", levelexp)

    return inst
	
end

return Prefab("common/inventory/sch_dress_1", fn, assets)