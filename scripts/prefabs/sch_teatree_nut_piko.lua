require "prefabutil"

local assets =
{
    Asset("ANIM", "anim/sch_teatree_nut.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_teatree_piko.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_teatree_piko.tex"),
	Asset("ATLAS", "images/inventoryimages/sch_teatree_piko_cooked.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_teatree_piko_cooked.tex"),
}

local prefabs =
{
    "spoiled_food"
}

local function plant(inst, growtime)
    local sapling = SpawnPrefab("acorn_sapling")
    sapling:StartGrowing()
    sapling.Transform:SetPosition(inst.Transform:GetWorldPosition())
    sapling.SoundEmitter:PlaySound("dontstarve/wilson/plant_tree")
    inst:Remove()
end

local function domonsterstop(ent)
    ent.monster_stop_task = nil
    ent:StopMonster()
end

local function ondeploy(inst, pt)
    inst = inst.components.stackable:Get()
    inst.Transform:SetPosition(pt:Get())
    local timeToGrow = GetRandomWithVariance(TUNING.ACORN_GROWTIME.base, TUNING.ACORN_GROWTIME.random)
    plant(inst, timeToGrow)

    -- Pacify a nearby monster tree
    local ent = FindEntity(inst, TUNING.DECID_MONSTER_ACORN_CHILL_RADIUS, nil, {"birchnut", "monster"}, {"stump", "burnt", "FX", "NOCLICK","DECOR","INLIMBO"})
    if ent ~= nil then
        if ent.monster_start_task ~= nil then
            ent.monster_start_task:Cancel()
            ent.monster_start_task = nil
        end
        if ent.monster and
            ent.monster_stop_task == nil and
            not (ent.components.burnable ~= nil and ent.components.burnable:IsBurning()) and
            not (ent:HasTag("stump") or ent:HasTag("burnt")) then
            ent.monster_stop_task = ent:DoTaskInTime(math.random(0, 3), domonsterstop)
        end
    end
end

local function OnLoad(inst, data)
    if data and data.growtime then
        plant(inst, data.growtime)
    end
end

local function fn()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    MakeInventoryPhysics(inst)
	inst.entity:AddMiniMapEntity()
    inst.entity:SetPristine()
	
    inst.AnimState:SetBank("teatree_nut")
    inst.AnimState:SetBuild("sch_teatree_nut")
    inst.AnimState:PlayAnimation("idle")
		
	inst.MiniMapEntity:SetIcon( "sch_teatree_piko.tex" )

    inst:AddTag("cattoy")
    inst:AddTag("cookable")
    inst:AddTag("deployedplant")
    inst:AddTag("icebox_valid")
    inst:AddTag("show_spoilage")


    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("cookable")
    inst.components.cookable.product = "sch_teatree_nut_cooked_piko"

    inst:AddComponent("tradable")

    inst:AddComponent("perishable")
    inst.components.perishable:StartPerishing()
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("edible")
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.edible.foodtype = FOODTYPE.RAW

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")

    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_teatree_piko"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_teatree_piko.xml" 
	
    inst:AddComponent("deployable")
    inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
    inst.components.deployable.ondeploy = ondeploy

    inst:AddComponent("winter_treeseed")
    inst.components.winter_treeseed:SetTree("winter_deciduoustree")

    MakeHauntableLaunchAndIgnite(inst)
    inst.OnLoad = OnLoad
    return inst
end

local function cooked()
    local inst = CreateEntity()
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddNetwork()
    inst.entity:SetPristine()
	inst.entity:AddMiniMapEntity()
    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("teatree_nut")
    inst.AnimState:SetBuild("sch_teatree_nut")
    inst.AnimState:PlayAnimation("cooked")

	inst.MiniMapEntity:SetIcon("sch_teatree_piko_cooked.tex")
	
    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("edible")
    inst.components.edible.hungervalue = TUNING.CALORIES_TINY
    inst.components.edible.healthvalue = TUNING.HEALING_TINY
    inst.components.edible.foodtype = "SEEDS"

    inst:AddComponent("perishable")
    inst.components.perishable:StartPerishing()
    inst.components.perishable:SetPerishTime(TUNING.PERISH_SLOW)
    inst.components.perishable.onperishreplacement = "spoiled_food"

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inspectable")
    MakeSmallBurnable(inst, TUNING.SMALL_BURNTIME)
    MakeSmallPropagator(inst)

    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.imagename = "sch_teatree_piko_cooked"
	inst.components.inventoryitem.atlasname = "images/inventoryimages/sch_teatree_piko_cooked.xml" 

    MakeHauntableLaunch(inst)
    return inst
end

return Prefab("sch_teatree_nut_piko", fn, assets, prefabs),
       Prefab("sch_teatree_nut_cooked_piko", cooked, assets),
       MakePlacer("sch_teatree_nut_piko_placer", "teatree_nut", "sch_teatree_nut", "idle_planted")
