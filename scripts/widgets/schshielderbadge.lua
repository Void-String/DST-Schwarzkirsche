local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local SchShielderBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "SchShielderBadge", owner)
	
	
    self.anim = self.underNumber:AddChild(UIAnim())
	self.anim:GetAnimState():SetBank("boat")
	self.anim:GetAnimState():SetBuild("sch_shield_badge")
	self.anim:SetClickable(true)   
	
	
	self.topperanim = self.underNumber:AddChild(UIAnim())
    self.topperanim:GetAnimState():SetBank("boat")
    self.topperanim:GetAnimState():SetBuild("sch_shield_badge")
    self.topperanim:SetClickable(false) 
	
	
	self.schshielderarrow = self.underNumber:AddChild(UIAnim())
    self.schshielderarrow:GetAnimState():SetBank("sanity_arrow")
    self.schshielderarrow:GetAnimState():SetBuild("sanity_arrow")
    self.schshielderarrow:GetAnimState():PlayAnimation("neutral")
    self.schshielderarrow:SetClickable(false)
	
	self.owner = owner
	owner.schshielderarrow = self.schshielderarrow
	self:StartUpdating()
	self:OpenBadge()

	self.OnMouseStartClick = true
end)

local _oldSetPercent = SchShielderBadge.SetPercent

function SchShielderBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
end

function SchShielderBadge:OnUpdate(dt)

	local up = self.owner ~= nil and
        (self.owner.SchShieldRegen)
	local anim = up and "arrow_loop_increase" or "neutral"
	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.schshielderarrow:GetAnimState():PlayAnimation(anim, true)
	end
	
end

function SchShielderBadge:OpenBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("open_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Show() self.schshielderarrow:Show() end)
	self.inst:DoTaskInTime( 0.5, function()	 self.topperanim:GetAnimState():PlayAnimation("open_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		--self:OpenBadge()	
		self.OnMouseStartClick = true
		end)
end

function SchShielderBadge:CloseBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("close_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Hide() self.schshielderarrow:Hide() end)
	self.inst:DoTaskInTime( 0.5, function()	self.topperanim:GetAnimState():PlayAnimation("close_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		self:OpenBadge()	
		--self.OnMouseStartClick = false
		end)
end

function SchShielderBadge:OnMouseButton(button, down, x, y)
if down == true and button == 1000 then
if self.OnMouseStartClick then
	self.OnMouseStartClick = false
	self:CloseBadge()
		end
	end
end

return SchShielderBadge