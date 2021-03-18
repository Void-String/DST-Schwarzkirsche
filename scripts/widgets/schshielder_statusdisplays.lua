local G = GLOBAL
local require = G.require

local function Schshielder_statusdisplays(self)
	if self.owner.prefab == "schwarzkirsche" then
		local SchShielderBadge = require "widgets/schshielderbadge"
		self.schshielder = self:AddChild(SchShielderBadge(self.owner))
		self.owner.schshielderbadge = self.schshielder
		self.schshielder:SetPosition(-1049, -500, 0) --- (-46)
		self.schshielder:SetScale(0.75)
		local function OnSetPlayerMode(self)
			if self.onschshielderdelta == nil then
				self.onschshielderdelta = function(owner, data) self:SchShielderDelta(data) end
				self.inst:ListenForEvent("schshielderdelta", self.onschshielderdelta, self.owner)
				if self.owner.components.schshielder ~= nil then
					self:SetSchShielderPercent(self.owner.components.schshielder:GetPercent())
				end
			end
		end
		function self:SetSchShielderPercent(pct)
			if self.owner.components.schshielder ~= nil then
				self.schshielder:SetPercent(pct, self.owner.components.schshielder.max)
			end
		end
		function self:SchShielderDelta(data)
			self:SetSchShielderPercent(data.newpercent)
		end
		OnSetPlayerMode(self)
	end
	return self
end
AddClassPostConstruct("widgets/statusdisplays", Schshielder_statusdisplays)