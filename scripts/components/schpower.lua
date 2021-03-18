--------------------- [[ Adopted from Channelable Components ]] -----------------------------
local function onsetstranger(self)
    if self.stranger ~= nil then
        self.inst:AddTag("controlled")
    else
        self.inst:RemoveTag("controlled")
    end
end

local function onsetenabled(self)
    if self.enabled then
        self.inst:AddTag("controllable")
    else
        self.inst:RemoveTag("controllable")
    end
end


local SchPower = Class(function(self, inst)

    self.inst = inst
	self.myvictim = nil
    self.enabled = true
    self.stranger = nil
    self.OpenTask = nil

end,
nil,
{
    enabled = onsetenabled,
    stranger = onsetstranger,
})

function SchPower:SetEnabled(enabled)
    self.enabled = enabled
end

function SchPower:IsControlling()
    return self.stranger ~= nil
        and self.stranger:IsValid()
        and self.stranger.sg ~= nil
        and self.stranger.sg:HasStateTag("controlling")
end

function SchPower:IsDisturbed()
    return self.stranger ~= nil
        and self.stranger:IsValid()
        and self.stranger.sg ~= nil
        and (self.stranger.sg:HasStateTag("moving") or self.stranger.sg:HasStateTag("idle") or self.stranger.components.health:IsDead())
end

function SchPower:SetControllingFn(startfn, stopfn)
    self.oncontrollingfn = startfn
    self.onstopcontrolling = stopfn
end

function SchPower:StartControlling(stranger, target)
    if self.enabled and
        not self:IsControlling() and
        stranger ~= nil and
        stranger:IsValid() and
        stranger.sg ~= nil and
        stranger.sg:HasStateTag("precontrolling") then

        self.stranger = stranger
        stranger.sg:GoToState("controlling", self.inst)

        if self.oncontrollingfn ~= nil then
            self.oncontrollingfn(self.inst, stranger)
        end

        self.inst:StartUpdatingComponent(self)
		self:Destroy()
		
        return true
    end
end

function SchPower:StopControlling(aborted)
    if self:IsControlling() then
        self.stranger.sg.statemem.stopcontrolling = true
        self.stranger.sg:GoToState("stopcontrolling")
    end
	
    self.stranger = nil
    self.inst:StopUpdatingComponent(self)

    if self.onstopcontrolling ~= nil then
        self.onstopcontrolling(self.inst, aborted)
    end	
	
	
---------------- To make sure -----------------

	if self.OpenTask ~= nil then
	   self.OpenTask:Cancel()
	   self.OpenTask = nil
	end

end

function SchPower:OnUpdate(dt)   
    if not self:IsControlling() then
        self:StopControlling(true)
    end
end

function SchPower:GetDebugString()
    return self:IsControlling() and "Controlling" or "Not Controlling"
end

function SchPower:Destroy(stranger, target)
if not self:IsDisturbed() then
if self:IsControlling() then
	local buffaction = self.stranger:GetBufferedAction()
	local target = buffaction ~= nil and buffaction.target or nil
	if target ~= nil and 
	   target:IsValid() and 
	   target.components.combat and 
	   target.components.health and not 
	   target.components.health:IsDead() then
	   target.components.combat:SuggestTarget(self.stranger)
	   target:AddTag("undercontrolled") target:AddTag("abused")
	if target.components.burnable and target.components.burnable:IsBurning() then
		target.components.burnable:Extinguish()
	end
	if target.components.freezable and target.components.freezable:IsFrozen() then
		target.components.freezable:Unfreeze()
	end
	
	   local fx1 = SpawnPrefab("tauntfire_fx") 
			 fx1.Transform:SetScale(0.5, 0.5, 0.5) 
			 fx1.Transform:SetPosition(target:GetPosition():Get())
self.OpenTask = TheWorld:DoPeriodicTask(1, function()
	if target.components.combat:TargetIs(self.stranger) and target:HasTag("undercontrolled")then
	print("Status : Controlling & Hostile")
	----------------- [[ Need Animation ]] -----------------
	if target:HasTag("spider") and not target:HasTag("spiderqueen") then 
	   target.sg:GoToState("hit_stunlock")
	   SpawnPrefab("sch_sparks_fx_1").Transform:SetPosition(target:GetPosition():Get())
	else
	   target.sg:GoToState("hit")
	   SpawnPrefab("sch_sparks_fx_1").Transform:SetPosition(target:GetPosition():Get())
	end 
	if target.components.health then
		target.components.health:DoDelta(-20)
	end
	----------------------[[ 'COST' ]]-------------------------
	if self.stranger.components.hunger then
		self.stranger.components.hunger:DoDelta(-1)
	end
	if self.stranger.components.schbloomlevel then
		self.stranger.components.schbloomlevel:DoDelta(-1)
	end
	
if target.components.health:IsDead() then
	target:RemoveTag("undercontrolled") 
	self.stranger.sg:GoToState("stopcontrolling")
	print("Target is Death : Stop Controlling")
end

elseif not (target.components.combat:TargetIs(self.stranger) or target.components.health:IsDead()) then
print("Status : Controlling & Enemy stop Targeting") 
	target:RemoveTag("undercontrolled") 
else ---------------- To make sure -----------------
print("Status : Stop Controlling & Control Task Cancelled")
			target:RemoveTag("undercontrolled") 
				if self.OpenTask ~= nil then
					self.OpenTask:Cancel()
					self.OpenTask = nil
				end
			end 
		end) 
	end
		else
			if self.OpenTask ~= nil then
				self.OpenTask:Cancel()
				self.OpenTask = nil
			end
		---------------- To make sure -----------------
print("Status : Stop Controlling & Control Task Cancelled [Repeat]")
			target:RemoveTag("undercontrolled") 
		-------------- Got Problem in the game ---------
			---------- But now .... Safe ------------ 
		end
	end
end

return SchPower