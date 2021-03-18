local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local SchCriticalhitBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "SchCriticalhitBadge", owner)
	
	
	self.anim = self.underNumber:AddChild(UIAnim())
	self.anim:GetAnimState():SetBank("boat")
	self.anim:GetAnimState():SetBuild("sch_critical_hit_badge")
	self.anim:SetClickable(true)   
	
	
	self.topperanim = self.underNumber:AddChild(UIAnim())
	self.topperanim:GetAnimState():SetBank("boat")
	self.topperanim:GetAnimState():SetBuild("sch_critical_hit_badge")
	self.topperanim:SetClickable(false) 
	
	
	self.schcriticalhitarrow = self.underNumber:AddChild(UIAnim())
    self.schcriticalhitarrow:GetAnimState():SetBank("sanity_arrow")
    self.schcriticalhitarrow:GetAnimState():SetBuild("sanity_arrow")
    self.schcriticalhitarrow:GetAnimState():PlayAnimation("neutral")
    self.schcriticalhitarrow:SetClickable(false)
	
	self.owner = owner
	owner.schcriticalhitarrow = self.schcriticalhitarrow
    self:StartUpdating()
	self:OpenBadge()
	
	self.OnMouseStartClick = true
end)

local _oldSetPercent = SchCriticalhitBadge.SetPercent

function SchCriticalhitBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
end

function SchCriticalhitBadge:OnUpdate(dt)

	local up = self.owner ~= nil and
        (self.owner:HasTag("")) 
	local anim = up and "arrow_loop_increase" or "neutral"
	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.schcriticalhitarrow:GetAnimState():PlayAnimation(anim, true)
	end

end

function SchCriticalhitBadge:OpenBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("open_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Show() self.schcriticalhitarrow:Show() end)
	self.inst:DoTaskInTime( 0.5, function()	 self.topperanim:GetAnimState():PlayAnimation("open_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		--self:OpenBadge()	
		self.OnMouseStartClick = true
		end)
end

function SchCriticalhitBadge:CloseBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("close_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Hide() self.schcriticalhitarrow:Hide() end)
	self.inst:DoTaskInTime( 0.5, function()	self.topperanim:GetAnimState():PlayAnimation("close_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		self:OpenBadge()	
		--self.OnMouseStartClick = false
		end)
end

function SchCriticalhitBadge:OnMouseButton(button, down, x, y)
if down == true and button == 1000 then
if self.OnMouseStartClick then
	self.OnMouseStartClick = false
	self:CloseBadge()
		end
	end
end

return SchCriticalhitBadge