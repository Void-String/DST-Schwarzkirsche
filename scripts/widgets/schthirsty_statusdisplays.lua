local G = GLOBAL
local require = G.require

local function Schthirsty_statusdisplays(self)
	if self.owner.prefab == "schwarzkirsche" then
		local SchThirstyBadge = require "widgets/schthirstybadge"
		self.schthirsty = self:AddChild(SchThirstyBadge(self.owner))
		self.owner.schthirstybadge = self.schthirsty
		self.schthirsty:SetPosition(-1095, -500, 0)
		self.schthirsty:SetScale(0.75)
		local function OnSetPlayerMode(self)
			if self.onschthirstydelta == nil then
				self.onschthirstydelta = function(owner, data) self:SchThirstyDelta(data) end
				self.inst:ListenForEvent("schthirstydelta", self.onschthirstydelta, self.owner)
				if self.owner.components.schthirsty ~= nil then
					self:SetSchThirstyPercent(self.owner.components.schthirsty:GetPercent())
				end
			end
		end
		function self:SetSchThirstyPercent(pct)
			if self.owner.components.schthirsty ~= nil then
				self.schthirsty:SetPercent(pct, self.owner.components.schthirsty.max)
			end
		end
		function self:SchThirstyDelta(data)
			self:SetSchThirstyPercent(data.newpercent)
		end
		OnSetPlayerMode(self)
	end	
	return self
end
AddClassPostConstruct("widgets/statusdisplays", Schthirsty_statusdisplays)