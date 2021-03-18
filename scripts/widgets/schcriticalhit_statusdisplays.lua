local G = GLOBAL
local require = G.require

local function SchCriticalhit_statusdisplays(self)
	if self.owner.prefab == "schwarzkirsche" then
		local SchCriticalhitBadge = require "widgets/schcriticalhitbadge"
		self.schcriticalhit = self:AddChild(SchCriticalhitBadge(self.owner))
		self.owner.schcriticalhitbadge = self.schcriticalhit
		self.schcriticalhit:SetPosition(-864, -500, 0) --- (-46)
		self.schcriticalhit:SetScale(0.75)
		local function OnSetPlayerMode(self)
			if self.onschcriticalhitdelta == nil then
				self.onschcriticalhitdelta = function(owner, data) self:SchCriticalhitDelta(data) end
				self.inst:ListenForEvent("schcriticalhitdelta", self.onschcriticalhitdelta, self.owner)
				if self.owner.components.schcriticalhit ~= nil then
					self:SetSchCriticalhitPercent(self.owner.components.schcriticalhit:GetPercent())
				end
			end
		end
		function self:SetSchCriticalhitPercent(pct)
			if self.owner.components.schcriticalhit ~= nil then
				self.schcriticalhit:SetPercent(pct, self.owner.components.schcriticalhit.max)
			end		
		end
		function self:SchCriticalhitDelta(data)
			self:SetSchCriticalhitPercent(data.newpercent)
		end
		OnSetPlayerMode(self)
	end	
	return self
end
AddClassPostConstruct("widgets/statusdisplays", SchCriticalhit_statusdisplays)