local G = GLOBAL
local require = G.require

local function SchBloomlevel_statusdisplays(self)
	if self.owner.prefab == "schwarzkirsche" then
		local SchBloomlevelBadge = require "widgets/schbloomlevelbadge"
		self.schbloomlevel = self:AddChild(SchBloomlevelBadge(self.owner))
		self.owner.schbloomlevelbadge = self.schbloomlevel
		self.schbloomlevel:SetPosition(-910, -500, 0) --- (-46)
		self.schbloomlevel:SetScale(0.75)
		local function OnSetPlayerMode(self)
			if self.onschbloomleveldelta == nil then
				self.onschbloomleveldelta = function(owner, data) self:SchBloomlevelDelta(data) end
				self.inst:ListenForEvent("schbloomleveldelta", self.onschbloomleveldelta, self.owner)
				if self.owner.components.schbloomlevel ~= nil then
					self:SetSchBloomlevelPercent(self.owner.components.schbloomlevel:GetPercent())
				end
			end
		end
		function self:SetSchBloomlevelPercent(pct)
			if self.owner.components.schbloomlevel ~= nil then
				self.schbloomlevel:SetPercent(pct, self.owner.components.schbloomlevel.max)
			end		
		end
		function self:SchBloomlevelDelta(data)
			self:SetSchBloomlevelPercent(data.newpercent)
		end
		OnSetPlayerMode(self)
	end	
	return self
end
AddClassPostConstruct("widgets/statusdisplays", SchBloomlevel_statusdisplays)