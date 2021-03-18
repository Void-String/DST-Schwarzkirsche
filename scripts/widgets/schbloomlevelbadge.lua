local Badge = require "widgets/badge"
local UIAnim = require "widgets/uianim"

local SchBloomlevelBadge = Class(Badge, function(self, owner)
    Badge._ctor(self, "SchBloomlevelBadge", owner)
	
	
	self.anim = self.underNumber:AddChild(UIAnim())
	self.anim:GetAnimState():SetBank("boat")
	self.anim:GetAnimState():SetBuild("sch_bloom_level_badge")
	self.anim:SetClickable(true)   
	
	
	self.topperanim = self.underNumber:AddChild(UIAnim())
	self.topperanim:GetAnimState():SetBank("boat")
	self.topperanim:GetAnimState():SetBuild("sch_bloom_level_badge")
	self.topperanim:SetClickable(false) 
	
	
	self.schbloomlevelarrow = self.underNumber:AddChild(UIAnim())
    self.schbloomlevelarrow:GetAnimState():SetBank("sanity_arrow")
    self.schbloomlevelarrow:GetAnimState():SetBuild("sanity_arrow")
    self.schbloomlevelarrow:GetAnimState():PlayAnimation("neutral")
    self.schbloomlevelarrow:SetClickable(false)
	
	self.owner = owner
	owner.schbloomlevelarrow = self.schbloomlevelarrow
    self:StartUpdating()
	self:OpenBadge()
	
	self.OnMouseStartClick = true
end)

local _oldSetPercent = SchBloomlevelBadge.SetPercent

function SchBloomlevelBadge:SetPercent(val, max)
    Badge.SetPercent(self, val, max)
end

function SchBloomlevelBadge:OnUpdate(dt)

	local up = self.owner ~= nil and
        (self.owner:HasTag("Schwarzkirsche")) 
	local anim = up and "arrow_loop_increase" or "neutral"
	if self.arrowdir ~= anim then
		self.arrowdir = anim
		self.schbloomlevelarrow:GetAnimState():PlayAnimation(anim, true)
	end

end

function SchBloomlevelBadge:OpenBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("open_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Show() self.schbloomlevelarrow:Show() end)
	self.inst:DoTaskInTime( 0.5, function()	 self.topperanim:GetAnimState():PlayAnimation("open_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		--self:OpenBadge()	
		self.OnMouseStartClick = true
		end)
end

function SchBloomlevelBadge:CloseBadge()
	self.inst:DoTaskInTime( 0.25, function() self.topperanim:GetAnimState():PlayAnimation("close_pre") end)
	self.inst:DoTaskInTime( 0.30, function() self.anim:Hide() self.schbloomlevelarrow:Hide() end)
	self.inst:DoTaskInTime( 0.5, function()	self.topperanim:GetAnimState():PlayAnimation("close_pst") end)
	self.inst:DoTaskInTime( 5, function()	
		self:OpenBadge()	
		--self.OnMouseStartClick = false
		end)
end

function SchBloomlevelBadge:OnMouseButton(button, down, x, y)
if down == true and button == 1000 then
if self.OnMouseStartClick then
	self.OnMouseStartClick = false
	self:CloseBadge()
		end
	end
end

return SchBloomlevelBadge