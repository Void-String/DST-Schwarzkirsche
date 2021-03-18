local G = GLOBAL
local require = G.require

local function Schwarlock_statusdisplays(self)
	if self.owner.prefab == "schwarzkirsche" then
		local SchWarlockBadge = require "widgets/schwarlockbadge"
		self.schwarlock = self:AddChild(SchWarlockBadge(self.owner))
		self.owner.schwarlockbadge = self.schwarlock
		self.schwarlock:SetPosition(-1003, -500, 0) --- (-46)
		self.schwarlock:SetScale(0.75)
		local function OnSetPlayerMode(self)
			if self.onschwarlockdelta == nil then
				self.onschwarlockdelta = function(owner, data) self:SchWarlockDelta(data) end
				self.inst:ListenForEvent("schwarlockdelta", self.onschwarlockdelta, self.owner)
				if self.owner.components.schwarlock ~= nil then
					self:SetSchWarlockPercent(self.owner.components.schwarlock:GetPercent())
				end
			end
		end
		function self:SetSchWarlockPercent(pct)
			if self.owner.components.schwarlock ~= nil then
				self.schwarlock:SetPercent(pct, self.owner.components.schwarlock.max)
			end		
		end
		function self:SchWarlockDelta(data)
			self:SetSchWarlockPercent(data.newpercent)
		end
		OnSetPlayerMode(self)
	end	
	return self
end
AddClassPostConstruct("widgets/statusdisplays", Schwarlock_statusdisplays)