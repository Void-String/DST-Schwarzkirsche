local function onmax(self, max)
	self.inst._schtreasuremax:set(max)
end
local function oncurrent(self, current)
	self.inst._currentschtreasurepercen:set(current/self.max)
end
local function OnTaskTick(inst, self, period)
	self:DoRegen(period)
end
local SchTreasure = Class(function(self, inst)
	self.inst = inst
	self.max = 100
	self.current = 70

	local period = 1
	self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)
	self.inst:DoPeriodicTask(5, function() self:SchTreasurelevels() end)

end,
nil,
{
	max = onmax,
	current = oncurrent
}
)

function SchTreasure:OnSave()
	return {

		max = self.max,
		current = self.current or nil
	}
end

function SchTreasure:OnLoad(data)
	if data ~= nil then
		self.max = data.max
		self.current = data.current
		self:DoDelta(0)
	end
end
function SchTreasure:LongUpdate(dt)
	self:DoRegen(dt)
end

function SchTreasure:GetPercent()
    return self.current / self.max
end
function SchTreasure:GetDebugString()
    return string.format("%2.2f / %2.2f", self.current, self.max)
end
function SchTreasure:SetMax(amount)
	self.inst._schtreasuremax:set(amount)
    self.max = amount
    self.current = amount
end
function SchTreasure:DoDelta(delta, overtime, ignore_invincible)
    if not ignore_invincible and (self.inst.components.health.invincible == true and not self.inst.sg:HasStateTag("tent")) or self.inst.is_teleporting == true then
        return
    end 

    local old = self.current
	local new = math.clamp(self.current + delta, 0, self.max)
	
	self.current = new
	self.inst:PushEvent("schtreasuredelta", { oldpercent = old / self.max, newpercent = self.current / self.max, overtime = overtime })
end

function SchTreasure:SetPercent(p, overtime)
    local old = self.current
    self.current  = p * self.max
    self.inst:PushEvent("schtreasuredelta", { oldpercent = old / self.max, newpercent = p, overtime = overtime })
end
local function SchTreasureStartRegen(inst)
	return inst.IsWalkingforTreasure ---- Checked
end
function SchTreasure:DoRegen(dt)
    local old = self.current
	
	local regen = 0 ---- don't don't
	
if self.current < 101 then 
 if SchTreasureStartRegen(self.inst) then
    --regen = 0.05 --- 20 sec > +1
    regen = 0.25 --- 4 sec > +1
 end 
end	
	self:DoDelta((dt * regen), true)
end
function SchTreasure:SchTreasurelevels()		
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
return SchTreasure