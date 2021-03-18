require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
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
local KEEP_WORKING_DIST = 15
local SEE_WORK_DIST = 10
local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 8
local MAX_CHASE_DIST = 10
local MAX_CHASE_TIME = 20
local SEE_ITEM_DIST = 10
local MAX_WANDER_DIST = 5
local ITEM_NEAR_PLAYER_DIST = 1
local SEE_TARGET_ITEM_DIST = 10


local function GetLeader(inst)
    return inst.components.follower.leader 
end

local function IsNearLeader(inst, dist)
    local leader = GetLeader(inst)
    return leader ~= nil and inst:IsNear(leader, dist)
end

local function GetFaceTargetFn(inst)
    local target = GetClosestInstWithTag("player", inst, START_FACE_DIST)
    if target and not target:HasTag("notarget") then
        return target
    end
end

local function KeepFaceTargetFn(inst, target)
    return inst:IsNear(target, KEEP_FACE_DIST) and not target:HasTag("notarget")
end
-----------------------------------------------------------------------------------------------------
local IsItem = {
	"goldnugget", 
	"rocks", 
	"nitre", 
	"flint", 
	"marble", 
	"log",
	"twigs", 
	"ash", 
	"nightmarefuel",
	"feather_robin", 
	"feather_robin_winter", 
	"feather_crow", 
	"feather_canary", 
	"boneshard",
	"acorn", 
	"pinecone", 
}
local function ItemIsInList(item, list)
    for k,v in pairs(list) do
        if v == item or k == item then
            return true
        end
    end
end
local function IsCanPickItem(inst)
    return inst.CanPickUpItem 
end
local function TheItem(inst)
    local target = FindEntity(inst, SEE_ITEM_DIST, function(item) return (ItemIsInList( item.prefab , IsItem)) and (not item:HasTag("no_edible")) and (not inst:HasTag("fire")) end)
    if target and not 
		inst.InventoryIsFull then 
	end
    return target
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
local function FindTheItem(inst)
    local target = TheItem(inst)
	local player = NearPlayer(inst)
	if target and not target:IsNear(player, ITEM_NEAR_PLAYER_DIST) and not inst.InventoryIsFull then
		return BufferedAction(inst,target,	ACTIONS.PICKUP)
	end	  
end
-----------------------------------------------------------------------------------------------------
function SchPikoBrain:OnStart()
    local root = PriorityNode(
    {
--[[
		SequenceNode{
		ConditionNode(function() return IsNearLeader(self.inst, KEEP_WORKING_DIST) and IsCanPickItem(self.inst) and TheItem(self.inst) end, "collect item"),
        ParallelNodeAny { WaitNode(0.25),DoAction(self.inst, function(item) return FindTheItem(self.inst) end),},},

		WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
		ChaseAndAttack(self.inst, MAX_CHASE_DIST, MAX_CHASE_TIME)),
		
		WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() end, "Dodge",
		RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
]]
        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
--		Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST),
        IfNode(function() return GetLeader(self.inst) end, "has leader",            
            FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn )),
    }, 1.5)
    self.bt = BT(self.inst, root)    
end

return SchPikoBrain