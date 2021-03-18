require "behaviours/wander"
require "behaviours/faceentity"
require "behaviours/chaseandattack"
require "behaviours/runaway"
require "behaviours/panic"
require "behaviours/follow"
require "behaviours/attackwall"
require "behaviours/doaction"
require "behaviours/chattynode"


local SchTwinBrain = Class(Brain, function(self, inst)
    Brain._ctor(self, inst)
end)

local MIN_FOLLOW_DIST = 0
local TARGET_FOLLOW_DIST = 3
local MAX_FOLLOW_DIST = 6
local GO_HOME_DIST = 0
local START_FACE_DIST =6
local KEEP_FACE_DIST = 8
local KEEP_WORKING_DIST = 15
local SEE_WORK_DIST = 10
local RUN_AWAY_DIST = 5
local STOP_RUN_AWAY_DIST = 10
local MAX_CHASE_DIST = 5
local MAX_CHASE_TIME = 10
local SEE_ITEM_DIST = 10
local ITEM_NEAR_PLAYER_DIST = 3
local DIG_TAGS = { "stump", "grave" }

local function GetLeader(inst)
    return inst.components.follower.leader 
end

local function StartWorking(inst, data)
local radius = 10
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, radius)
	for k,v in pairs(ents) do
		if (v:HasTag("tree") or v:HasTag("boulder") or v:HasTag("stump")) then 
			return true
		end 
	end
end

--[[
local function StartWorkingCondition(inst, actiontags)
    return StartWorking(inst)
end
]]

local function IsNearLeader(inst, dist)
    local leader = GetLeader(inst)
    return leader ~= nil and inst:IsNear(leader, dist)
end


local function HasStateTags(inst, tags)
    for k,v in pairs(tags) do
        if inst.sg:HasStateTag(v) then
            return true
        end
    end
end

local function KeepWorkingAction(inst, actiontags)
    return inst.components.follower.leader and 
		   inst.components.follower.leader:GetDistanceSqToInst(inst) <= KEEP_WORKING_DIST*KEEP_WORKING_DIST and 
		   HasStateTags(inst.components.follower.leader, actiontags)
end

local function StartWorkingCondition(inst, actiontags)
    return inst.components.follower.leader and 
		   HasStateTags(inst.components.follower.leader, actiontags) and not 
		   HasStateTags(inst, actiontags)
end

local function FindObjectToWorkAction(inst, action, addtltags)
local leader = GetLeader(inst)
    if leader ~= nil then
        local target = inst.sg.statemem.target
        if target ~= nil and
            target:IsValid() and
            not (target:IsInLimbo() or
                target:HasTag("NOCLICK") or
                target:HasTag("event_trigger")) and
            target.components.workable ~= nil and
            target.components.workable:CanBeWorked() and
            target.components.workable:GetWorkAction() == action and
            not (target.components.burnable ~= nil
                and (target.components.burnable:IsBurning() or
                    target.components.burnable:IsSmoldering())) and
            target.entity:IsVisible() and
            target:IsNear(leader, KEEP_WORKING_DIST) then
            if addtltags ~= nil then
                for i, v in ipairs(addtltags) do
                    if target:HasTag(v) then
                        return BufferedAction(inst, target, action)
                    end
                end
            else
                return BufferedAction(inst, target, action)
            end
        end
        target = FindEntity(leader, SEE_WORK_DIST, nil, { action.id.."_workable" }, { "fire", "smolder", "event_trigger", "INLIMBO", "NOCLICK" }, addtltags)
        return target ~= nil and BufferedAction(inst, target, action) or nil
    end
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

function SchTwinBrain:OnStart()
    local root = PriorityNode(
    {
        WhileNode(function() return StartWorkingCondition(self.inst, {"chopping", "prechop"}) and 
        KeepWorkingAction(self.inst, {"chopping", "prechop"}) end, "keep chopping",
		DoAction(self.inst, function() return FindObjectToWorkAction(self.inst, ACTIONS.CHOP) end)),

        WhileNode(function() return StartWorkingCondition(self.inst, {"mining", "premine"}) and 
        KeepWorkingAction(self.inst, {"mining", "premine"}) end, "keep mining",                   
		DoAction(self.inst, function() return FindObjectToWorkAction(self.inst, ACTIONS.MINE) end)),
--[[
		WhileNode(function() return self.inst.components.combat.target == nil or not self.inst.components.combat:InCooldown() end, "AttackMomentarily",
		ChaseAndAttack(self.inst, MAX_CHASE_DIST, MAX_CHASE_TIME)),
		
		WhileNode(function() return self.inst.components.combat.target ~= nil and self.inst.components.combat:InCooldown() end, "Dodge",
		RunAway(self.inst, function() return self.inst.components.combat.target end, RUN_AWAY_DIST, STOP_RUN_AWAY_DIST)),
]]
		--Wander(self.inst, function() return self.inst:GetPosition() end, 10),
		
        Follow(self.inst, GetLeader, MIN_FOLLOW_DIST, TARGET_FOLLOW_DIST, MAX_FOLLOW_DIST),
        IfNode(function() return GetLeader(self.inst) end, "has leader",            
            FaceEntity(self.inst, GetFaceTargetFn, KeepFaceTargetFn )),
    }, 1.5)
    
	self.bt = BT(self.inst, root)    
end

return SchTwinBrain