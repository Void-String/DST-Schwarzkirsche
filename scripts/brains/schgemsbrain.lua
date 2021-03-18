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

local MIN_FOLLOW_DIST = 1
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
function SchPikoBrain:OnStart()
    local root = PriorityNode(
    {
        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        IfNode(function() return GetLeader(self.inst) end, "has leader",            
            FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn )),
    }, 1.5)
    self.bt = BT(self.inst, root)    
end

return SchPikoBrain