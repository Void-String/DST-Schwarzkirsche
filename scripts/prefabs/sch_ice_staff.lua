local assets =
{
    Asset("ANIM", "anim/sch_ice_staff.zip"),
    Asset("ANIM", "anim/sch_swap_ice_staff.zip"),
    Asset("ATLAS", "images/inventoryimages/sch_ice_staff.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_ice_staff.tex"),
}

local prefabs =
{
    "ice_projectile",
    "staffcastfx",
    "stafflight",
}

---------ICE STAFF---------
local function OnGetItemFromPlayer(inst, giver, item)
    local current = inst.components.finiteuses:GetPercent() + 0.5
    if current > 1 then
        inst.components.finiteuses:SetPercent(1)
    else
        inst.components.finiteuses:SetPercent(current)
    end
end

local function onattack_blue(inst, attacker, target, skipsanity)
    local current = inst.components.finiteuses:GetUses()
    if current <= 0 then return end
    if not skipsanity and attacker ~= nil and attacker.components.sanity ~= nil then
        attacker.components.sanity:DoDelta(-TUNING.SANITY_SUPERTINY)
    end

    if not target:IsValid() then
        --target killed or removed in combat damage phase
        return
    end

    if target.components.sleeper ~= nil and target.components.sleeper:IsAsleep() then
        target.components.sleeper:WakeUp()
    end

    if target.components.burnable ~= nil then
        if target.components.burnable:IsBurning() then
            target.components.burnable:Extinguish()
        elseif target.components.burnable:IsSmoldering() then
            target.components.burnable:SmotherSmolder()
        end
    end

    if target.components.combat ~= nil then
        target.components.combat:SuggestTarget(attacker)
    end

    if target.sg ~= nil and not target.sg:HasStateTag("frozen") then
        target:PushEvent("attacked", { attacker = attacker, damage = 0 })
    end

    if target.components.freezable ~= nil then
        target.components.freezable:AddColdness(1)
        target.components.freezable:SpawnShatterFX()
    end
end

local function onhauntblue(inst, haunter)
    if math.random() <= 0.5 --[[ TUNING.HAUNT_CHANCE_RARE]] then
        local x, y, z = inst.Transform:GetWorldPosition() 
        local ents = TheSim:FindEntities(x, y, z, 6, { "freezable" }, { "INLIMBO" })
        if #ents > 0 then
            for i, v in ipairs(ents) do
                if v:IsValid() and not v:IsInLimbo() then
                    onattack_blue(inst, haunter, v, true) 
                end
            end
            inst.components.hauntable.hauntvalue = TUNING.HAUNT_LARGE
            return true
        end
    end
    return false
end

local function createicespell(staff, target, pos)
    local current = staff.components.finiteuses:GetPercent()
    if current < 0.25 then 
        return
    else
        staff.components.finiteuses:SetPercent(current - 0.25)
    end

    local spell = SpawnPrefab("deer_ice_circle")
    local fx = SpawnPrefab("deer_ice_fx")
    local x, y, z = pos:Get()
    local caster = staff.components.inventoryitem.owner
    spell.Transform:SetPosition(pos:Get())
    fx.Transform:SetPosition(pos:Get())
    spell:DoTaskInTime(1, function()
        local ents = TheSim:FindEntities(x, y, z, 3, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
            end
        end
    end)
    spell:DoTaskInTime(2, function()
        local ents = TheSim:FindEntities(x, y, z, 3, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
            end
        end
    end)
    spell:DoTaskInTime(3, function()
        local ents = TheSim:FindEntities(x, y, z, 3, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
            end
        end
    end)
    spell:DoTaskInTime(4, function()
        local ents = TheSim:FindEntities(x, y, z, 3, nil, {"player"})
        for k, v in pairs(ents) do
            if v.components.freezable ~= nil then
                v.components.freezable:AddColdness(2)
                v.components.freezable:SpawnShatterFX()
            end
        end
    end)        
    spell:DoTaskInTime(6, spell.KillFX) --持续6秒
    fx:DoTaskInTime(5, function()
        local ents = TheSim:FindEntities(x, y, z, 3, nil, {"player"})
        for k, v in pairs(ents) do
            if v and v.components.health and not v.components.health:IsDead() then
                local prefab = "icespike_fx_"..math.random(1,4)
                local icespike = SpawnPrefab(prefab)
                local targetPos = v:GetPosition()
                local tx, ty, tz = targetPos:Get()
                icespike.Transform:SetPosition(tx,ty,tz)
                icespike.Transform:SetScale(2,2,2)
                v.components.health:DoDelta(-25)
                v:PushEvent("attacked", { attacker = caster, damage = 0 })
            end
        end    
        fx:Remove()
    end)

    if caster ~= nil and caster.components.sanity ~= nil then
        caster.components.sanity:DoDelta(-10)
    end
    print("Ice Magic!")
end
-----COMMON FUNCTIONS---------

local function onfinished(inst)
    inst.SoundEmitter:PlaySound("dontstarve/common/gem_shatter")
end

local function unimplementeditem(inst)
    local player = ThePlayer
    player.components.talker:Say(GetString(player, "ANNOUNCE_UNIMPLEMENTED"))
    if player.components.health.currenthealth > 1 then
        player.components.health:DoDelta(-player.components.health.currenthealth * 0.5)
    end

    if inst.components.useableitem then
        inst.components.useableitem:StopUsingItem()
    end
end

local onunequip = function(inst, owner) 
    owner.AnimState:Hide("ARM_carry") 
    owner.AnimState:Show("ARM_normal") 
end

local function OnChosen(inst,owner)
	return owner.prefab == "schwarzkirsche"
end 

local function commonfn(colour, tags)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()

	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_ice_staff.tex" )

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("icestaff")
    inst.AnimState:SetBuild("sch_ice_staff")
    inst.AnimState:PlayAnimation("idle_90s")

    if tags ~= nil then
        for i, v in ipairs(tags) do
            inst:AddTag(v)
        end
    end

    inst.entity:SetPristine()
    
    if not TheWorld.ismastersim then
        return inst
    end

    inst.castsound = "dontstarve/common/staffteleport"

    -------   
    inst:AddComponent("finiteuses")
    inst.components.finiteuses:SetOnFinished(onfinished)

    inst:AddComponent("inspectable")
    
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "sch_ice_staff"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_ice_staff.xml"
    
    inst:AddComponent("tradable")

    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(function(inst, owner) 
        owner.AnimState:OverrideSymbol("swap_object", "sch_swap_ice_staff", "icestaff")
        owner.AnimState:Show("ARM_carry") 
        owner.AnimState:Hide("ARM_normal") 
    end)
    inst.components.equippable:SetOnUnequip(onunequip)

    return inst
end

local function blue()
    local inst = commonfn("blue", { "icestaff", "extinguisher" })

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("spellcaster")
    inst.components.spellcaster:SetSpellFn(createicespell)
    inst.components.spellcaster.canuseonpoint = true
    --inst.components.spellcaster.quickcast = true

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)
    inst.components.weapon:SetRange(10)
    inst.components.weapon:SetOnAttack(onattack_blue)
    inst.components.weapon:SetProjectile("ice_projectile")

    inst.components.finiteuses:SetMaxUses(100)
    inst.components.finiteuses:SetUses(100)

    inst:AddComponent("trader")
    inst.components.trader:SetAcceptTest(function(inst, item) return item.prefab == "bluegem" end)
    inst.components.trader.onaccept = OnGetItemFromPlayer
    inst.components.trader.deleteitemonaccept = true
    
    MakeHauntableLaunch(inst)
    AddHauntableCustomReaction(inst, onhauntblue, true, false, true)

    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

    return inst
end

return Prefab("sch_ice_staff", blue, assets, prefabs)