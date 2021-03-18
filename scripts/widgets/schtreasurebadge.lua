local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local SchTreasureBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "SchTreasureBadge", owner)
	
	
	self.anim = self.underNumber:AddChild(UIAnim())
	self.anim:GetAnimState():SetBank("boat")
	self.anim:GetAnimState():SetBuild("sch_treasure_badge")
	self.anim:SetClickable(true)   
	
	
	self.topperanim = self.underNumber:AddChild(UIAnim())
	self.topperanim:GetAnimState():SetBank("boat")
	self.topperanim:GetAnimState():SetBuild("sch_treasure_badge")
	self.topperanim:SetClickable(false) 
	
	
	self.schtreasurearrow = self.underNumber:AddChild(UIAnim())
    self.schtreasurearrow:GetAnimState():SetBank("sanity_arrow")
    self.schtreasurearrow:GetAnimState():SetBuild("sanity_arrow")
    self.schtreasurearrow:GetAnimState():PlayAnimation("neutral")
    self.schtreasurearrow:SetClickable(false)
	
	self.owner = owner
	owner.schtreasurearrow = self.schtreasurearrow
    self:StartUpdating()
	self:OpenBadge()
	
	self.OnMouseStartClick = true
end)

local _oldSetPercent = SchTreasureBadge.SetPercent

function SchTreasureBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
end

function SchTreasureBadge:OnUpdate(dt)

	local up = self.owner ~= nil and
        (self.owner:HasTag("Schwarzkirsche") and self.owner.IsWalkingforTreasure) 
	local anim = up and "arrow_loop_increase" or "neutral"
	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.schtreasurearrow:GetAnimState():PlayAnimation(anim, true)
	end

end

function SchTreasureBadge:OpenBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("open_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Show() self.schtreasurearrow:Show() end)
	self.inst:DoTaskInTime( 0.5, function()	 self.topperanim:GetAnimState():PlayAnimation("open_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		--self:OpenBadge()	
		self.OnMouseStartClick = true
		end)
end

function SchTreasureBadge:CloseBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("close_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Hide() self.schtreasurearrow:Hide() end)
	self.inst:DoTaskInTime( 0.5, function()	self.topperanim:GetAnimState():PlayAnimation("close_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		self:OpenBadge()	
		--self.OnMouseStartClick = false
		end)
end

function SchTreasureBadge:OnMouseButton(button, down, x, y)
if down == true and button == 1000 then
if self.OnMouseStartClick then
	self.OnMouseStartClick = false
	self:CloseBadge()
		end
	end
end

return SchTreasureBadge