require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/panic"
require "behaviours/follow"

local SchPikoBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local MIN_FOLLOW_DIST = 0
local TARGET_FOLLOW_DIST = 3
local MAX_FOLLOW_DIST = 6
local START_FACE_DIST = 6
local KEEP_FACE_DIST = 8
local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 7
local MAX_CHASE_DIST = 10
local MAX_CHASE_TIME = 20
local MAX_WANDER_DIST = 5


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

		WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
		ChaseAndAttack(self.inst, MAX_CHASE_DIST, MAX_CHASE_TIME)),
		
		WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() end, "Dodge",
		RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),

        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
--		Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST),
        
		IfNode(function() return GetLeader(self.inst) end, "has leader",            
		FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn )),
    }, 1.5)
    self.bt = BT(self.inst, root)    
end

return SchPikoBrain