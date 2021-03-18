local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local SchThirstyBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "SchThirstyBadge", owner)
	
	
	self.anim = self.underNumber:AddChild(UIAnim())
	self.anim:GetAnimState():SetBank("boat")
	self.anim:GetAnimState():SetBuild("sch_thirsty_badge")
	self.anim:SetClickable(true)
	
	
	self.topperanim = self.underNumber:AddChild(UIAnim())
	self.topperanim:GetAnimState():SetBank("boat")
	self.topperanim:GetAnimState():SetBuild("sch_thirsty_badge")
	self.topperanim:SetClickable(false)
	
	
	self.schthirstyarrow = self.underNumber:AddChild(UIAnim())
    self.schthirstyarrow:GetAnimState():SetBank("sanity_arrow")
    self.schthirstyarrow:GetAnimState():SetBuild("sanity_arrow")
    self.schthirstyarrow:GetAnimState():PlayAnimation("neutral")
    self.schthirstyarrow:SetClickable(false)
	
	self.owner = owner
	owner.schthirstyarrow = self.schthirstyarrow
    self:StartUpdating()
	self:OpenBadge()

	self.OnMouseStartClick = true
end)

local _oldSetPercent = SchThirstyBadge.SetPercent

function SchThirstyBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
end

function SchThirstyBadge:OnUpdate(dt)

	local up = self.owner ~= nil and
        (self.owner.SchThirstyIdleRegen or self.owner.SchThirstySleepRegen or self.owner.SchThirstyWalkRegen)  
	local anim = up and "arrow_loop_increase" or "neutral"
	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.schthirstyarrow:GetAnimState():PlayAnimation(anim, true)
	end

end

function SchThirstyBadge:OpenBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("open_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Show() self.schthirstyarrow:Show() end)
	self.inst:DoTaskInTime( 0.5, function()	 self.topperanim:GetAnimState():PlayAnimation("open_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		--self:OpenBadge()	
		self.OnMouseStartClick = true
		end)
end

function SchThirstyBadge:CloseBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("close_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Hide() self.schthirstyarrow:Hide() end)
	self.inst:DoTaskInTime( 0.5, function()	self.topperanim:GetAnimState():PlayAnimation("close_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		self:OpenBadge()	
		--self.OnMouseStartClick = false
		end)
end

function SchThirstyBadge:OnMouseButton(button, down, x, y)
if down == true and button == 1000 then
if self.OnMouseStartClick then
	self.OnMouseStartClick = false
	self:CloseBadge()
		end
	end
end

return SchThirstyBadge