local assets =
{
    Asset("ANIM", "anim/sch_scythe.zip"),
    Asset("ANIM", "anim/sch_swap_scythe.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_scythe.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_scythe.tex"),
}
	
local prefabs = {

    "sch_shadowtentacle_ice",
    "sch_shadowtentacle_fire",
	
}

local SHIELD_DURATION = 10 * FRAMES
local MAIN_SHIELD_CD = 1.2

local RESISTANCES =
{
    "_combat",
    "explosive",
    "quakedebris",
    "caveindebris",
    "trapdamage",
}

local function PickShield(inst)
    local t = GetTime()
    local flipoffset = math.random() < .5 and 3 or 0

    local dt = t - inst.lastmainshield
    if dt >= MAIN_SHIELD_CD then
        inst.lastmainshield = t
        return flipoffset + 3
    end

    local rnd = math.random()
    if rnd < dt / MAIN_SHIELD_CD then
        inst.lastmainshield = t
        return flipoffset + 3
    end

    return flipoffset + (rnd < dt / (MAIN_SHIELD_CD * 2) + .5 and 2 or 1)
end

local function OnShieldOver(inst, OnResistDamage)
    inst.task = nil
    for i, v in ipairs(RESISTANCES) do
        inst.components.resistance:RemoveResistance(v)
    end
    inst.components.resistance:SetOnResistDamageFn(OnResistDamage)
end

local function OnResistDamage(inst)--, damage)
    local owner = inst.components.inventoryitem:GetGrandOwner() or inst
    local fx = SpawnPrefab("sch_stalker_shield_mod") PickShield(inst)
		  fx.Transform:SetScale(0.30, 0.30, 0.30)
	if fx then
		if fx:IsValid() then
			fx.entity:SetParent(owner.entity)
		end	
	end
		
    if inst.task ~= nil then
        inst.task:Cancel()
    end
    inst.task = inst:DoTaskInTime(SHIELD_DURATION, OnShieldOver, OnResistDamage)
    inst.components.resistance:SetOnResistDamageFn(nil)

    inst.components.fueled:DoDelta(-10)
    if inst.components.cooldown.onchargedfn ~= nil then
        inst.components.cooldown:StartCharging()
    end
end

local function ShouldResistFn(inst)
    if not inst.components.equippable:IsEquipped() then
        return false
    end
    local owner = inst.components.inventoryitem.owner
    return owner ~= nil
        and not (owner.components.inventory ~= nil and
                owner.components.inventory:EquipHasTag("forcefield"))
end

local function OnChargedFn(inst)
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
        inst.components.resistance:SetOnResistDamageFn(OnResistDamage)
    end
    for i, v in ipairs(RESISTANCES) do
        inst.components.resistance:AddResistance(v)
    end
end

local function levelexp(inst, data)

	local max_exp = 1000
	local exp = math.min(inst.scythe_level, max_exp)

--[[
if inst.scythe_level >= 1000 then
	inst.components.talker:Say("[Scythe Exp]".. (inst.scythe_level))
end
]]

if inst.scythe_level >= 0 and inst.scythe_level < 100 then
	inst.components.talker:Say("[ Scythe Level ] : [ 1 ]\n[ Damage ] : [ 30 ]\n[ Level Exp ] : ".. (inst.scythe_level))
elseif inst.scythe_level >= 100 and inst.scythe_level < 200 then
	inst.components.talker:Say("[ Scythe Level ] : [ 2 ]\n[ Damage ] : [ 35 ]\n[ Level Exp ] : ".. (inst.scythe_level))
elseif inst.scythe_level >= 200 and inst.scythe_level < 300 then
	inst.components.talker:Say("[ Scythe Level ] : [ 3 ]\n[ Damage ] : [ 40 ]\n[ Level Exp ] : ".. (inst.scythe_level))
elseif inst.scythe_level >= 300 and inst.scythe_level < 400 then
	inst.components.talker:Say("[ Scythe Level ] : [ 4 ]\n[ Damage ] : [ 45 ]\n[ Level Exp ] : ".. (inst.scythe_level))
elseif inst.scythe_level >= 400 and inst.scythe_level < 500 then
	inst.components.talker:Say("[ Scythe Level ] : [ 5 ]\n[ Damage ] : [ 50 ]\n[ Level Exp ] : ".. (inst.scythe_level))
elseif inst.scythe_level >= 500 and inst.scythe_level < 600 then
	inst.components.talker:Say("[ Scythe Level ] : [ 6 ]\n[ Damage ] : [ 55 ]\n[ Level Exp ] : ".. (inst.scythe_level))
elseif inst.scythe_level >= 600 and inst.scythe_level < 700 then
	inst.components.talker:Say("[ Scythe Level ] : [ 7 ]\n[ Damage ] : [ 60 ]\n[ Level Exp ] : ".. (inst.scythe_level))
elseif inst.scythe_level >= 700 and inst.scythe_level < 800 then
	inst.components.talker:Say("[ Scythe Level ] : [ 8 ]\n[ Damage ] : [ 65 ]\n[ Level Exp ] : ".. (inst.scythe_level))
elseif inst.scythe_level >= 800 and inst.scythe_level < 900 then
	inst.components.talker:Say("[ Scythe Level ] : [ 9 ]\n[ Damage ] : [ 70 ]\n[ Level Exp ] : ".. (inst.scythe_level))
elseif inst.scythe_level >= 900 then
	inst.components.talker:Say("[ Scythe Level ] : [ MAX ]\n[ Damage ] : [ 85 ]")
	end
end


local function CheckDamage(inst, data)
if not inst.NoPower then
if inst.scythe_level >= 0 and inst.scythe_level < 100 then
	inst.components.weapon:SetDamage(30)
elseif inst.scythe_level >= 100 and inst.scythe_level < 200 then
	inst.components.weapon:SetDamage(35)
elseif inst.scythe_level >= 200 and inst.scythe_level < 300 then
	inst.components.weapon:SetDamage(40)
elseif inst.scythe_level >= 300 and inst.scythe_level < 400 then
	inst.components.weapon:SetDamage(45)
elseif inst.scythe_level >= 400 and inst.scythe_level < 500 then
	inst.components.weapon:SetDamage(50)
elseif inst.scythe_level >= 500 and inst.scythe_level < 600 then
	inst.components.weapon:SetDamage(55)
elseif inst.scythe_level >= 600 and inst.scythe_level < 700 then
	inst.components.weapon:SetDamage(60)
elseif inst.scythe_level >= 700 and inst.scythe_level < 800 then
	inst.components.weapon:SetDamage(65)
elseif inst.scythe_level >= 800 and inst.scythe_level < 900 then
	inst.components.weapon:SetDamage(70)
elseif inst.scythe_level >= 900 and inst.scythe_level < 940 then
	inst.components.weapon:SetDamage(85)
elseif inst.scythe_level >= 940 then ----- 
		inst.components.weapon:SetDamage(85)
			inst.scythe_level = inst.scythe_level - 35
		end
	end
end

local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

local LUCK_1 = 0.4
local LUCK_2 = 0.3
local LUCK_3 = 0.25

local function OnAttack(inst, owner, target)
    if math.random() < LUCK_3 then
        local pt
        if target ~= nil and target:IsValid() then
            pt = target:GetPosition()
        else
            pt = owner:GetPosition()
            target = nil
        end
        local offset = FindWalkableOffset(pt, math.random() * 2 * PI, 2, 3, false, true, NoHoles)
        if offset ~= nil then
            inst.SoundEmitter:PlaySound("dontstarve/common/shadowTentacleAttack_1")
            inst.SoundEmitter:PlaySound("dontstarve/common/shadowTentacleAttack_2")
            local tentacle = SpawnPrefab("sch_shadowtentacle_ice")
            if tentacle ~= nil then
                tentacle.Transform:SetPosition(pt.x + offset.x, 0, pt.z + offset.z)
                tentacle.components.combat:SetTarget(target)
            end
        end
    end
    if math.random() < LUCK_3 then
        local pt
        if target ~= nil and target:IsValid() then
            pt = target:GetPosition()
        else
            pt = owner:GetPosition()
            target = nil
        end
        local offset = FindWalkableOffset(pt, math.random() * 2 * PI, 2, 3, false, true, NoHoles)
        if offset ~= nil then
            inst.SoundEmitter:PlaySound("dontstarve/common/shadowTentacleAttack_1")
            inst.SoundEmitter:PlaySound("dontstarve/common/shadowTentacleAttack_2")
            local tentacle = SpawnPrefab("sch_shadowtentacle_fire")
            if tentacle ~= nil then
                tentacle.Transform:SetPosition(pt.x + offset.x, 0, pt.z + offset.z)
                tentacle.components.combat:SetTarget(target)
            end
        end
    end
	if math.random() < LUCK_1 then
		if target ~= nil and target:IsValid() then
			if owner.components.health ~= nil and 
			   owner.components.health:GetPercent() < 1 and not (target:HasTag("wall") or target:HasTag("engineering")) then
			   owner.components.health:DoDelta(15, 2, true, nil, false)
				if owner.components.sanity then
				   owner.components.sanity:DoDelta(-.2 * 1.2)
				end
				if owner.components.hunger then
					owner.components.hunger:DoDelta(-.5 * 1.5)
				end
			end
		end
	end
	if math.random() < LUCK_2 then
		inst.components.talker:Say("[ Scythe Exp Point ] : [ +3 ] ")
		inst.scythe_level = inst.scythe_level + 3
		CheckDamage(inst)
	end
if not inst.components.fueled:IsEmpty() then
				inst.components.fueled:DoDelta(-0.25)
			else
		inst.components.talker:Say("[ Scythe need Fuel ] \n[ Damage ] : [ 15 ] ")
	end
	
	--- Hit effects
if target ~= nil and target:IsValid() then
local x, y, z = target.Transform:GetWorldPosition()
	if not inst.ActiveWeapon then
		local fx1 = SpawnPrefab("sch_weaponsparks") 
		local fx2 = SpawnPrefab("sch_weaponsparks_bounce")
		local pos = Vector3(target.Transform:GetWorldPosition())
			fx1.Transform:SetScale(1.25, 1.25, 1.25) -- (0.3, 0.3, 0.3) --- groundpoundring_fx
			fx2.Transform:SetScale(1.5, 1.5, 1.5) -- (0.45, 0.45, 0.45) --- groundpoundring_fx
			fx1.Transform:SetPosition(pos:Get())
			TheWorld:DoTaskInTime(0.2, function() fx2.Transform:SetPosition(pos:Get()) end)
	elseif inst.ActiveWeapon then
		local fx_1 = SpawnPrefab("hammer_mjolnir_crackle")
		local fx_2 = SpawnPrefab("hammer_mjolnir_cracklebase")
		local pos_0 = Vector3(target.Transform:GetWorldPosition())
		
		      -- fx_1.Transform:SetPosition(x, y, z)
			  fx_1.Transform:SetPosition(pos_0:Get())
			  fx_1.Transform:SetScale(0.7, 0.7, 0.7)
			  
		      -- fx_2.Transform:SetPosition(x, y, z)
			  fx_2.Transform:SetPosition(pos_0:Get())
			  fx_1.Transform:SetScale(0.7, 0.7, 0.7)
			  
			  target.components.health:DoDelta(-20)
			if owner.components.sanity then
			   owner.components.sanity:DoDelta(-2)
			end
		end
	end
end

local function OnUseItem(inst)
	if not inst.ActiveWeapon then
		inst.ActiveWeapon = true
		inst.components.useableitem:StopUsingItem()
	--	inst.components.weapon.stimuli = "electric"
	--	inst.components.talker:Say("[ Bonus Damage & Stimult : On ]\n[ Sanity Cost/hit : -2 ]")
		inst.components.talker:Say("[ Bonus Damage ]\n[ Sanity Cost/hit : -2 ]")
	elseif inst.ActiveWeapon then
		inst.ActiveWeapon = false
		inst.components.useableitem:StopUsingItem()
	--	inst.components.weapon.stimuli = nil
	--	inst.components.talker:Say("[ Default Damage & Stimult : Off ]\n[ Default Sanity Cost ]")
		inst.components.talker:Say("[ Default Damage ]\n[ Default Sanity Cost ]")
	end
end

--[[ Nerf ;)
local function OnUseItem(inst)
	if not inst.Scythe_Combo_Mode_1 and not inst.Scythe_Combo_Mode_2 then
		inst.Scythe_Combo_Mode_1 = true
			inst.Scythe_Combo_Mode_2 = false
				inst:AddTag("lungatk1")
					inst:RemoveTag("lungeweaps")
			inst.components.useableitem:StopUsingItem()
		inst.components.weapon.stimuli = nil
			inst.components.talker:Say("[ Scythe Mode Combo ]\n[ 1st Combo ]")
	elseif inst.Scythe_Combo_Mode_1 and not inst.Scythe_Combo_Mode_2 then
		inst.Scythe_Combo_Mode_1 = false
			inst.Scythe_Combo_Mode_2 = true
				inst:RemoveTag("lungatk1")
					inst:AddTag("lungeweaps")
			inst.components.useableitem:StopUsingItem()
		inst.components.weapon.stimuli = "electric"
			inst.components.talker:Say("[ Scythe Mode Combo ]\n[ 2nd Combo ]")
	elseif not inst.Scythe_Combo_Mode_1 and inst.Scythe_Combo_Mode_2 then
		inst.Scythe_Combo_Mode_1 = false
			inst.Scythe_Combo_Mode_2 = false
				inst:RemoveTag("lungatk1")
					inst:RemoveTag("lungeweaps")
				inst.components.useableitem:StopUsingItem()
		inst.components.weapon.stimuli = nil
			inst.components.talker:Say("[ Scythe Mode Combo ]\n[ OFF ]")
	end
end
]]--

local function OnDropped(inst, data)

end 

local function OnPutIn(inst, data)

end 

local function OnTakeFuel(inst, data)
    if inst.components.equippable:IsEquipped() and
        not inst.components.fueled:IsEmpty() and
        inst.components.cooldown.onchargedfn == nil then
        inst.components.cooldown.onchargedfn = OnChargedFn
        inst.components.cooldown:StartCharging(TUNING.ARMOR_SKELETON_FIRST_COOLDOWN)
    end
	inst.NoPower = false 
	CheckDamage(inst)
	print("Fuel Taken")
end

local function OnChosen(inst,owner)
	return owner.prefab == "schwarzkirsche"
end 

local function OnGetItemFromPlayer(inst, giver, item)
		local max_fuel = 300
		local min_fuel = 0
		local scythe_shield = inst.components.fueled.currentfuel


				local mx2 = math.floor(max_fuel - min_fuel)
				local cur2 = math.floor(scythe_shield - min_fuel)
				local scytheshield = ""..math.floor(cur2*300/mx2).."%/300%"
				
if item.prefab == "sch_dark_soul" then
		local current2 = inst.components.fueled:GetPercent() + 0.1
			inst.components.fueled:SetPercent(current2)
			inst.NoPower = false CheckDamage(inst)
			inst.components.talker:Say("[ Soul Fuel ]\n[ Scythe Exp Point ] : [ +5 ]\n[ Current Fuel ] : "..(scytheshield))
			inst.scythe_level = inst.scythe_level + 5
	end
if item:HasTag("LUXURYFUEL") then
		local current2 = inst.components.fueled:GetPercent() + 0.2
			inst.components.fueled:SetPercent(current2)
			inst.NoPower = false CheckDamage(inst)
			inst.components.talker:Say("[ Luxury Fuel ]\n[ Scythe Exp Point ] : [ +10 ]\n[ Current Fuel ] : "..(scytheshield))
			inst.scythe_level = inst.scythe_level + 10
	end
end

local function OnEquiped(inst, owner)
	owner.AnimState:OverrideSymbol("swap_object", "sch_swap_scythe", "swap_seele_reaper")
    owner.AnimState:Show("ARM_carry")
    owner.AnimState:Hide("ARM_normal")
	CheckDamage(inst)
	
	if not inst.NoPower then
	
		local max_fuel = 300
		local min_fuel = 0
		local scythe_shield = inst.components.fueled.currentfuel
				
				local mx2 = math.floor(max_fuel - min_fuel)
				local cur2 = math.floor(scythe_shield - min_fuel)
				local scytheshield = ""..math.floor(cur2*300/mx2).."%/300%"
				
		inst.components.talker:Say("[ Scythe Charge ] : "..(scytheshield))
			inst:DoTaskInTime(3, levelexp)
	
	end
	
    inst.lastmainshield = 0
	
    if not inst.components.fueled:IsEmpty() then
        inst.components.cooldown.onchargedfn = OnChargedFn
        inst.components.cooldown:StartCharging(math.max(TUNING.ARMOR_SKELETON_FIRST_COOLDOWN, inst.components.cooldown:GetTimeToCharged()))
    end

end

local function OnUnEquiped(inst, owner)
    owner.AnimState:Hide("ARM_carry")
    owner.AnimState:Show("ARM_normal")

    inst.components.cooldown.onchargedfn = nil
    if inst.task ~= nil then
        inst.task:Cancel()
        inst.task = nil
        inst.components.resistance:SetOnResistDamageFn(OnResistDamage)
    end
    for i, v in ipairs(RESISTANCES) do
        inst.components.resistance:RemoveResistance(v)
    end

end

local function OnDurability(inst, data)
    inst.components.cooldown.onchargedfn = nil
    inst.components.cooldown:FinishCharging()
	inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
	if inst.components.fueled:IsEmpty() then
		inst.components.talker:Say("[ Scythe need Fuel ] \n[ Damage ] : [ 15 ] ")
		inst.components.weapon:SetDamage(15) 
		inst.NoPower = true 
		CheckDamage(inst)
	end
end

local function IsEmptyToUse(inst, owner)
    if inst.components.fueled:IsEmpty() then
		inst.components.talker:Say("Scythe need Fuel") 
	end
	if inst.FuelRegen then
	   inst.FuelRegen:Cancel()
	   inst.FuelRegen = nil
	end
end

local function StartRegent(inst, owner)
		local max_fuel = 300
		local min_fuel = 0
		local scythe_shield = inst.components.fueled.currentfuel
				
				local mx2 = math.floor(max_fuel - min_fuel)
				local cur2 = math.floor(scythe_shield - min_fuel)
				local scytheshield = ""..math.floor(cur2*300/mx2).."%/300%"
	
	inst.FuelRegen = inst:DoPeriodicTask(30, function(inst) 
local current2 = inst.components.fueled:GetPercent() + 0.025
    if current2 > 1 then
		inst.components.talker:Say("Shield Charge is Full")
		inst.components.fueled:SetPercent(1)
		inst.NoPower = false 
		IsEmptyToUse(inst)
		CheckDamage(inst)
	else
		inst.components.fueled:SetPercent(current2)
		inst.components.talker:Say("[ Shield Charge ] : "..(scytheshield))
		end
	end)
end

local function onsave(inst, data)
	data.scythe_level = inst.scythe_level
end

local function onpreload(inst, data)
	if data then
		if data.scythe_level then
			inst.scythe_level = data.scythe_level
			levelexp(inst)
		end
	end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    MakeInventoryPhysics(inst)
    MakeHauntableLaunch(inst)
	
    inst.AnimState:SetBank("seele_reaper")
    inst.AnimState:SetBuild("sch_scythe")
    inst.AnimState:PlayAnimation("idle")
	
    inst:AddTag("weapon")
    inst:AddTag("sharp")
    inst:AddTag("scythe")
    inst:AddTag("armoredscythe")
    inst:AddTag("schwarzsythe")
    inst:AddTag("schweapon")
    inst:AddTag("SchScythe")

	if TheSim:GetGameID() == "DST" then
		inst.entity:SetPristine()
		inst.entity:AddNetwork()
		if not TheWorld.ismastersim then
			return inst
		end
	end

	inst:AddComponent("useableitem")
	inst.components.useableitem:SetOnUseFn(OnUseItem)

    inst:AddComponent("weapon")
	inst.components.weapon:SetOnAttack(OnAttack)
--	inst.components.weapon:SetOnAttack(CheckDamage)
	inst.components.weapon:SetRange(0.3, 1)
--	inst.components.weapon:SetRange(0.7, 1)

	inst:AddComponent("talker")
    inst.components.talker.fontsize = 22
    inst.components.talker.font = TALKINGFONT
    inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
    inst.components.talker.offset = Vector3(200,-250,0)
    inst.components.talker.symbol = "swap_object"

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_scythe.tex" )

    inst:AddComponent("inspectable")
	inst.components.inspectable:RecordViews()
	
    inst:AddComponent("inventoryitem")
--	inst.components.inventoryitem.keepondeath = true
	inst.components.inventoryitem.imagename = "sch_scythe"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_scythe.xml" 
	inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
	inst.components.inventoryitem:SetOnPickupFn(OnPutIn)
	inst.components.inventoryitem:SetOnPutInInventoryFn(OnPutIn)

    inst:AddComponent("equippable")
	inst.components.equippable.dapperness = TUNING.DAPPERNESS_MED_LARGE
--	inst.components.equippable.keepondeath = true
    inst.components.equippable:SetOnEquip(OnEquiped)
    inst.components.equippable:SetOnUnequip(OnUnEquiped)
    inst.components.equippable.walkspeedmult = 1.10 -- TUNING.CANE_SPEED_MULT
	
    inst:AddComponent("fueled")
    inst.components.fueled.maxfuel = 300
    inst.components.fueled.fueltype = FUELTYPE.LUXURYGEMS
    inst.components.fueled.accepting = true
    inst.components.fueled:StopConsuming()
    inst.components.fueled:SetTakeFuelFn(OnTakeFuel)
	inst.components.fueled:SetDepletedFn(OnDurability)
    inst.components.fueled:InitializeFuelLevel(300)
	
    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 
	
	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(function(inst, item) return item.prefab == "sch_dark_soul" or item:HasTag("LUXURYFUEL") end)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.deleteitemonaccept = true

    inst:AddComponent("cooldown")
    inst.components.cooldown.cooldown_duration = 7 -- TUNING.ARMOR_SKELETON_COOLDOWN

    inst:AddComponent("resistance")
    inst.components.resistance:SetShouldResistFn(ShouldResistFn)
    inst.components.resistance:SetOnResistDamageFn(OnResistDamage)

	inst:ListenForEvent("equipped", IsEmptyToUse)
	inst:ListenForEvent("unequipped", StartRegent)
	
	inst.scythe_level = 0
	inst.OnSave = onsave
	inst.OnPreLoad = onpreload
	inst:ListenForEvent("levelup", levelexp)
	inst.task = nil
    inst.lastmainshield = 0

    return inst
end

return Prefab("common/inventory/sch_scythe", fn, assets, prefabs)