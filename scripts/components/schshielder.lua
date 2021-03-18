local function onmax(self, max)
	self.inst._schshieldermax:set(max)
end

local function oncurrent(self, current)
	self.inst._currentschshielderpercen:set(current/self.max)
end

local function OnTaskTick(inst, self, period)
	self:DoRegen(period)
end

local SchShielder = Class(function(self, inst)
	self.inst = inst
	self.max = 100 -- Hits
	self.current = 0

	local period = 1
	self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
	self.inst:DoPeriodicTask(10, function() self:SchShielderlevels() end)

end,
nil,
{
	max = onmax,
	current = oncurrent
}
)

function SchShielder:OnSave()
	return {

		max = self.max,
		current = self.current or nil
	}
end

function SchShielder:OnLoad(data)
	if data ~= nil then
		self.max = data.max
		self.current = data.current
		self:DoDelta(0)
	end
end

function SchShielder:LongUpdate(dt)
	self:DoRegen(dt)
end

function SchShielder:GetPercent()
    return self.current / self.max
end

function SchShielder:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max)
end

function SchShielder:SetMax(amount)
	self.inst._schshieldermax:set(amount)
    self.max = amount
    self.current = amount
end

function SchShielder:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and (self.inst.components.health.invincible == true and not self.inst.sg:HasStateTag("tent")) or self.inst.is_teleporting == true then
        return
    end 
    local old = self.current
	local new = math.clamp(self.current + delta, 0, self.max)
	self.current = new
	self.inst:PushEvent("schshielderdelta", { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime })
end

function SchShielder:SetPercent(p, overtime)
    local old = self.current
    self.current  = p * self.max
    self.inst:PushEvent("schshielderdelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })
end

local function SchShielderAllowRegen(inst)
	return inst.SchShieldRegen
end

function SchShielder:DoRegen(dt)
    local old = self.current
	local regen = 0
--if self.current < 100 then 
if SchShielderAllowRegen(self.inst) then
    regen = 1
end 
--end	
	self:DoDelta((dt * regen), true)
end
function SchShielder:SchShielderlevels()
	if self.current < 20 then
	--print("Shield is not fully charged")
			else
		end
	if self.current >= 40 and self.current < 60 then 
			else
		end
	if self.current >= 60 and self.current < 80 then 
		else
	end
	if self.current >= 80 then 
		else
	end
end

return SchShielder