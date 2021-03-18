local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local ACTIONS = GLOBAL.ACTIONS
----------------------------------------------------------------------------
local function DoMountSound(inst, mount, sound)
    if mount ~= nil and mount.sounds ~= nil then
        inst.SoundEmitter:PlaySound(mount.sounds[sound], nil, nil, true)
    end
end

local function DoTalkSound(inst)
    if inst.talksoundoverride ~= nil then
        inst.SoundEmitter:PlaySound(inst.talksoundoverride, "talk")
        return true
    elseif not inst:HasTag("mime") and not inst.keep_check then
        inst.SoundEmitter:PlaySound((inst.talker_path_override or "dontstarve/characters/")..(inst.soundsname or inst.prefab).."/talk_LP", "talk")
        return true
    end
end
-------------------------------------------------------------------------------
local function IsWeaponEquipped(inst, weapon)
    return weapon ~= nil
        and weapon.components.equippable ~= nil
        and weapon.components.equippable:IsEquipped()
        and weapon.components.inventoryitem ~= nil
        and weapon.components.inventoryitem:IsHeldBy(inst)
end

local function ValidateMultiThruster(inst)
    return IsWeaponEquipped(inst, inst.sg.statemem.weapon) and inst.sg.statemem.weapon.components.multithruster ~= nil
end

local function DoThrust(inst, nosound)
    if ValidateMultiThruster(inst) then
        inst.sg.statemem.weapon.components.multithruster:DoThrust(inst, inst.sg.statemem.target)
        if not nosound then
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
        end
    end
end
--------------------------
local function ValidateHelmSplitter(inst)
    return IsWeaponEquipped(inst, inst.sg.statemem.weapon) and inst.sg.statemem.weapon.components.helmsplitter ~= nil
end
local function DoHelmSplit(inst)
    if ValidateHelmSplitter(inst) then
        inst.sg.statemem.weapon.components.helmsplitter:DoHelmSplit(inst, inst.sg.statemem.target)
    end
end
--------------------------
local function DoMultipleAtk(inst, target)
	local buffaction = inst:GetBufferedAction()
	local target = buffaction ~= nil and buffaction.target or nil

	if target ~= nil and target:IsValid() and target:IsNear(inst, 2.5) and not target.components.health:IsDead() then
		inst.sg.statemem.target = target
		inst:ForceFacePoint(target.Transform:GetWorldPosition())
		if target and not target:HasTag("hive") then
		--	target.sg:GoToState("hit")
				else
			return false
		end
		--target.components.health:DoDelta(-10) ---- First experiment until i got new code. you can add this for bonus dmg. (dmg not from deflt.multplyer atk and weaps)
		if target.components.health:IsDead() then
			inst.sg:GoToState("idle")
			inst.components.combat:SetTarget(nil)
		end
		target.components.combat:SuggestTarget(inst)
	
	---------------- New Code 
	local weapon = 	inst.components.combat:GetWeapon()
		--target.components.combat:GetAttacked(inst, 5, weapon) ---- Done to test but Weapon durability not decrease when multiple atk. But default dmg multplayer is ok.
		inst.components.combat:DoAttack(target, weapon) --- Done to test --- dmg weapon/hit is ok, durability weaps is ok.
		
		------------- Adding both of them is not Allowed :p
		if not target:IsValid() then
			-- Target killed
			return
		end
	end
	
	inst.components.locomotor:Stop()
	inst.components.combat:SetTarget(target)
	inst.components.combat:StartAttack()
	
end
-------------------------------------------------------------------------------------
local function OnRemoveCleanupTargetFX(inst)
    if inst.sg.statemem.targetfx.KillFX ~= nil then
        inst.sg.statemem.targetfx:RemoveEventCallback("onremove", OnRemoveCleanupTargetFX, inst)
        inst.sg.statemem.targetfx:KillFX()
    else
        inst.sg.statemem.targetfx:Remove()
    end
end

----------------------------[[ Upcoming Update ]]------------------------------
AddStategraphActionHandler("wilson", ActionHandler(ACTIONS.ATTACK,
        function(inst, action)
            inst.sg.mem.localchainattack = not action.forced or nil
            if not inst.components.health:IsDead() and not inst.sg:HasStateTag("attack") then
                local weapon = inst.components.combat ~= nil and inst.components.combat:GetWeapon() or nil
                return (weapon == nil and "attack")
                    or (weapon:HasTag("blowdart") and "blowdart")
                    or (weapon:HasTag("thrown") and "throw")
					or (weapon:HasTag("staffz") and "mageatk")
					---------- Ijustmodifthisanimfromthegorgeaction ---   (/-'- ")/
					or (weapon:HasTag("multiattack") and "multattack1") ---- pre + Multipe Hit
					or (weapon:HasTag("propsweap") and "prop_attack1") ---- Swing the Weapon
					or (weapon:HasTag("lungeweaps") and "lungeatk1") --- Spin + Hit
					or (weapon:HasTag("splitrweaps") and "splitratck1") ---- pre + Mega Hammer
					or (weapon:HasTag("combter") and "comb1") ---- Spin + Swing + Multhit
					or (weapon:HasTag("combter2") and "comb1a") --- Spin + Hit + 2nd Swing
					or (weapon:HasTag("lungatk1") and "lungatk1a") --- Spin + Multhit -------- Curently USed
					or (weapon:HasTag("hammerweaps") and "hamrs") --- Hammering
                    or "attack"
            end
        end)
 )

AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS.ATTACK,
        function(inst)
            if not (inst.replica.health:IsDead() or inst.sg:HasStateTag("attack")) then
                local equip = inst.replica.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                if equip == nil then
                    return "attack"
                end
                local inventoryitem = equip.replica.inventoryitem
                return (not (inventoryitem ~= nil and inventoryitem:IsWeapon()) and "attack")
                    or (equip:HasTag("blowdart") and "blowdart")
                    or (equip:HasTag("thrown") and "throw")
					or (equip:HasTag("staffz") and "mageatk")
					or (equip:HasTag("multiattack") and "multattack1")
					or (equip:HasTag("propsweap") and "prop_attack1")
					or (equip:HasTag("lungeweaps") and "lungeatk1")
					or (equip:HasTag("splitrweaps") and "splitratck1")
					or (equip:HasTag("combter") and "comb1")
					or (equip:HasTag("combter2") and "comb1a")
					or (equip:HasTag("lungatk1") and "lungatk1a")
					or (weapon:HasTag("hammerweaps") and "hamrs")
                    or "attack"
            end
        end)
)
-----------------------------------------------------------------------------------
local mage_attack = GLOBAL.State{
		name = "mageatk",
        tags = {"attack", "notalking", "abouttoattack", "autopredict", "doing", "busy"},
            onenter = function(inst)
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            local staff = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
            local colour = staff ~= nil and staff.fxcolour or { 1, 1, 1 }
			
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
            inst.components.locomotor:Stop()
			
			if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
            inst.AnimState:PlayAnimation("staff_pre")
            inst.AnimState:PushAnimation("staff", false)


            inst.sg.statemem.stafffx = SpawnPrefab(inst.components.rider:IsRiding() and "staffcastfx_mount" or "staffcastfx")
            inst.sg.statemem.stafffx.entity:SetParent(inst.entity)
            inst.sg.statemem.stafffx.Transform:SetRotation(inst.Transform:GetRotation())
            inst.sg.statemem.stafffx:SetUp(colour)

            inst.sg.statemem.stafflight = SpawnPrefab("staff_castinglight")
            inst.sg.statemem.stafflight.Transform:SetPosition(inst.Transform:GetWorldPosition())
            inst.sg.statemem.stafflight:SetUp(colour, 1.9, .33)

            if staff ~= nil and staff.components.aoetargeting ~= nil and staff.components.aoetargeting.targetprefab ~= nil then
                local buffaction = inst:GetBufferedAction()
                if buffaction ~= nil and buffaction.pos ~= nil then
                    inst.sg.statemem.targetfx = SpawnPrefab(staff.components.aoetargeting.targetprefab)
                    if inst.sg.statemem.targetfx ~= nil then
                        inst.sg.statemem.targetfx.Transform:SetPosition(buffaction.pos:Get())
                        inst.sg.statemem.targetfx:ListenForEvent("onremove", OnRemoveCleanupTargetFX, inst)
                    end
                end
            end

            inst.sg.statemem.castsound = staff ~= nil and staff.castsound or "dontstarve/wilson/use_gemstaff"
        end,
		
        onupdate = function(inst, dt)
			--inst:PerformBufferedAction()
			
        end,
		
        timeline =
        {
            TimeEvent(13 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound(inst.sg.statemem.castsound)
            end),
            TimeEvent(53 * FRAMES, function(inst)
                if inst.sg.statemem.targetfx ~= nil then
                    if inst.sg.statemem.targetfx:IsValid() then
                        OnRemoveCleanupTargetFX(inst)
                    end
                    inst.sg.statemem.targetfx = nil
                end
                inst.sg.statemem.stafffx = nil
                inst.sg.statemem.stafflight = nil 
                inst:PerformBufferedAction()
				inst.sg:RemoveStateTag("abouttoattack")
            end),
        },
        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle")
        end,
        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(true)
            end
            if inst.sg.statemem.stafffx ~= nil and inst.sg.statemem.stafffx:IsValid() then
                inst.sg.statemem.stafffx:Remove()
            end
            if inst.sg.statemem.stafflight ~= nil and inst.sg.statemem.stafflight:IsValid() then
                inst.sg.statemem.stafflight:Remove()
            end
            if inst.sg.statemem.targetfx ~= nil and inst.sg.statemem.targetfx:IsValid() then
                OnRemoveCleanupTargetFX(inst)
            end
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
        end,
    	
   }
AddStategraphState("wilson", mage_attack)
-------------------------------------------------------------------------------
local multi_trust_1 = GLOBAL.State{
        name = "multattack1",
        tags = { "thrusting", "doing", "busy", "nointerrupt", "nomorph", "pausepredict" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("multithrust_yell")

            if inst.bufferedaction ~= nil and inst.bufferedaction.target ~= nil and inst.bufferedaction.target:IsValid() then
                inst.sg.statemem.target = inst.bufferedaction.target
                inst.components.combat:SetTarget(inst.sg.statemem.target)
                inst:ForceFacePoint(inst.sg.statemem.target.Transform:GetWorldPosition())
            end

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg.statemem.thrusting = true
                    inst.sg:GoToState("multattack2", inst.sg.statemem.target)
                end
            end),
        },

        onexit = function(inst)
            if not inst.sg.statemem.thrusting then
                inst.components.combat:SetTarget(nil)
            end
        end,
}
AddStategraphState("wilson", multi_trust_1)

local multi_trust_2 = GLOBAL.State{
        name = "multattack2",
        tags = { "attack", "busy", "nointerrupt", "abouttoattack", "pausepredict" },

        onenter = function(inst, target)
            inst.AnimState:PlayAnimation("multithrust")
            inst.Transform:SetEightFaced()
			
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            
			if target ~= nil and target:IsValid() then
                inst.sg.statemem.target = target
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
			
            inst.components.locomotor:Stop()
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
			inst.sg:SetTimeout(30 * FRAMES)

        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            end),
            TimeEvent(9 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            end),
            TimeEvent(11 * FRAMES, function(inst)
                inst.sg.statemem.weapon = inst.components.combat:GetWeapon()
                inst:PerformBufferedAction()
                DoThrust(inst)			
            end),
            TimeEvent(13 * FRAMES,function(inst)
			DoThrust(inst) end),
			
            TimeEvent(15 * FRAMES,function(inst)
			DoThrust(inst) end),
			
            TimeEvent(17 * FRAMES, function(inst)
                DoThrust(inst, true)
            end),
            TimeEvent(19 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("nointerrupt")
                DoThrust(inst, true)
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle", true)
        end,

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
            inst.Transform:SetFourFaced()
        end,
}
AddStategraphState("wilson", multi_trust_2)
-------------------------------------------------------------------------------
local prop_attack_1 = GLOBAL.State{
        name = "prop_attack1",
        tags = { "propattack", "doing", "busy", "notalking" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("atk_prop_pre")

            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            if target ~= nil and target:IsValid() then
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
			
        end,

        events =
        {
            EventHandler("unequip", function(inst)
                inst.sg:GoToState("idle")
            end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("prop_attack2")
                end
            end),
        },
}
AddStategraphState("wilson", prop_attack_1)

local prop_attack_2 = GLOBAL.State{
        name = "prop_attack2",
        tags = { "attack", "doing", "busy", "notalking", "pausepredict" },

        onenter = function(inst, target)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("atk_prop")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
            
			local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            if target ~= nil and target:IsValid() then
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
			inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
			
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
        end,

        timeline =
        {
            TimeEvent(FRAMES, function(inst)
                inst:PerformBufferedAction()
                local dist = .8
                local radius = 1.7
                inst.components.combat.ignorehitrange = true
                local x0, y0, z0 = inst.Transform:GetWorldPosition()
                local angle = (inst.Transform:GetRotation() + 90) * DEGREES
                local sinangle = math.sin(angle)
                local cosangle = math.cos(angle)
                local x = x0 + dist * sinangle
                local z = z0 + dist * cosangle
                for i, v in ipairs(TheSim:FindEntities(x, y0, z, radius + 3, { "_combat" }, { "flying", "shadow", "ghost", "FX", "NOCLICK", "DECOR", "INLIMBO", "playerghost" })) do
                    if v:IsValid() and not v:IsInLimbo() and
                        not (v.components.health ~= nil and v.components.health:IsDead()) then
                        local range = radius + v:GetPhysicsRadius(.5)
                        if v:GetDistanceSqToPoint(x, y0, z) < range * range and inst.components.combat:CanTarget(v) then
                            --dummy redirected so that players don't get red blood flash
                            v:PushEvent("attacked", { attacker = inst, damage = 0, redirected = v })
                            v:PushEvent("knockback", { knocker = inst, radius = radius + dist, propsmashed = true })
                            inst.sg.statemem.smashed = true
                        end
                    end
                end
                inst.components.combat.ignorehitrange = false
                if inst.sg.statemem.smashed then
                    local prop = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                    if prop ~= nil then
                        dist = dist + radius - .5
                        inst.sg.statemem.smashed = { prop = prop, pos = Vector3(x0 + dist * sinangle, y0, z0 + dist * cosangle) }
                    else
                        inst.sg.statemem.smashed = nil
                    end
                end
            end),
            TimeEvent(2 * FRAMES, function(inst)
                if inst.sg.statemem.smashed ~= nil then
                    local smashed = inst.sg.statemem.smashed
                    inst.sg.statemem.smashed = false
                    smashed.prop:PushEvent("propsmashed", smashed.pos)
                end
            end),
            TimeEvent(13 * FRAMES, function(inst)
                inst.sg:GoToState("idle", true)
            end),
        },

        events =
        {
            EventHandler("unequip", function(inst)
                if inst.sg.statemem.smashed == nil then
                    inst.sg:GoToState("idle")
                end
            end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.smashed then --could be false, so don't nil check
                inst.sg.statemem.smashed.prop:PushEvent("propsmashed", inst.sg.statemem.smashed.pos)
            end
        end,
}
AddStategraphState("wilson", prop_attack_2)
----------------------------------------------------------------------------------
local lunge_attack_1 = GLOBAL.State{
        name = "lungeatk1",
        tags = { "aoe", "doing", "busy", "nointerrupt", "nomorph" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("lunge_pre")
        end,
        onupdate = function(inst)
			if inst.AnimState:AnimDone() then
				if inst.AnimState:IsCurrentAnimation("lunge_pre") then
					inst.AnimState:PlayAnimation("lunge_lag")
					inst:PerformBufferedAction()
				end
			end
        end,
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/twirl", nil, nil, true)
            end),
        },

        events =
        {
            EventHandler("animover", function(inst, data)
                inst.sg:GoToState("lungeatk2", data)
            end),
        },
}
AddStategraphState("wilson", lunge_attack_1)

local lunge_attack_2 = GLOBAL.State{
        name = "lungeatk2",
        tags = { "attack", "doing", "busy", "nopredict", "aoe" },

        onenter = function(inst, target)
		if inst.AnimState:IsCurrentAnimation("lunge_lag") then
			inst.AnimState:PlayAnimation("lunge_pst")
			inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
		end
	
		local buffaction = inst:GetBufferedAction()
		local target = buffaction ~= nil and buffaction.target or nil
			if target ~= nil and target:IsValid() then
				inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
		inst.components.combat:SetTarget(target)
		inst.components.combat:StartAttack()

        end,

        onupdate = function(inst)
 
        end,

        timeline =
        {
            TimeEvent(12 * FRAMES, function(inst)
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)

        end,

}
AddStategraphState("wilson", lunge_attack_2)

---------------------------------------------------------------------
local splitr_attack_1 = GLOBAL.State{
        name = "splitratck1",
        tags = { "doing", "busy", "nointerrupt", "nomorph", "pausepredict" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("atk_leap_pre")

            if inst.bufferedaction ~= nil and inst.bufferedaction.target ~= nil and inst.bufferedaction.target:IsValid() then
                inst.sg.statemem.target = inst.bufferedaction.target
                inst.components.combat:SetTarget(inst.sg.statemem.target)
                inst:ForceFacePoint(inst.sg.statemem.target.Transform:GetWorldPosition())
            end

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end

            inst.sg:SetTimeout(8 * FRAMES)
        end,

        ontimeout = function(inst)
            inst.sg.statemem.helmsplitting = true
            inst.sg:GoToState("splitratck2", inst.sg.statemem.target)
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg.statemem.helmsplitting = true
                    inst.sg:GoToState("splitratck2", inst.sg.statemem.target)
                end
            end),
        },

        onexit = function(inst)
            if not inst.sg.statemem.helmsplitting then
                inst.components.combat:SetTarget(nil)
            end
        end,
}
AddStategraphState("wilson", splitr_attack_1)


local splitr_attack_2 = GLOBAL.State{
        name = "splitratck2",
        tags = { "attack", "doing", "busy", "nointerrupt", "nomorph", "pausepredict" },

        onenter = function(inst, target)
            inst.components.locomotor:Stop()
            inst.Transform:SetEightFaced()
            inst.AnimState:PlayAnimation("atk_leap")
            inst.SoundEmitter:PlaySound("dontstarve/common/deathpoof")

            if target ~= nil and target:IsValid() then
                inst.sg.statemem.target = target
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
			
		inst.components.combat:SetTarget(target)
		inst.components.combat:StartAttack()
		
            inst.sg:SetTimeout(30 * FRAMES)
        end,

        timeline =
        {
            TimeEvent(10 * FRAMES, function(inst)
                inst.components.colouradder:PushColour("helmsplitter", .1, .1, 0, 0)
            end),
            TimeEvent(11 * FRAMES, function(inst)
                inst.components.colouradder:PushColour("helmsplitter", .2, .2, 0, 0)
            end),
            TimeEvent(12 * FRAMES, function(inst)
                inst.components.colouradder:PushColour("helmsplitter", .4, .4, 0, 0)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
            end),
            TimeEvent(13 * FRAMES, function(inst)
                inst.components.bloomer:PushBloom("helmsplitter", "shaders/anim.ksh", -2)
                inst.components.colouradder:PushColour("helmsplitter", 1, 1, 0, 0)
                inst.sg:RemoveStateTag("nointerrupt")
                ShakeAllCameras(CAMERASHAKE.VERTICAL, .5, .015, .5, inst, 20)
                inst.sg.statemem.weapon = inst.components.combat:GetWeapon()
                inst:PerformBufferedAction()
                DoHelmSplit(inst)
            end),
            TimeEvent(14 * FRAMES, function(inst)
                inst.components.colouradder:PushColour("helmsplitter", .8, .8, 0, 0)
            end),
            TimeEvent(15 * FRAMES, function(inst)
                inst.components.colouradder:PushColour("helmsplitter", .6, .6, 0, 0)
            end),
            TimeEvent(16 * FRAMES, function(inst)
                inst.components.colouradder:PushColour("helmsplitter", .4, .4, 0, 0)
            end),
            TimeEvent(17 * FRAMES, function(inst)
                inst.components.colouradder:PushColour("helmsplitter", .2, .2, 0, 0)
            end),
            TimeEvent(18 * FRAMES, function(inst)
                inst.components.colouradder:PopColour("helmsplitter")
            end),
            TimeEvent(19 * FRAMES, function(inst)
                inst.components.bloomer:PopBloom("helmsplitter")
            end),
        },

        ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            inst.Transform:SetFourFaced()
            inst.components.bloomer:PopBloom("helmsplitter")
            inst.components.colouradder:PopColour("helmsplitter")
            if ValidateHelmSplitter(inst) then
                inst.sg.statemem.weapon.components.helmsplitter:StopHelmSplitting(inst)
            end
        end,
}
AddStategraphState("wilson", splitr_attack_2)
-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local combatk1 = GLOBAL.State{
        name = "comb1",
        tags = { "aoe", "doing", "busy", "nointerrupt", "nomorph" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("lunge_pre")
        end,
        onupdate = function(inst)
			if inst.AnimState:AnimDone() then
				if inst.AnimState:IsCurrentAnimation("lunge_pre") then
					inst.AnimState:PlayAnimation("lunge_lag")
					inst:PerformBufferedAction()
				end
			end
        end,
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/twirl", nil, nil, true)
            end),
        },

        events =
        {
            EventHandler("animover", function(inst, data)
                inst.sg:GoToState("comb2", data)
            end),
        },
	
}
AddStategraphState("wilson", combatk1)

local combatk2 = GLOBAL.State{
        name = "comb2",
        tags = { "attack", "doing", "busy", "nopredict", "aoe" },

        onenter = function(inst, target)
		if inst.AnimState:IsCurrentAnimation("lunge_lag") then
			inst.AnimState:PlayAnimation("lunge_pst")
			inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
		end
	
		local buffaction = inst:GetBufferedAction()
		local target = buffaction ~= nil and buffaction.target or nil
			if target ~= nil and target:IsValid() then
				inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
		inst.components.combat:SetTarget(target)
		inst.components.combat:StartAttack()

        end,

        onupdate = function(inst)
 
        end,

        timeline =
        {
            TimeEvent(12 * FRAMES, function(inst)
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("comb3")
                end
            end),
        },

        onexit = function(inst)

        end,
}
AddStategraphState("wilson", combatk2)


local combatk3 = GLOBAL.State{
        name = "comb3",
        tags = { "attack", "busy", "nointerrupt", "abouttoattack", "pausepredict" },

        onenter = function(inst, target)
            inst.AnimState:PlayAnimation("multithrust")
            inst.Transform:SetEightFaced()

            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            
			if target ~= nil and target:IsValid() then
                inst.sg.statemem.target = target
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end

			inst.sg:SetTimeout(30 * FRAMES)

        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            end),
            TimeEvent(9 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            end),
            TimeEvent(11 * FRAMES, function(inst)
                inst.sg.statemem.weapon = inst.components.combat:GetWeapon()
                inst:PerformBufferedAction()
                DoThrust(inst)	DoMultipleAtk(inst)
            end),
            TimeEvent(13 * FRAMES,function(inst)
			DoThrust(inst) DoMultipleAtk(inst) end),
			
            TimeEvent(15 * FRAMES,function(inst)
			DoThrust(inst) DoMultipleAtk(inst) end),
			
            TimeEvent(17 * FRAMES, function(inst)
                DoThrust(inst, true) DoMultipleAtk(inst)
            end),
            TimeEvent(19 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("nointerrupt")
                DoThrust(inst, true) DoMultipleAtk(inst)
	            inst.sg:AddStateTag("abouttoattack")
            end),
        },

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle", true)
        end,

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
            inst.Transform:SetFourFaced()
        end,
}
AddStategraphState("wilson", combatk3)



-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local combatk1a = GLOBAL.State{
        name = "comb1a",
        tags = { "aoe", "doing", "busy", "nointerrupt", "nomorph" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("lunge_pre")
        end,
        onupdate = function(inst)
			if inst.AnimState:AnimDone() then
				if inst.AnimState:IsCurrentAnimation("lunge_pre") then
					inst.AnimState:PlayAnimation("lunge_lag")
					inst:PerformBufferedAction()
				end
			end
        end,
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/twirl", nil, nil, true)
            end),
        },

        events =
        {
            EventHandler("animover", function(inst, data)
                inst.sg:GoToState("comb2a", data)
            end),
        },
}
AddStategraphState("wilson", combatk1a)
local combatk2a = GLOBAL.State{
        name = "comb2a",
        tags = { "attack", "doing", "busy", "nopredict", "aoe" },

        onenter = function(inst, target)
		if inst.AnimState:IsCurrentAnimation("lunge_lag") then
			inst.AnimState:PlayAnimation("lunge_pst")
			inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
		end
	
		local buffaction = inst:GetBufferedAction()
		local target = buffaction ~= nil and buffaction.target or nil
			if target ~= nil and target:IsValid() then
				inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
		inst.components.combat:SetTarget(target)
		inst.components.combat:StartAttack()

        end,

        onupdate = function(inst)
 
        end,

        timeline =
        {
            TimeEvent(12 * FRAMES, function(inst)
            end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("comb3a")
                end
            end),
        },

        onexit = function(inst)

        end,
}
AddStategraphState("wilson", combatk2a)
local combatk3a = GLOBAL.State{
        name = "comb3a",
        tags = { "propattack", "doing", "busy", "notalking" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("atk_prop_pre")

            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            if target ~= nil and target:IsValid() then
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
			
        end,

        events =
        {
            EventHandler("unequip", function(inst)
                inst.sg:GoToState("idle")
            end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("comb4a")
                end
            end),
        },

}
AddStategraphState("wilson", combatk3a)

local combatk4a = GLOBAL.State{
name = "comb4a",
        tags = { "attack", "doing", "busy", "notalking", "pausepredict" },

        onenter = function(inst, target)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("atk_prop")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_whoosh")
            DoMultipleAtk(inst)
			local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            if target ~= nil and target:IsValid() then
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
			inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
			
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
        end,

        timeline =
        {
            TimeEvent(FRAMES, function(inst)
                inst:PerformBufferedAction()
                local dist = .8
                local radius = 1.7
                inst.components.combat.ignorehitrange = true
                local x0, y0, z0 = inst.Transform:GetWorldPosition()
                local angle = (inst.Transform:GetRotation() + 90) * DEGREES
                local sinangle = math.sin(angle)
                local cosangle = math.cos(angle)
                local x = x0 + dist * sinangle
                local z = z0 + dist * cosangle
                for i, v in ipairs(TheSim:FindEntities(x, y0, z, radius + 3, { "_combat" }, { "flying", "shadow", "ghost", "FX", "NOCLICK", "DECOR", "INLIMBO", "playerghost" })) do
                    if v:IsValid() and not v:IsInLimbo() and
                        not (v.components.health ~= nil and v.components.health:IsDead()) then
                        local range = radius + v:GetPhysicsRadius(.5)
                        if v:GetDistanceSqToPoint(x, y0, z) < range * range and inst.components.combat:CanTarget(v) then
                            --dummy redirected so that players don't get red blood flash
                            v:PushEvent("attacked", { attacker = inst, damage = 0, redirected = v })
                            v:PushEvent("knockback", { knocker = inst, radius = radius + dist, propsmashed = true })
                            inst.sg.statemem.smashed = true
                        end
                    end
                end
                inst.components.combat.ignorehitrange = false
                if inst.sg.statemem.smashed then
                    local prop = inst.components.inventory:GetEquippedItem(EQUIPSLOTS.HANDS)
                    if prop ~= nil then
                        dist = dist + radius - .5
                        inst.sg.statemem.smashed = { prop = prop, pos = Vector3(x0 + dist * sinangle, y0, z0 + dist * cosangle) }
                    else
                        inst.sg.statemem.smashed = nil
                    end
                end
            end),
            TimeEvent(2 * FRAMES, function(inst)
                if inst.sg.statemem.smashed ~= nil then
                    local smashed = inst.sg.statemem.smashed
                    inst.sg.statemem.smashed = false
                    smashed.prop:PushEvent("propsmashed", smashed.pos)
                end
            end),
            TimeEvent(13 * FRAMES, function(inst)
                inst.sg:GoToState("idle", true)
            end),
        },

        events =
        {
            EventHandler("unequip", function(inst)
                if inst.sg.statemem.smashed == nil then
                    inst.sg:GoToState("idle")
                end
            end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.smashed then --could be false, so don't nil check
                inst.sg.statemem.smashed.prop:PushEvent("propsmashed", inst.sg.statemem.smashed.pos)
            end
        end,
}
AddStategraphState("wilson", combatk4a)

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
local lungatk1 = GLOBAL.State{
        name = "lungatk1a",
        tags = { "aoe", "doing", "busy", "nointerrupt", "nomorph" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("lunge_pre")

        end,
        onupdate = function(inst)
			if inst.AnimState:AnimDone() then
				if inst.AnimState:IsCurrentAnimation("lunge_pre") then
					inst.AnimState:PlayAnimation("lunge_lag")
					inst:PerformBufferedAction()
				end
			end
        end,
        timeline =
        {
            TimeEvent(4 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/twirl", nil, nil, true)
            end),
        },

        events =
        {
            EventHandler("animover", function(inst, data)
                inst.sg:GoToState("lungatk2a", data)
            end),
        },
}
AddStategraphState("wilson", lungatk1)
local lungatk2 = GLOBAL.State{
        name = "lungatk2a",
        tags = { "attack", "busy", "nointerrupt", "abouttoattack", "pausepredict" },

        onenter = function(inst, target)
		
		if inst.AnimState:IsCurrentAnimation("lunge_lag") then
				inst.AnimState:PlayAnimation("multithrust")
			inst:PerformBufferedAction()
		end
		
            inst.Transform:SetEightFaced()
			
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            
			if target ~= nil and target:IsValid() then
                inst.sg.statemem.target = target
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
			
            inst.components.locomotor:Stop()
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
 
			inst.sg:SetTimeout(30 * FRAMES)

        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            end),
            TimeEvent(9 * FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/wilson/attack_weapon")
            end),
            TimeEvent(11 * FRAMES, function(inst)
                inst.sg.statemem.weapon = inst.components.combat:GetWeapon()
                inst:PerformBufferedAction()
                DoThrust(inst)	DoMultipleAtk(inst)
            end),
            TimeEvent(13 * FRAMES,function(inst)
			DoThrust(inst) DoMultipleAtk(inst) end),
			
            TimeEvent(15 * FRAMES,function(inst)
			DoThrust(inst) DoMultipleAtk(inst) end),
			
            TimeEvent(17 * FRAMES, function(inst)
                DoThrust(inst, true) DoMultipleAtk(inst)
            end),
            TimeEvent(19 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("nointerrupt")
                DoThrust(inst, true) DoMultipleAtk(inst)
	            inst.sg:AddStateTag("abouttoattack")
            end),
        },
        ontimeout = function(inst)
            inst.sg:RemoveStateTag("attack")
            inst.sg:AddStateTag("idle", true)
        end,

        events =
        {
            EventHandler("equip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animqueueover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },

        onexit = function(inst)
            inst.components.combat:SetTarget(nil)
            if inst.sg:HasStateTag("abouttoattack") then
                inst.components.combat:CancelAttack()
            end
            inst.Transform:SetFourFaced()
        end,
}
AddStategraphState("wilson", lungatk2)

-----------------------------------------------------------------------------------------
local hamr_start = GLOBAL.State 
{
        name = "hamrs",
        tags = { "attack", "busy", "nointerrupt" },

        onenter = function(inst, target)
            inst.AnimState:PlayAnimation("pickaxe_loop")
            local buffaction = inst:GetBufferedAction()
            local target = buffaction ~= nil and buffaction.target or nil
            
			if target ~= nil and target:IsValid() then
                inst.sg.statemem.target = target
                inst:ForceFacePoint(target.Transform:GetWorldPosition())
            end
            inst.components.locomotor:Stop()
            inst.components.combat:SetTarget(target)
            inst.components.combat:StartAttack()
			
        end,

        timeline =
        {
            TimeEvent(7 * FRAMES, function(inst)
                inst:PerformBufferedAction()
                inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")
            end),

            TimeEvent(9 * FRAMES, function(inst)
                inst.sg:RemoveStateTag("prehammer")
            end),

            TimeEvent(14 * FRAMES, function(inst)

            end),
        },

        events =
        {
            EventHandler("unequip", function(inst) inst.sg:GoToState("idle") end),
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.AnimState:PlayAnimation("pickaxe_pst")
                    inst.sg:GoToState("idle", true)
                end
            end),
        },
}
AddStategraphState("wilson", hamr_start)

-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
	----------------------------[[ END EXPERIMENT ]]------------------------------
-----------------------------------------------------------------------------------------

	----------------------------[[ EXTRA STATES PART 2 [ BLOCKING ]]]------------------------------

local SCH_STATE_1 = GLOBAL.State 
{
        name = "block_idle",
        tags = { "notalking", "blocking", "nomorph" },

        onenter = function(inst, data)
            inst.components.locomotor:Stop()

            if data ~= nil and data.duration ~= nil then
                if data.duration > 0 then
                    inst.sg.statemem.task = inst:DoTaskInTime(data.duration, function(inst)
                        inst.sg.statemem.task = nil
                        inst.AnimState:PlayAnimation("parry_pst")
                        inst.sg:GoToState("idle", true)
                    end)
                else
                    inst.AnimState:PlayAnimation("parry_pst")
                    inst.sg:GoToState("idle", true)
                    return
                end
            end

            if not inst.AnimState:IsCurrentAnimation("parry_loop") then
                inst.AnimState:PushAnimation("parry_loop", true)
            end

            inst.sg.statemem.talktask = data ~= nil and data.talktask or nil

            if data ~= nil and (data.pauseframes or 0) > 0 then
                inst.sg:AddStateTag("busy")
                inst.sg:AddStateTag("pausepredict")

                if inst.components.playercontroller ~= nil then
                    inst.components.playercontroller:RemotePausePrediction(data.pauseframes <= 7 and data.pauseframes or nil)
                end
                inst.sg:SetTimeout(data.pauseframes * FRAMES)
            else
                inst.sg:AddStateTag("idle")
            end
        end,

        ontimeout = function(inst)
            inst.sg:RemoveStateTag("busy")
            inst.sg:RemoveStateTag("pausepredict")
            inst.sg:AddStateTag("idle")
        end,

        events =
        {
            EventHandler("ontalk", function(inst)
                if inst.sg.statemem.talktask ~= nil then
                    inst.sg.statemem.talktask:Cancel()
                    inst.sg.statemem.talktask = nil
                    --StopTalkSound(inst, true)
                end
           --     if DoTalkSound(inst) then
             --       inst.sg.statemem.talktask =
             --           inst:DoTaskInTime(1.5 + math.random() * .5,
             --               function()
               --                 inst.sg.statemem.talktask = nil
                                --StopTalkSound(inst)
               --             end)
            --    end
            end),
            EventHandler("donetalking", function(inst)
                if inst.sg.statemem.talktalk ~= nil then
                    inst.sg.statemem.talktask:Cancel()
                    inst.sg.statemem.talktask = nil
                    --StopTalkSound(inst)
                end
            end),
            EventHandler("unequip", function(inst, data)
                if not inst.sg:HasStateTag("idle") then
                    -- We need to handle this because the default unequip
                    -- handler is ignored while we are in a "busy" state.
                    inst.sg:GoToState(GetUnequipState(inst, data))
                end
            end),
        },

        onexit = function(inst)
            if inst.sg.statemem.task ~= nil then
                inst.sg.statemem.task:Cancel()
                inst.sg.statemem.task = nil
            end
            if inst.sg.statemem.talktask ~= nil then
                inst.sg.statemem.talktask:Cancel()
                inst.sg.statemem.talktask = nil
                --StopTalkSound(inst)
            end
            if not inst.sg.statemem.blocking then
                inst.components.combat.redirectdamagefn = nil
            end
        end,
}

AddStategraphState("wilson", SCH_STATE_1)
AddStategraphState("wilson_client", SCH_STATE_1)

local SCH_STATE_2 = GLOBAL.State 
{
        name = "block_knockback",
        tags = { "blocking", "parryhit", "busy", "nopredict", "nomorph" },

        onenter = function(inst, data)
            inst.components.locomotor:Stop()
            inst:ClearBufferedAction()

            inst.AnimState:PlayAnimation("parryblock")
            inst.SoundEmitter:PlaySound("dontstarve/wilson/hit")

            if data ~= nil then
                if data.timeleft ~= nil then
                    inst.sg.statemem.timeleft0 = GetTime()
                    inst.sg.statemem.timeleft = data.timeleft
                end
                data = data.knockbackdata
                if data ~= nil and data.radius ~= nil and data.knocker ~= nil and data.knocker:IsValid() then
                    local x, y, z = data.knocker.Transform:GetWorldPosition()
                    local distsq = inst:GetDistanceSqToPoint(x, y, z)
                    local rangesq = data.radius * data.radius
                    local rot = inst.Transform:GetRotation()
                    local rot1 = distsq > 0 and inst:GetAngleToPoint(x, y, z) or data.knocker.Transform:GetRotation() + 180
                    local drot = math.abs(rot - rot1)
                    while drot > 180 do
                        drot = math.abs(drot - 360)
                    end
                    local k = distsq < rangesq and .3 * distsq / rangesq - 1 or -.7
                    inst.sg.statemem.speed = (data.strengthmult or 1) * 12 * k
                    if drot > 90 then
                        inst.sg.statemem.reverse = true
                        inst.Transform:SetRotation(rot1 + 180)
                        inst.Physics:SetMotorVel(-inst.sg.statemem.speed, 0, 0)
                    else
                        inst.Transform:SetRotation(rot1)
                        inst.Physics:SetMotorVel(inst.sg.statemem.speed, 0, 0)
                    end
                end
            end

            inst.sg:SetTimeout(6 * FRAMES)
        end,

        onupdate = function(inst)
            if inst.sg.statemem.speed ~= nil then
                inst.sg.statemem.speed = .75 * inst.sg.statemem.speed
                inst.Physics:SetMotorVel(inst.sg.statemem.reverse and -inst.sg.statemem.speed or inst.sg.statemem.speed, 0, 0)
            end
        end,

        events =
        {
            EventHandler("unequip", function(inst, data)
                -- We need to handle this because the default unequip
                -- handler is ignored while we are in a "busy" state.
                inst.sg.statemem.unequipped = true
            end),
        },

        ontimeout = function(inst)
            if inst.sg.statemem.unequipped then
                inst.sg:GoToState("idle")
            else
                inst.sg.statemem.blocking = true
                inst.sg:GoToState("block_idle", inst.sg.statemem.timeleft ~= nil and { duration = math.max(0, inst.sg.statemem.timeleft + inst.sg.statemem.timeleft0 - GetTime()) } or nil)
            end
        end,

        onexit = function(inst)
            if inst.sg.statemem.speed ~= nil then
                inst.Physics:Stop()
            end
            if not inst.sg.statemem.blocking then
                inst.components.combat.redirectdamagefn = nil
            end
        end,
}

AddStategraphState("wilson", SCH_STATE_2)
AddStategraphState("wilson_client", SCH_STATE_2)

	----------------------------[[ EXTRA STATES PART 2 [ AWAKENING ]]]------------------------------
------------ Got some bug after awken
local ult_awaken_state_1 = GLOBAL.State 
{
        name = "start_tranform_ultimate_awakening",
       -- tags = { "busy", "nopredict", "nomorph", "nointerrupt" },
        tags = { "busy" },

        onenter = function(inst)
            inst.components.locomotor:StopMoving()
			inst:AddTag("notarget")
            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:Enable(false)
            end
            inst.components.health:SetInvincible(true)
            inst.AnimState:PlayAnimation("teleport")
            inst:ShowHUD(false)
            inst:SetCameraDistance(20)

		local piko2nd = inst:CanMorph()
		if not (piko2nd) then
			inst.sg:GoToState("idle")
                return
            end
		
        end,

        timeline =
        {
            TimeEvent(0, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_pulled")
            end),
            TimeEvent(82*FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/common/teleportato/teleportato_under")
				SpawnPrefab("sch_fire_ring").Transform:SetPosition(inst:GetPosition():Get()) 
            end),
            TimeEvent(85*FRAMES, function(inst)
            end),
        },

        onexit = function(inst)

        end,
		events =
        {
            EventHandler("animover", function(inst, data)
                inst.sg:GoToState("wakeup_ultimate_awakening", data)
            end),
        },
}

AddStategraphState("wilson", ult_awaken_state_1)
AddStategraphState("wilson_client", ult_awaken_state_1)

local ult_awaken_state_2 = GLOBAL.State 
{
        name = "wakeup_ultimate_awakening",
       -- tags = { "busy", "waking", "nomorph", "nodangle", "nointerrupt" },
        tags = { "busy" },

        onenter = function(inst)
			inst:MorphPiko()
			inst:RemoveTag("notarget")
            if not inst:IsHUDVisible() then
                inst.sg.statemem.wakeawakening = true
--                inst.sg:AddStateTag("nopredict")
  --              inst.sg:AddStateTag("silentmorph")
    --            inst.sg:RemoveStateTag("nomorph")
                inst.components.health:SetInvincible(false)
                inst:ShowHUD(false)
                inst:SetCameraDistance(18)
            end
		inst.AnimState:PlayAnimation("wakeup")
		if inst.components.playercontroller ~= nil then
			inst.components.playercontroller:Enable(false)
		end
		
		local fx2 = SpawnPrefab("chester_transform_fx")
		local fx3 = SpawnPrefab("collapse_small")
		local pos = inst:GetPosition()
				fx2.Transform:SetPosition(pos:Get())
				fx3.Transform:SetPosition(pos:Get())
				
        end,

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
        timeline =
        {
            TimeEvent(20*FRAMES, function(inst)
            end),
        },
        onexit = function(inst)
            if inst.sg.statemem.wakeawakening then
                inst:ShowHUD(true)
                inst:SetCameraDistance()
            end
			if inst.components.playercontroller ~= nil then
				inst.components.playercontroller:Enable(true)
			end
        end,
}

AddStategraphState("wilson", ult_awaken_state_2)
AddStategraphState("wilson_client", ult_awaken_state_2)

-------------------------------------------------------------------------------------------

local summon_spike = GLOBAL.State 
{
        name = "summon_spikes",
        tags = { "attack", "busy" },

        onenter = function(inst, target)
		
            inst.AnimState:PlayAnimation("staff_pre")
            inst.AnimState:PushAnimation("staff", false)

            if target ~= nil and target:IsValid() then
                inst.sg.statemem.target = target
                inst.sg.statemem.targetpos = target:GetPosition()
                inst.sg.statemem.targetpos.y = 0
            end
        end,

        onupdate = function(inst)
            if inst.sg.statemem.target ~= nil then
                if not inst.sg.statemem.target:IsValid() then
                    inst.sg.statemem.target = nil
                else
                    local x, y, z = inst.sg.statemem.target.Transform:GetWorldPosition()
                    local distsq = inst:GetDistanceSqToPoint(x, y, z)
                    if distsq < TUNING.ANTLION_CAST_MAX_RANGE * TUNING.ANTLION_CAST_MAX_RANGE then
                        inst.sg.statemem.targetpos.x, inst.sg.statemem.targetpos.z = x, z
                    elseif distsq >= TUNING.ANTLION_DEAGGRO_DIST * TUNING.ANTLION_DEAGGRO_DIST then
                        inst.sg.statemem.target = nil
                    end
                end
            end
        end,

        timeline =
        {
            TimeEvent(3 * FRAMES, function(inst)
                if inst.sg.statemem.targetpos ~= nil then
                    inst.sg.statemem.target = nil
                    SpawnSpikes(inst, inst.sg.statemem.targetpos, math.random(6, 7))
                end
            end),
            TimeEvent(8 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/together/antlion/cast_pre") end),
            TimeEvent(25.5 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/together/antlion/cast_post") end),
            TimeEvent(29 * FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/creatures/together/antlion/sfx/ground_break") end),
        },

        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
}

AddStategraphState("wilson", summon_spike)
AddStategraphState("wilson_client", summon_spike)

--[[


local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)

local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
local sand_block = GLOBAL.State 
{

}

AddStategraphState("wilson", sand_block)
AddStategraphState("wilson_client", sand_block)
]]