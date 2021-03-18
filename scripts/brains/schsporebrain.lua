require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/panic"
require "behaviours/follow"
require "behaviours/doaction"

local MAX_WANDER_DIST = 15
local MIN_FOLLOW_DIST = 4
local MAX_FOLLOW_DIST = 10
local TARGET_FOLLOW_DIST = 5

local SchSporeBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

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

local function FindObjectToFollow(inst)

	if not inst.followobj or not inst.followobj:IsValid() or inst.followobj:GetPosition():Dist(inst:GetPosition()) > MAX_FOLLOW_DIST + 6 then
        inst.followobj = FindEntity(inst, MAX_FOLLOW_DIST, nil, nil, nil, {"myMaster", "SchFlourishMode"})
	end

	return inst.followobj
end

function SchSporeBrain:OnStart()

	local root =
	PriorityNode(
	{
        Follow(self.inst, FindObjectToFollow, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
		Wander(self.inst, function() return self.inst.components.knownlocations:GetLocation("home") end, MAX_WANDER_DIST,
            { minwalktime = 50,  randwalktime = 3, minwaittime = 1.5, randwaittime = 0.5})
--[[
        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        IfNode(function() return GetLeader(self.inst) end, "has leader",            
            FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn )),]]
			
	}, 1)

	self.bt = BT(self.inst, root)
end

return SchSporeBrain
