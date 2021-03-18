local function onmax(self, max)
	self.inst._schcriticalhitmax:set(max)
end

local function oncurrent(self, current)
	self.inst._currentschcriticalhitpercen:set(current/self.max)
end

local function OnTaskTick(inst, self, period)
	self:DoRegen(period)
end

local SchCriticalhit = Class(function(self, inst)
	self.inst = inst
	self.max = 100
	self.current = 0

	local period = 1
	self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
	self.inst:DoPeriodicTask(5, function() self:SchCriticalhitlevels() end)

end,
nil,
{
	max = onmax,
	current = oncurrent
}
)

function SchCriticalhit:OnSave()
	return {

		max = self.max,
		current = self.current or nil
	}
end

function SchCriticalhit:OnLoad(data)
	if data ~= nil then
		self.max = data.max
		self.current = data.current
		self:DoDelta(0)
	end
end

function SchCriticalhit:LongUpdate(dt)
	self:DoRegen(dt)
end

function SchCriticalhit:GetPercent()
    return self.current / self.max
end

function SchCriticalhit:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max)
end

function SchCriticalhit:SetMax(amount)
	self.inst._schcriticalhitmax:set(amount)
    self.max = amount
    self.current = amount
end

function SchCriticalhit:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and (self.inst.components.health.invincible == true and not self.inst.sg:HasStateTag("tent")) or self.inst.is_teleporting == true then
        return
    end 

    local old = self.current
	local new = math.clamp(self.current + delta, 0, self.max)
	
	self.current = new
	self.inst:PushEvent("schcriticalhitdelta", { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime })
end

function SchCriticalhit:SetPercent(p, overtime)
    local old = self.current
    self.current  = p * self.max
    self.inst:PushEvent("schcriticalhitdelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })
end

local function SchCriticalhitStartRegen(inst)
	return inst.SchCriticalRegen
end

function SchCriticalhit:DoRegen(dt)
    local old = self.current
	local regen = 0 
if self.current < 10 then 
	if SchCriticalhitStartRegen(self.inst) then
	--	regen = 0.1 --- 10 sec > +1 ---- Regen by hitting enemy/prey
	end 
end	
	self:DoDelta((dt * regen), true)
end

function SchCriticalhit:GrantShield()
	self.inst.CanGrantShield = true
end

function SchCriticalhit:SchCriticalhitlevels()		
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
return SchCriticalhit