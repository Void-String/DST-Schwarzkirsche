require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/runaway"
require "behaviours/panic"
require "behaviours/follow"
require "behaviours/doaction"

local SchPikoBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local MIN_FOLLOW_DIST = 0
local TARGET_FOLLOW_DIST = 3
local MAX_FOLLOW_DIST = 6
local GO_HOME_DIST = 0
local START_FACE_DIST = 6
local KEEP_FACE_DIST = 8
local KEEP_WORKING_DIST = 10
local SEE_WORK_DIST = 10
local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 8
local MAX_CHASE_DIST = 10
local MAX_CHASE_TIME = 20
local SEE_ITEM_DIST = 10
local MAX_WANDER_DIST = 5
local ITEM_NEAR_PLAYER_DIST = 2.5
local SEE_TARGET_ITEM_DIST = 10


local function GetLeader(inst)
    return inst.components.follower.leader 
end
local function GetFaceTargetFn(inst)
    local target = GetClosestInstWithTag("player", inst, START_FACE_DIST)
    if target and not target:HasTag("notarget") then
        return target
			else
		print("Warning : Piko not follwing leader / Piko not Respoding / Piko Stop Following Leader While Farming : Kill Piko!")
    end
end
local function KeepFaceTargetFn(inst, target)
    return inst:IsNear(target, KEEP_FACE_DIST) and not target:HasTag("notarget")
end
local function GetLeader(inst)
    return inst.components.follower.leader 
end
local function IsNearLeader(inst, dist)
    local leader = GetLeader(inst)
    return leader ~= nil and inst:IsNear(leader, dist)
end
local function NearPlayer(inst, dist)
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 20)
	for k,v in pairs(ents) do
		if v:HasTag("player") then 
			return v
		end 
	end
end

------------------------------------[[FARM 2 : HARVEST ]]------------------------------------------
local ItemInList2 = { 
 "green_fruit", "berries", 						"cave_banana", "carrot", 
 "red_cap", "blue_cap", 						"green_cap", "corn", 
 "pumpkin", "eggplant",							"durian", "pomegranate", 
 "dragonfruit", "cactus_meat", 					"watermelon", "smallmeat", 
 "smallmeat_dried", "monstermeat", 				"monstermeat_dried", "humanmeat", 
 "humanmeat_dried", "meat", 					"meat_dried", "cutgrass", 
 "twigs", "cutreeds", 							"coffe_beans_raw", "coffe_beans",
 "cutwheat", "tee", 							"tee_g", "tee_m", 
 "tee_s", "tee_r", 								"tee_r2", 
 
 "dragonpie", 
 "waffles", "ratatouille", 						"fruitmedley", "monsterlasagna", 
 "frogglebunwich", "pumpkincookie", 			"pumpkincookie", "honeyham", 
 "meatballs", "wetgoop", 						"stuffedeggplant", "taffy", 
 "honeynuggets", "turkeydinner", 				"fishsticks", "jammypreserves", 
 "fishtacos", "butterflymuffin", 				"perogies", "kabobs", 
 "bonestew", "baconeggs", 						"mandrakesoup",  "sweet_potato", 
 "seaweed", 
 
}

------------------------------------[[FARM 1 : NON EDBILE ITEM & DROPPED ITEM]]------------------------------------------
local ItemInList1 = {
	"goldnugget", "rocks", 						"cutstone", "nitre", 
	"flint", "thulecite", 						"thulecite_pieces", 
	"marble", "redgem", 						"purplegem", "bluegem", 
	"yellowgem", "greengem", 					"orangegem", "log", 
	"boards", "cutgrass", 						"dug_berrybush","dug_berrybush2",
	"dug_coffeebush","dug_grass", 				"rope", "twigs", "dug_sapling", 
	"gears", "spidergland", 					"healingsalve", "mosquitosack", 
	"silk", "spidereggsack", 					"ash", "poop", 
	"guano", "charcoal", 						"beefalowool", "cutreeds", 
	"houndstooth", "ice", 						"stinger", "livinglog", 
	"lightbulb", "slurper_pelt", 				"honeycomb", "arrowm",
	"turf_road", "turf_rocky", 					"turf_forest", "turf_marsh", 
	"turf_grass", "turf_savanna", 				"turf_dirt", "turf_woodfloor", 
	"turf_carpetfloor", "turf_checkerfloor", 	"turf_cave", "turf_fungus", 
	"turf_fungus_red", "turf_fungus_green", 	"turf_sinkhole", "turf_underrock", 
	"turf_mud", "walrus_tusk", "houndstooth",	"wormlight_lesser", "wormlight", 
	"nightmarefuel", "manrabbit_tail", 			"beardhair", "trinket_1", 
	"trinket_2", "trinket_3", 					"trinket_4", "trinket_5", 
	"trinket_6", "trinket_7", 					"trinket_8", "trinket_9", 
	"trinket_10", "trinket_11", 				"trinket_12", "coontail", 
	"tentaclespots", "beefalowool", 			"horn", "feather_robin", 
	"feather_robin_winter",						"feather_crow", "boneshard", 
	"transistor", "boomerang",					"goose_feather", "drumstick", 
	"bearger_fur", "dragon_scales", 			"pigskin", "cutwheat", "dug_wheat",
	"acorn",									"pinecone",
 --	DLC 2
	"coral", "bamboo", 							"dug_bambootree", "vine", 
	"dug_bush_vine", "limestone", 				"obsidian", "palmleaf", 
	"snakeoil", "snakeskin", 					"messagebottle", "messagebottleempty", 
	"fabric","turf_jungle",						"turf_swamp","turf_volcano",
	"turf_tidalmarsh","turf_meadow",			"hail_ice","sand", 
	"coconut", "coffe_beans_raw", 				"coffe_beans", "cutwheat", 
	"tee", "tee_g", 							"tee_m", "tee_s", 
	"tee_r", "tee_r2",							"dug_coffebush", "dug_tee_tree", 
	"dug_wheat",
 --	DLC 3
}
local function ItemIsInList(item, list)
    for k,v in pairs(list) do
        if v == item or k == item then
            return true
        end
    end
end
------------------------------------[[FARM 1 : NON EDBILE ITEM & DROPPED ITEM]]------------------------------------------
local function PickupAction(inst)
    if not inst.components.inventory:IsFull() then
        local target = FindEntity(inst, SEE_TARGET_ITEM_DIST, 
            function(item)
                local x,y,z = item.Transform:GetWorldPosition()
                local isValidPosition = x and y and z
                local isValidPickupItem = (ItemIsInList( item.prefab , ItemInList1)) and
                    isValidPosition and
                    item.components.inventoryitem and not 
					item.components.inventoryitem:IsHeld() and
                    item.components.inventoryitem.canbepickedup and
					IsNearLeader(inst, KEEP_WORKING_DIST) and
                    item:IsOnValidGround() and
                    not item:HasTag("trap")
                return isValidPickupItem 
            end)
		local player = NearPlayer(inst)
		if target and not target:IsNear(player, ITEM_NEAR_PLAYER_DIST) and inst.CanPickUpItem1 then
			return BufferedAction(inst, target, ACTIONS.PICKUP)
		end
	end
-----------------------------------------------------------------------------------------------------------
    if not inst.components.inventory:IsFull() then
        local target = FindEntity(inst, SEE_TARGET_ITEM_DIST, 
            function(item)
                local x,y,z = item.Transform:GetWorldPosition()
                local isValidPosition = x and y and z
                local isValidPickupItem = (ItemIsInList( item.prefab , ItemInList2)) and
                    isValidPosition and
                    item.components.inventoryitem and not 
					item.components.inventoryitem:IsHeld() and
                    item.components.inventoryitem.canbepickedup and
					IsNearLeader(inst, KEEP_WORKING_DIST) and
                    item:IsOnValidGround() and
                    not item:HasTag("trap")
                return isValidPickupItem 
            end)
		local player = NearPlayer(inst)
		if target and not target:IsNear(player, ITEM_NEAR_PLAYER_DIST) and inst.CanPickUpItem2 then
			return BufferedAction(inst, target, ACTIONS.PICKUP)
		end
	end
-----------------------------------------------------------------------------------------------------------
    if not inst.components.inventory:IsFull() then
        local target = FindEntity(inst, SEE_TARGET_ITEM_DIST, 
            function(item)
                local x,y,z = item.Transform:GetWorldPosition()
                local isValidPosition = x and y and z
                local isValidPickupItem = 
                    isValidPosition and
                    (item.components.crop and item.components.crop:IsReadyForHarvest()) or
					(item.components.dryer and item.components.dryer:IsDone()) or
					(item.components.stewer and item.components.stewer:IsDone()) and
					IsNearLeader(inst, KEEP_WORKING_DIST) 
                return isValidPickupItem 
            end)
		local player = NearPlayer(inst)
		if target and not target:IsNear(player, ITEM_NEAR_PLAYER_DIST) and inst.CanFarming then
			return BufferedAction(inst, target, ACTIONS.HARVEST)
		end
	end
-----------------------------------------------------------------------------------------------------------
end

function SchPikoBrain:OnStart()
    local root = PriorityNode(
    {
		DoAction(self.inst, PickupAction, "searching for prize", true),
        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
--		Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST),
        IfNode(function() return GetLeader(self.inst) end, "has leader",            
            FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn )),
    }, 1.5)
    self.bt = BT(self.inst, root)    
end

return SchPikoBrain