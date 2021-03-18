local assets =
{ 		
	Asset("ANIM", "anim/sch_dark_soul.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_dark_soul.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_dark_soul.tex"),
}

local prefabs =
{
    "sch_dark_soul_fx",
}

local SCALE = .8

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


local function KillSoul(inst)
    inst:ListenForEvent("animover", inst.Remove)
    inst.AnimState:PlayAnimation("idle_pst")
    inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/spawn", nil, .5)
	DoHeal(inst)
end

local function toground(inst)
    inst.persists = false
    if inst._task == nil then
        inst._task = inst:DoTaskInTime(.4 + math.random() * .7, KillSoul)
    end
    if inst.AnimState:IsCurrentAnimation("idle_loop") then
        inst.AnimState:SetTime(math.random() * inst.AnimState:GetCurrentAnimationLength())
    end
end


local function topocket(inst)
    inst.persists = true
    if inst._task ~= nil then
        inst._task:Cancel()
        inst._task = nil
    end
end

local function OnDropped(inst)
    if inst.components.stackable ~= nil and inst.components.stackable:IsStack() then
        local x, y, z = inst.Transform:GetWorldPosition()
        local num = 10 - #TheSim:FindEntities(x, y, z, 4, { "darksoul" })
        if num > 0 then
            for i = 1, math.min(num, inst.components.stackable:StackSize()) do
                local darksoul = inst.components.stackable:Get()
                darksoul.Physics:Teleport(x, y, z)
                darksoul.components.inventoryitem:OnDropped(true)
            end
        end
    end
end

local function OnputIn(inst, owner)

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
	
    MakeInventoryPhysics(inst)
    RemovePhysicsColliders(inst)
	
	inst.AnimState:SetBank("wortox_soul_ball")
	inst.AnimState:SetBuild("sch_dark_soul")
	inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:SetScale(SCALE, SCALE)

	if not TheWorld.ismastersim then
        return inst
    end

	inst:AddTag("schsoul")
	inst:AddTag("darksoul")
	inst:AddTag("schwarzkirschesoul")
    
	inst.entity:SetPristine()
	
	inst.entity:AddMiniMapEntity()
	inst.MiniMapEntity:SetIcon( "sch_dark_soul" )
	
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM
--  inst.components.stackable:SetMaxSize(80)
    inst.components.stackable.forcedropsingle = true
	
	inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.canbepickedup = false
    inst.components.inventoryitem.canonlygoinpocket = true
	inst.components.inventoryitem.imagename = "sch_dark_soul"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_dark_soul.xml" 
    inst.components.inventoryitem:SetOnDroppedFn(OnDropped)
    inst.components.inventoryitem:SetOnPutInInventoryFn(OnputIn)

	inst:ListenForEvent("onputininventory", topocket)
    inst:ListenForEvent("ondropped", toground)
    inst._task = nil
    toground(inst)
	
	inst:AddComponent("inspectable")
    inst:AddComponent("darksoul")

    inst:AddComponent("characterspecific")
    inst.components.characterspecific:SetOwner("schwarzkirsche")
    inst.components.characterspecific:SetStorable(true)
    inst.components.characterspecific:SetComment("I can't hold this!") 

	inst:AddComponent("chosenpeople")
	inst.components.chosenpeople:SetChosenFn(OnChosen)

	return inst
end

return Prefab( "common/inventory/sch_dark_soul", fn, assets, prefabs)
