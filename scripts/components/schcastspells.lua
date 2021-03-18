local Schcastspells = Class(function(self, inst)
    self.inst = inst
	self.periodic = nil
	self.myvictim = nil
	self.enabled = true
	self.warning = false
end)

local function NoHoles(pt)
    return not TheWorld.Map:IsPointNearHole(pt)
end

function Schcastspells:Sorcery()
local rads = 18
local x,y,z = self.inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, rads)
			-------------- I modified this --------- from sunnnyyy .... Musha -------
for k,v in pairs(ents) do
if v ~=nil and v.components.health and not v.components.health:IsDead() and 
			   v.entity:IsVisible() and v.components.combat and (v.components.combat.target == self.inst or v:HasTag("monster") or v:HasTag("werepig") or v:HasTag("frog")) and not 
			   v:HasTag("player") and not 
			   v:HasTag("companion") and not 
			   v:HasTag("stalkerminion") and not 
			   v:HasTag("smashable") and not 
			   v:HasTag("alignwall") and not 
			   v:HasTag("shadowminion") then 

	-------- Game FX
	SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
	self.inst.SoundEmitter:PlaySound("dontstarve/rain/thunder_close")

	local fx = SpawnPrefab("tauntfire_fx") 	------- Dragonfly FX
		  fx.Transform:SetScale(0.5, 0.5, 0.5)
		  fx.Transform:SetPosition(v:GetPosition():Get())
			
	local fx2 = SpawnPrefab("tauntfire_fx")    ----- Dragonfly FX
		  fx2.Transform:SetScale(0.5, 0.5, 0.5)
		  fx2.Transform:SetPosition(self.inst:GetPosition():Get())
	
if v.components.locomotor and not v:HasTag("ghost") then
   v.components.locomotor:StopMoving()

			------- Animation
if v:HasTag("spider") and not v:HasTag("spiderqueen") then
   v.sg:GoToState("hit_stunlock")
else
   v.sg:GoToState("hit")
	end
end
		  
v:DoTaskInTime(0.3, function() 
	-------- Add FX
	SpawnPrefab("sch_spin_fx").Transform:SetPosition(v:GetPosition():Get())  
	SpawnPrefab("lightning").Transform:SetPosition(v:GetPosition():Get())
	
	--------- Stack NOT ALLOWED
	if v:HasTag("slowed") then
	   v:RemoveTag("slowed") 
	end

v:DoTaskInTime(0.4, function() 
	local fx_3 = SpawnPrefab("sch_spin_fx") ---- Bearger FX
	      fx_3.Transform:SetScale(0.3, 0.3, 0.3)
		  fx_3.Transform:SetPosition(v:GetPosition():Get())
	end)

	if not v:HasTag("slowed") then
		   v:AddTag("slowed") 
	end
		
	if v.components.combat and not v:HasTag("companion") then
       v.components.combat:SuggestTarget(self.inst)
    end
	
	v:RemoveTag("burn")
		
	if not v:HasTag("lightninggoat") then
	       v.AnimState:SetBloomEffectHandle( "" ) 
    end
	

	if v:HasTag("slowed") then
	
	local shockfx = SpawnPrefab("sch_spin_fx")  ----- Custom FX
	      shockfx.Transform:SetPosition(v:GetPosition():Get())
       if shockfx then

	local follower = shockfx.entity:AddFollower()
		  follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, 0, 0.5 )
	   end	

	if not v.damaged then
		   v.components.health:DoDelta(-30)
		   v.damaged = true
	elseif v.damaged then
		   SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get()) -------- Game FX
		   v.components.health:DoDelta(-70)
		   v.damaged = false
	end

local debuff = SpawnPrefab("collapse_small")
      debuff.Transform:SetPosition(v:GetPosition():Get())
   if debuff and v:HasTag("slowed") then
	
	local follower = debuff.entity:AddFollower()
	
	if not v:HasTag("cavedweller") then
		  follower:FollowSymbol(v.GUID, v.components.combat.hiteffectsymbol, 0, -50, 0.5 )
		  else
		  follower:FollowSymbol(v.GUID, "body", 0, -50, 0.5 )
	end

	TheWorld:DoPeriodicTask(2, function() 
		if v:HasTag("slowed") and v.components.health and not v.components.health:IsDead() and  v.components.locomotor then 
		   --------- WX78 FX
		   SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())
		   v.components.locomotor.groundspeedmultiplier = 0.2
		   v.components.health:DoDelta(-10)
	    end	
	end)
end	
		
	TheWorld:DoTaskInTime(15, function() 
		if v.components.locomotor then 
		   v.components.locomotor.groundspeedmultiplier = 1 
		   v:RemoveTag("slowed") debuff:Remove() 
		   end 
	end)

	elseif not v:HasTag("slowed") then
			   v:AddTag("burn")	
	end

		end)
	end
end
-----------------------------------------------------------------
--self.inst.AnimState:PushAnimation("emoteXL_loop_dance6", false)
self.inst.AnimState:PushAnimation("mime5", false)
--self.inst.AnimState:PushAnimation("mime8", false)
self.inst.components.schwarlock:DoDelta(-15)
end

----------------------------[[ IDK WHY I'M NOT BORED DOING THIS ]]----------------------------
--------------------------------[[ MODDING LIKE MY DAILY JOB ]]-----------------------------
function Schcastspells:Freeze()
local rads = 20
local x,y,z = self.inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, rads)
----------------------------------[[ LAND OF ICE ]]---------------------------------
for k,v in pairs(ents) do 
if v ~=nil and v.components.health and not v.components.health:IsDead() and 
			   v.entity:IsVisible() and v.components.combat and (v.components.combat.target == self.inst or v:HasTag("monster") or v:HasTag("werepig") or v:HasTag("frog")) and not 
			   v:HasTag("player") and not 
			   v:HasTag("companion") and not 
			   v:HasTag("stalkerminion") and not 
			   v:HasTag("smashable") and not 
			   v:HasTag("alignwall") and not 
			   v:HasTag("shadowminion") then 
			
	-------- Game FX
	SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())

v:DoTaskInTime(0.2, function() 
		SpawnPrefab("ice_splash").Transform:SetPosition(v:GetPosition():Get())

	----------- Stack Not Allowed
if not v:HasTag("freezebuffed") then
	   v:RemoveTag("freezebuffed")
end	
	
	end)
v:DoTaskInTime(0.3, function() 
		SpawnPrefab("ice_splash").Transform:SetPosition(v:GetPosition():Get())			
	end)

		if not v.freeze_damaged then
		       v.components.health:DoDelta(-10)
		       v.freeze_damaged = true
	    elseif v.freeze_damaged then
		       SpawnPrefab("explode_small").Transform:SetPosition(v:GetPosition():Get()) -------- Game FX
		       v.components.health:DoDelta(-40)
		       v.freeze_damaged = false
		end

v:DoTaskInTime(0.4, function() 

if not v:HasTag("freezebuffed") then
	   v:AddTag("freezebuffed")
	--   else
	--return	--------- Do Nothing
end
			
	if v.components.combat and not v:HasTag("companion") then
       v.components.combat:SuggestTarget(self.inst)
    end
	
   ------ Remove 
if v:HasTag("slowed") then
   v:RemoveTag("slowed") 
end

	TheWorld:DoPeriodicTask(2, function() 
	
		if v:HasTag("freezebuffed") then
				
			if v.components.freezable then
				local prefabs = "icespike_fx_"..math.random(1,4)
				local freezefx = SpawnPrefab(prefabs)
				local scale = math.random(0.65, 1.05)
						freezefx.Transform:SetScale(scale, scale, scale)
						freezefx.Transform:SetPosition(v:GetPosition():Get())
						
			   v.components.freezable:AddColdness(0.5)
			   v.components.freezable:SpawnShatterFX()
			
			else
				------ FX
				SpawnPrefab("sparks").Transform:SetPosition(v:GetPosition():Get())
				
				--[[ ---- Up Coming
				if then
				end
					]]
			
			end
			
			if v.components.burnable and v.components.burnable:IsBurning() then
			   v.components.burnable:Extinguish()
			end
			
			if v.components.health then
			   v.components.health:DoDelta(-10)
			end

		else
			
			return
			
		end
	end)


	TheWorld:DoTaskInTime(15, function() 
		if v:HasTag("freezebuffed") then
		   v:RemoveTag("freezebuffed")
		end
	end)

end)
		end
	end
-----------------------------------------------------------------
--self.inst.AnimState:PushAnimation("emoteXL_loop_dance6", false)
--self.inst.AnimState:PushAnimation("mime7", false)
self.inst.AnimState:PushAnimation("mime2", false)
self.inst.components.schwarlock:DoDelta(-20)
end

---------------------[[ Oh Syit, i still got problem ]]------------------------
			------------ Keep Stacking -----------
			-------- Up Coming Update : Please Wait! ---------------
		------------------------------------------------------

function Schcastspells:Shadow()
    local theta = math.random() * 2 * PI
    local pt = self.inst:GetPosition()
    local radius = math.random(3, 6)
    local offset = FindWalkableOffset(pt, theta, radius, 12, true, true, NoHoles)
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end
	if not self.inst.components.leader:IsBeingFollowedBy("shadow_sch_timber") then
		self.inst.components.petleash:SpawnPetAt(pt.x, 0, pt.z, "shadow_sch_timber")
		self.inst.AnimState:PushAnimation("mime1", false)
		self.inst.components.schwarlock:DoDelta(-25)
	elseif not self.inst.components.leader:IsBeingFollowedBy("shadow_sch_digger") then
		self.inst.components.petleash:SpawnPetAt(pt.x, 0, pt.z, "shadow_sch_digger")
		self.inst.AnimState:PushAnimation("mime2", false)
		self.inst.components.schwarlock:DoDelta(-25)
	elseif not self.inst.components.leader:IsBeingFollowedBy("shadow_sch_miner") then
		self.inst.components.petleash:SpawnPetAt(pt.x, 0, pt.z, "shadow_sch_miner")
		self.inst.AnimState:PushAnimation("mime3", false)
		self.inst.components.schwarlock:DoDelta(-25)
		--[[
	elseif not self.inst.components.leader:IsBeingFollowedBy("sch_twin") and self.inst.components.inventory:Has("sch_dark_soul", 40) then
		self.inst.components.petleash:SpawnPetAt(pt.x, 0, pt.z, "sch_twin")
		self.inst.AnimState:PushAnimation("emoteXL_loop_dance6", false)
		self.inst.components.inventory:ConsumeByName("sch_dark_soul", 40)
		self.inst.components.talker:Say("Welcome my Twin!", 5, true, nil, true, nil)
		self.inst.components.schwarlock:DoDelta(-225)
		]]--
	else 
		self.inst.AnimState:PushAnimation("emoteXL_facepalm", false)
		self.inst.components.talker:Say("Please be grateful! I've summon all my shadow.", 5, true, nil, true, nil)
	end
end


function Schcastspells:SummonWall()
	self.inst.components.schwarlock:DoDelta(-15)
	self.inst.AnimState:PushAnimation("mime5", false)
	print("Cost (-15)")
end

function Schcastspells:PlayFlute()
local rads = 25
local x,y,z = self.inst.Transform:GetWorldPosition()	
local ents = TheSim:FindEntities(x, y, z, rads)
----------------------------------[[ LAND OF ICE ]]---------------------------------
for k,v in pairs(ents) do 
		if v.components.burnable and (v.components.burnable:IsBurning() or v.components.burnable:IsSmoldering()) and not (v:HasTag("lighter") or v:HasTag("campfire")) then
		   v.components.burnable:Extinguish() v.components.burnable:StopSmoldering()
		end
	end
	self.inst.components.schbloomlevel:DoDelta(-10)
	self.inst.AnimState:PushAnimation("mime5", false)
	print("Reduce Bloom Level : Cost (-10)")
end

function Schcastspells:PlayHorn() ----------- Upcoming Update : Healing
if self.inst.components.temperature:IsFreezing() or self.inst.components.temperature:IsOverheating() then
end
	self.inst.components.schbloomlevel:DoDelta(-60)
	self.inst.AnimState:PushAnimation("mime5", false)
	print("Thirsty : Cost (-60)")
end


function Schcastspells:PlayWhistle()
end


function Schcastspells:PlayBell()
end


function Schcastspells:LittleFriends() ----- Piko : Actually .... stealer
    local theta = math.random() * 2 * PI
    local pt = self.inst:GetPosition()
    local radius = math.random(3, 6)
    local offset = FindWalkableOffset(pt, theta, radius, 12, true, true, NoHoles)
    if offset ~= nil then
        pt.x = pt.x + offset.x
        pt.z = pt.z + offset.z
    end
	if not self.inst.components.leader:IsBeingFollowedBy("sch_piko") then
		self.inst.components.petleash:SpawnPetAt(pt.x, 0, pt.z, "sch_piko")
		self.inst.AnimState:PushAnimation("mime4", false)
		self.inst.components.schwarlock:DoDelta(-30)
	elseif not self.inst.components.leader:IsBeingFollowedBy("sch_piko_farmer") then
		self.inst.components.petleash:SpawnPetAt(pt.x, 0, pt.z, "sch_piko_farmer")
		self.inst.AnimState:PushAnimation("mime5", false)
		self.inst.components.schwarlock:DoDelta(-30)
--[[
	elseif not self.inst.components.leader:IsBeingFollowedBy("sch_piko_attacker") then
		self.inst.components.petleash:SpawnPetAt(pt.x, 0, pt.z, "sch_piko_attacker")
		self.inst.AnimState:PushAnimation("mime6", false)
		self.inst.components.schwarlock:DoDelta(-30)
]]
	else 
		self.inst.AnimState:PushAnimation("emoteXL_facepalm", false)
		self.inst.components.talker:Say("Did you see my little friends here ?", 5, true, nil, true, nil)
	end
end
return Schcastspells