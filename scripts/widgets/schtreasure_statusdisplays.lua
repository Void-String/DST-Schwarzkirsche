local G = GLOBAL
local require = G.require

local function Schtreasure_statusdisplays(self)
	if self.owner.prefab == "schwarzkirsche" then
		local SchTreasureBadge = require "widgets/schtreasurebadge"
		self.schtreasure = self:AddChild(SchTreasureBadge(self.owner))
		self.owner.schtreasurebadge = self.schtreasure
		self.schtreasure:SetPosition(-956, -500, 0) --- (-46)
		self.schtreasure:SetScale(0.75)
		local function OnSetPlayerMode(self)
			if self.onschtreasuredelta == nil then
				self.onschtreasuredelta = function(owner, data) self:SchTreasureDelta(data) end
				self.inst:ListenForEvent("schtreasuredelta", self.onschtreasuredelta, self.owner)
				if self.owner.components.schtreasure ~= nil then
					self:SetSchTreasurePercent(self.owner.components.schtreasure:GetPercent())
				end
			end
		end
		function self:SetSchTreasurePercent(pct)
			if self.owner.components.schtreasure ~= nil then
				self.schtreasure:SetPercent(pct, self.owner.components.schtreasure.max)
			end		
		end
		function self:SchTreasureDelta(data)
			self:SetSchTreasurePercent(data.newpercent)
		end
		OnSetPlayerMode(self)
	end	
	return self
end
AddClassPostConstruct("widgets/statusdisplays", Schtreasure_statusdisplays)