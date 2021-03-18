local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local SchWarlockBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "SchWarlockBadge", owner)
	
	
	self.anim = self.underNumber:AddChild(UIAnim())
	self.anim:GetAnimState():SetBank("boat")
	self.anim:GetAnimState():SetBuild("sch_magic_badge")
	self.anim:SetClickable(true)   
	
	
	self.topperanim = self.underNumber:AddChild(UIAnim())
	self.topperanim:GetAnimState():SetBank("boat")
	self.topperanim:GetAnimState():SetBuild("sch_magic_badge")
	self.topperanim:SetClickable(false) 
	
	
	self.schwarlockarrow = self.underNumber:AddChild(UIAnim())
    self.schwarlockarrow:GetAnimState():SetBank("sanity_arrow")
    self.schwarlockarrow:GetAnimState():SetBuild("sanity_arrow")
    self.schwarlockarrow:GetAnimState():PlayAnimation("neutral")
    self.schwarlockarrow:SetClickable(false)
	
	self.owner = owner
	owner.schwarlockarrow = self.schwarlockarrow
    self:StartUpdating()
	self:OpenBadge()
	
	self.OnMouseStartClick = true
end)

local _oldSetPercent = SchWarlockBadge.SetPercent

function SchWarlockBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
end

function SchWarlockBadge:OnUpdate(dt)

	local up = self.owner ~= nil and
        (self.owner:HasTag("")) 
	local anim = up and "arrow_loop_increase" or "neutral"
	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.schwarlockarrow:GetAnimState():PlayAnimation(anim, true)
	end

end

function SchWarlockBadge:OpenBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("open_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Show() self.schwarlockarrow:Show() end)
	self.inst:DoTaskInTime( 0.5, function()	 self.topperanim:GetAnimState():PlayAnimation("open_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		--self:OpenBadge()	
		self.OnMouseStartClick = true
		end)
end

function SchWarlockBadge:CloseBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("close_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Hide() self.schwarlockarrow:Hide() end)
	self.inst:DoTaskInTime( 0.5, function()	self.topperanim:GetAnimState():PlayAnimation("close_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		self:OpenBadge()	
		--self.OnMouseStartClick = false
		end)
end

function SchWarlockBadge:OnMouseButton(button, down, x, y)
if down == true and button == 1000 then
if self.OnMouseStartClick then
	self.OnMouseStartClick = false
	self:CloseBadge()
		end
	end
end

return SchWarlockBadge