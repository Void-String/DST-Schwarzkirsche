local assets =
{ 		
	Asset("ANIM", "anim/sch_dark_soul.zip"),
}

local prefabs =
{
    "sch_dark_soul_in",
    "sch_dark_soul",
    "sch_dark_soul_fx",
}

local SCALE = .8
local SPEED = 10

local function CreateTail()
    local inst = CreateEntity()

    inst:AddTag("FX")
    inst:AddTag("NOCLICK")
    --[[Non-networked entity]]
    inst.entity:SetCanSleep(false)
    inst.persists = false

    inst.entity:AddTransform()
    inst.entity:AddAnimState()

    MakeInventoryPhysics(inst)
    inst.Physics:ClearCollisionMask()

    inst.AnimState:SetBank("wortox_soul_ball")
    inst.AnimState:SetBuild("sch_dark_soul")
    inst.AnimState:PlayAnimation("disappear")
    inst.AnimState:SetScale(SCALE, SCALE)
    inst.AnimState:SetFinalOffset(-1)

    inst:ListenForEvent("animover", inst.Remove)

    return inst
end

local function OnUpdateProjectileTail(inst)--, dt)
    local x, y, z = inst.Transform:GetWorldPosition()
    for tail, _ in pairs(inst._tails) do
        tail:ForceFacePoint(x, y, z)
    end
    if inst.entity:IsVisible() then
        local tail = CreateTail()
        local rot = inst.Transform:GetRotation()
        tail.Transform:SetRotation(rot)
        rot = rot * DEGREES
        local offsangle = math.random() * 2 * PI
        local offsradius = (math.random() * .2 + .2) * SCALE
        local hoffset = math.cos(offsangle) * offsradius
        local voffset = math.sin(offsangle) * offsradius
        tail.Transform:SetPosition(x + math.sin(rot) * hoffset, y + voffset, z + math.cos(rot) * hoffset)
        tail.Physics:SetMotorVel(SPEED * (.2 + math.random() * .3), 0, 0)
        inst._tails[tail] = true
        inst:ListenForEvent("onremove", function(tail) inst._tails[tail] = nil end, tail)
        tail:ListenForEvent("onremove", function(inst)
            tail.Transform:SetRotation(tail.Transform:GetRotation() + math.random() * 30 - 15)
        end, inst)
    end
end

local function OnHit(inst, attacker, target)
    if target ~= nil then
        local x, y, z = inst.Transform:GetWorldPosition()
        local fx = SpawnPrefab("sch_dark_soul_in")
        fx.Transform:SetPosition(x, y, z)
        fx:Setup(target)
        --ignore .isvisible, as long as it's .isopen
        if target.components.inventory ~= nil and target.components.inventory.isopen then
            target.components.inventory:GiveItem(SpawnPrefab("sch_dark_soul"), nil, target:GetPosition())
        else
            --reuse fx variable
            fx = SpawnPrefab("sch_dark_soul")
            fx.Transform:SetPosition(x, y, z)
            fx.components.inventoryitem:OnDropped(true)
        end
    end
    inst:Remove()
end

local function OnHasTailDirty(inst)
    if inst._hastail:value() and inst._tails == nil then
        inst._tails = {}
        if inst.components.updatelooper == nil then
            inst:AddComponent("updatelooper")
        end
        inst.components.updatelooper:AddOnUpdateFn(OnUpdateProjectileTail)
    end
end

local function OnThrownTimeout(inst)
    inst._timeouttask = nil
    inst.components.projectile:Miss(inst.components.projectile.target)
end

local function OnThrown(inst)
    if inst._timeouttask ~= nil then
        inst._timeouttask:Cancel()
    end
    inst._timeouttask = inst:DoTaskInTime(6, OnThrownTimeout)
    if inst._seektask ~= nil then
        inst._seektask:Cancel()
        inst._seektask = nil
    end
    inst.AnimState:Hide("blob")
    inst._hastail:set(true)
    OnHasTailDirty(inst)
end

local function SeekSoulStealer(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local closestPlayer = nil
    local rangesq = TUNING.WORTOX_SOULSTEALER_RANGE * TUNING.WORTOX_SOULSTEALER_RANGE
    for i, v in ipairs(AllPlayers) do
        if v:HasTag("soulcollector") and
            not (v.components.health:IsDead() or v:HasTag("playerghost")) and
            not (v.sg ~= nil and (v.sg:HasStateTag("nomorph") or v.sg:HasStateTag("silentmorph"))) and
            v.entity:IsVisible() then
            local distsq = v:GetDistanceSqToPoint(x, y, z)
            if distsq < rangesq then
                rangesq = distsq
                closestPlayer = v
            end
        end
    end
    if closestPlayer ~= nil then
        inst.components.projectile:Throw(inst, closestPlayer, inst)
    end
end

local function EndBlockSoulHealFX(v)
    v.blocksoulhealfxtask = nil
end

local function DoHeal(inst)
    local targets = {}
    local x, y, z = inst.Transform:GetWorldPosition()
    for i, v in ipairs(AllPlayers) do
        if not (v.components.health:IsDead() or v:HasTag("playerghost")) and
            v.entity:IsVisible() and
            v:GetDistanceSqToPoint(x, y, z) < TUNING.WORTOX_SOULHEAL_RANGE * TUNING.WORTOX_SOULHEAL_RANGE then
            table.insert(targets, v)
        end
    end
    if #targets > 0 then
        local amt = TUNING.HEALING_MED - math.min(8, #targets) + 1
        for i, v in ipairs(targets) do
            --always heal, but don't stack visual fx
            v.components.health:DoDelta(amt, nil, inst.prefab)
            if v.blocksoulhealfxtask == nil then
                v.blocksoulhealfxtask = v:DoTaskInTime(.5, EndBlockSoulHealFX)
                local fx = SpawnPrefab("sch_dark_soul_fx")
                fx.entity:AddFollower():FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0)
                fx:Setup(v)
            end
        end
    end
end

local function OnTimeout(inst)
    inst._timeouttask = nil
    if inst._seektask ~= nil then
        inst._seektask:Cancel()
        inst._seektask = nil
    end
    inst:ListenForEvent("animover", inst.Remove)
    inst.AnimState:PlayAnimation("idle_pst")
    inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/spawn", nil, .5)

    DoHeal(inst)
end

local TINT = { r = 154 / 255, g = 23 / 255, b = 19 / 255 }

local function PushColour(inst, addval, multval)
    if inst.components.highlight == nil then
        inst.AnimState:SetHighlightColour(TINT.r * addval, TINT.g * addval, TINT.b * addval, 0)
        inst.AnimState:OverrideMultColour(multval, multval, multval, 1)
    else
        inst.AnimState:OverrideMultColour()
    end
end

local function PopColour(inst)
    if inst.components.highlight == nil then
        inst.AnimState:SetHighlightColour()
    end
    inst.AnimState:OverrideMultColour()
end

local function OnUpdateTargetTint(inst)--, dt)
    if inst._tinttarget:IsValid() then
        local curframe = inst.AnimState:GetCurrentAnimationTime() / FRAMES
        if curframe < 15 then
            local k = curframe / 15
            k = k * k
            PushColour(inst._tinttarget, 1 - k, k)
        else
            inst.components.updatelooper:RemoveOnUpdateFn(OnUpdateTargetTint)
            inst.OnRemoveEntity = nil
            PopColour(inst._tinttarget)
        end
    else
        inst.components.updatelooper:RemoveOnUpdateFn(OnUpdateTargetTint)
        inst.OnRemoveEntity = nil
    end
end

local function OnRemoveEntity(inst)
    if inst._tinttarget:IsValid() then
        PopColour(inst._tinttarget)
    end
end

local function OnTargetDirty(inst)
    if inst._target:value() ~= nil and inst._tinttarget == nil then
        if inst.components.updatelooper == nil then
            inst:AddComponent("updatelooper")
        end
        inst.components.updatelooper:AddOnUpdateFn(OnUpdateTargetTint)
        inst._tinttarget = inst._target:value()
        inst.OnRemoveEntity = OnRemoveEntity
    end
end

local function Setup(inst, target)
    inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/spawn", nil, .5)
    inst._target:set(target)
    OnTargetDirty(inst)
end

local function fn()
	local inst = CreateEntity()
	
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
	
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
	
	inst.AnimState:SetBank("wortox_soul_ball")
	inst.AnimState:SetBuild("sch_dark_soul")
    inst.AnimState:PlayAnimation("idle_pre")
    inst.AnimState:SetScale(SCALE, SCALE)
    inst.AnimState:SetFinalOffset(-1)
	inst.entity:SetPristine()

    inst:ListenForEvent("targetdirty", OnTargetDirty)
    inst:ListenForEvent("hastaildirty", OnHasTailDirty)
	
	if not TheWorld.ismastersim then
        return inst
    end

    inst:AddTag("FX")
	inst:AddTag("weapon")
    inst:AddTag("projectile")
	inst:AddTag("schsoulfx")
	inst:AddTag("darksoulfx")
	inst:AddTag("schwarzkirschesoulfx")
	
    inst._target = net_entity(inst.GUID, "sch_dark_soul._target", "targetdirty")
    inst._hastail = net_bool(inst.GUID, "sch_dark_soul._hastail", "hastaildirty")

	inst.AnimState:PushAnimation("idle_loop", true)

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(0)

    inst:AddComponent("projectile")
    inst.components.projectile:SetSpeed(SPEED)
    inst.components.projectile:SetHitDist(.5)
    inst.components.projectile:SetOnThrownFn(OnThrown)
    inst.components.projectile:SetOnHitFn(OnHit)
    inst.components.projectile:SetOnMissFn(inst.Remove)

    inst._seektask = inst:DoPeriodicTask(.5, SeekSoulStealer, 1)
    inst._timeouttask = inst:DoTaskInTime(10, OnTimeout)

    inst.persists = false
    inst.Setup = Setup

    return inst
end

return Prefab( "common/inventory/sch_dark_soul_spawn", fn, assets, prefabs)
