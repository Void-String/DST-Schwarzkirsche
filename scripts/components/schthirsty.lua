local function onmax(self, max)
	self.inst._schthirstymax:set(max)
end

local function oncurrent(self, current)
	self.inst._currentschthirstypercen:set(current/self.max)
end

local function OnTaskTick(inst, self, period)
	self:DoRegen(period)
end

local SchThirsty = Class(function(self, inst)
	self.inst = inst
	self.max = 100
	self.current = 0.05

	local period = 1
	self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
	self.inst:DoPeriodicTask(5, function() self:SchThirstylevels() end)

end,
nil,
{
	max = onmax,
	current = oncurrent
}
)

function SchThirsty:OnSave()
	return {

		max = self.max,
		current = self.current or nil
	}
end

function SchThirsty:OnLoad(data)
	if data ~= nil then
		self.max = data.max
		self.current = data.current
		self:DoDelta(0)
	end
end

function SchThirsty:LongUpdate(dt)
	self:DoRegen(dt)
end

function SchThirsty:GetPercent()
    return self.current / self.max
end

function SchThirsty:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max)
end

function SchThirsty:SetMax(amount)
	self.inst._schthirstymax:set(amount)
    self.max = amount
    self.current = amount
end

function SchThirsty:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and (self.inst.components.health.invincible == true and not self.inst.sg:HasStateTag("tent")) or self.inst.is_teleporting == true then
        return
    end 

    local old = self.current
	local new = math.clamp(self.current + delta, 0, self.max)
	
	self.current = new
	self.inst:PushEvent("schthirstydelta", { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime })
end

function SchThirsty:SetPercent(p, overtime)
    local old = self.current
    self.current  = p * self.max
    self.inst:PushEvent("schthirstydelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })
end

local function SchThirstyIdleRegen(inst)
	return inst.SchThirstyIdleRegen
end

local function SchThirstySleepRegen(inst)
	return inst.SchThirstySleepRegen
end

local function SchThirstyWalkRegen(inst)
	return inst.SchThirstyWalkRegen
end

function SchThirsty:DoRegen(dt)
    local old = self.current
	local regen = 0
if self.current < 101 then 
	if SchThirstyIdleRegen(self.inst) then
		regen = 0.5 -- 2 Sec
	elseif SchThirstySleepRegen(self.inst) then
		regen = 1 -- 1 Sec
	elseif SchThirstyWalkRegen(self.inst) then
		regen = 0.25 -- 4 Sec
	end 
end	
	self:DoDelta((dt * regen), true)
end

function SchThirsty:SchThirstylevels()
if self.current < 20 then
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

return SchThirsty