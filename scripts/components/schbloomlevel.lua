local function onmax(self, max)
	self.inst._schbloomlevelmax:set(max)
end

local function oncurrent(self, current)
	self.inst._currentschbloomlevelpercen:set(current/self.max)
end

local function OnTaskTick(inst, self, period)
	self:DoRegen(period)
end

local SchBloomlevel = Class(function(self, inst)
	self.inst = inst
	self.max = 200
	self.current = 0

	local period = 1
	self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
	self.inst:DoPeriodicTask(5, function() self:SchBloomlevellevels() end)

end,
nil,
{
	max = onmax,
	current = oncurrent
}
)

function SchBloomlevel:OnSave()
	return {

		max = self.max,
		current = self.current or nil
	}
end

function SchBloomlevel:OnLoad(data)
	if data ~= nil then
		self.max = data.max
		self.current = data.current
		self:DoDelta(0)
	end
end

function SchBloomlevel:LongUpdate(dt)
	self:DoRegen(dt)
end

function SchBloomlevel:GetPercent()
    return self.current / self.max
end

function SchBloomlevel:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max)
end

function SchBloomlevel:SetMax(amount)
	self.inst._schbloomlevelmax:set(amount)
    self.max = amount
    self.current = amount
end

function SchBloomlevel:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and (self.inst.components.health.invincible == true and not self.inst.sg:HasStateTag("tent")) or self.inst.is_teleporting == true then
        return
    end 

    local old = self.current
	local new = math.clamp(self.current + delta, 0, self.max)
	
	self.current = new
	self.inst:PushEvent("schbloomleveldelta", { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime })
end

function SchBloomlevel:SetPercent(p, overtime)
    local old = self.current
    self.current  = p * self.max
    self.inst:PushEvent("schbloomleveldelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })
end

local function SchBloomlevelStartRegen(inst)
	return inst.SchBloomRegen
end

function SchBloomlevel:DoRegen(dt)
    local old = self.current
	local regen = 0 
if self.current < 201 then 
	if SchBloomlevelStartRegen(self.inst) then
		regen = 0.1 --- 10 sec > +1
	end 
end	
	self:DoDelta((dt * regen), true)
end

function SchBloomlevel:StartBloom()
	self.inst.IsBloomingState = true
end

function SchBloomlevel:SchBloomlevellevels()		
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
return SchBloomlevel