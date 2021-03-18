local SchUseItems = Class(function(self, inst)
    self.inst = inst
	self.useitem = nil
	self.schwarz = nil
	self.canuse = true
	self.isactivated = false
	self.health = TUNING.HEALING_MEDSMALL+2
end)

function SchUseItems:OnActivate(health)
    self.health = health
end

function SchUseItems:Activate(target)
	if self.inst.components.fueled ~= nil then
		if not self.inst.components.fueled:IsEmpty() then
		------------[[ Need Animation ? ]]---------------
		if self.inst:HasTag("LuxuryHealer") then
		   self.inst.AnimState:PlayAnimation("proximity_pre")
		   self.inst.AnimState:PushAnimation("proximity_loop", true)
		end
		------------- [[ Try to Activate then]]---------------
		if self.inst.components.inventoryitem then
		--	self.inst.components.inventoryitem.canbepickedup = true
		end
		------------------[[ Effects and Cost ]]---------------
			if target.components.health ~= nil then
				target.components.health:DoDelta(self.health, false, self.inst.prefab)
					if target.components.sanity ~= nil then
						target.components.sanity:DoDelta(-3)
					end
					if self.inst.components.fueled ~= nil then
						self.inst.components.fueled:DoDelta(-5)
					end
					------- Hunger Drain ?
				return true
			end
		end
	end
end

return SchUseItems