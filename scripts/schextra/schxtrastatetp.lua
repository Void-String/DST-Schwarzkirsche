local require = GLOBAL.require
local ACTIONS = GLOBAL.ACTIONS
local TheInput = GLOBAL.TheInput
local ThePlayer = GLOBAL.ThePlayer
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local IsServer = GLOBAL.TheNet:GetIsServer()

------------- WE FORGET TO ADD SG FOR CLIENT (SERVER WITH CAVE) ----------------

	---------------------------[[ Teleport Action ]]----------------------------
local function CanBlinkToPoint(pt)
    local ground = TheWorld()
    if ground then
        local tile = ground.Map:GetTileAtPoint(pt.x, pt.y, pt.z)
        --print(tile)
        return tile ~= GROUND.IMPASSABLE and tile < GROUND.UNDERGROUND
    end
end

local function CollectPointActions(doer, pos, actions, right)
    return CanBlinkToPoint(pos) and doer.components.inventory:Has("sch_dark_soul",1) and not doer.sg:HasStateTag('schtelpt')
end
local function ActionPickerPostInit(c)
    local old_get = c.DoGetMouseActions
    function c:DoGetMouseActions(...)
        local left,right = old_get(self,...)
        if self.inst:HasTag("schteleporter") then
            return left,right
        end

        local ui = TheInput:GetHUDEntityUnderMouse()
        local pos = TheInput:GetWorldPosition()
        local OnRiding = self.inst.components.rider and self.inst.components.rider:IsRiding()
        if not (OnRiding) or not CollectPointActions(self.inst, pos) then 
            return left,right
        end
        if ui then
            return left,right
        end
        if not right then
            right = BufferedAction(self.inst, nil, ACTIONS.SCHTELEPORT, nil, pos)
        else
            if right and right.action and (right.action.priority < -1 and right.action.id ~= 'LIGHT')then
                right = BufferedAction(self.inst, nil, ACTIONS.SCHTELEPORT, nil, pos)
            end
        end
        return left,right
    end
end
AddComponentPostInit('playeractionpicker',ActionPickerPostInit)

local function DoPortalTint(inst, val)
    if val > 0 then
        inst.components.colouradder:PushColour("portaltint", 40/255 * val, 40/255 * val, 50/255 * val, 0)
        val = 1 - val
        inst.AnimState:SetMultColour(val, val, val, 1)
    else
        inst.components.colouradder:PopColour("portaltint")
        inst.AnimState:SetMultColour(1, 1, 1, 1)
    end
end
local function ToggleOffPhysics(inst)
    inst.sg.statemem.isphysicstoggle = true
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.GROUND)
end
local function ToggleOnPhysics(inst)
    inst.sg.statemem.isphysicstoggle = nil
    inst.Physics:ClearCollisionMask()
    inst.Physics:CollidesWith(COLLISION.WORLD)
    inst.Physics:CollidesWith(COLLISION.OBSTACLES)
    inst.Physics:CollidesWith(COLLISION.SMALLOBSTACLES)
    inst.Physics:CollidesWith(COLLISION.CHARACTERS)
    inst.Physics:CollidesWith(COLLISION.GIANTS)
end

local SCHTELEPORT = GLOBAL.Action({ priority=10, rmb=true, distance=36, mount_valid=true })
SCHTELEPORT.str = "Teleport"
SCHTELEPORT.id = "SCHTELEPORT"
AddAction(SCHTELEPORT)
----------------------- Switch this Code when You Playing on Beta Update / Not
      --[[ Non Beta Update ]] ----- Before Return of them
--[[
SCHTELEPORT.fn = function(act)
    if act.doer and act.doer.sg and act.doer.sg.currentstate.name == "schjumpin_pre" and act.pos
        and act.doer.components.inventory and act.doer.components.inventory:Has("sch_dark_soul", 1) then
        act.doer.components.inventory:ConsumeByName("sch_dark_soul", 1)
        act.doer.sg:GoToState("schjumpin", act.pos)
        return true
    end
end    
]]
	--[[ Beta Update]] ------ Return of them 
SCHTELEPORT.fn = function(act)
	local act_pos = act:GetActionPoint()
	if act.doer ~= nil
        and act.doer.sg ~= nil
        and act.doer.sg.currentstate.name == "schjumpin_pre"
        and act_pos ~= nil
        and act.doer.components.inventory ~= nil
        and act.doer.components.inventory:Has("sch_dark_soul", 1) then
        act.doer.components.inventory:ConsumeByName("sch_dark_soul", 1)
        act.doer.sg:GoToState("schjumpin", act_pos)
        return true
	end
end

AddStategraphActionHandler("wilson", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHTELEPORT, "schjumpin_pre"))
AddStategraphActionHandler("wilson_client", GLOBAL.ActionHandler(GLOBAL.ACTIONS.SCHTELEPORT, "schjumpin_pre"))

AddStategraphState("wilson", GLOBAL.State {
        name = "schjumpin_pre",
        tags = { "busy", "schtelpt" },

        onenter = function(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("wortox_portal_jumpin_pre")
            local buffaction = inst:GetBufferedAction()
            if buffaction ~= nil and buffaction.pos ~= nil then
                inst:ForceFacePoint(buffaction:GetActionPoint():Get()) ----[Use it on Beta Update]]
                --inst:ForceFacePoint(buffaction.pos:Get()) ----[Use it for non Beta Update]]
            end
        end,
        events =
        {
            EventHandler("animover", function(inst)
                if inst.AnimState:AnimDone() and not inst:PerformBufferedAction() then
                    inst.sg:GoToState("idle")
                end
            end),
        },
    } 
)
AddStategraphState("wilson", GLOBAL.State {

        name = "schjumpin",
        tags = {"busy", "pausepredict", "nodangle", "nomorph", "schtelpt"},
        onenter = function(inst, dest)
			inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("sch_portal_jumpin_fx")
            local x, y, z = inst.Transform:GetWorldPosition()
			SpawnPrefab("sch_portal_jumpin_fx").Transform:SetPosition(x, y, z)
            inst.sg:SetTimeout(11 * FRAMES)
            if dest ~= nil then
                inst.sg.statemem.dest = dest
                inst:ForceFacePoint(dest:Get())
            else
                inst.sg.statemem.dest = Vector3(x, y, z)
            end

            if inst.components.playercontroller ~= nil then
                inst.components.playercontroller:RemotePausePrediction()
            end
        end,
		onupdate = function(inst)
            if inst.sg.statemem.tints ~= nil then
                DoPortalTint(inst, table.remove(inst.sg.statemem.tints))
                if #inst.sg.statemem.tints <= 0 then
                    inst.sg.statemem.tints = nil
                end
            end
        end,
		timeline =
        {
            TimeEvent(FRAMES, function(inst)
                inst.SoundEmitter:PlaySound("dontstarve/creatures/together/toad_stool/infection_post", nil, .7)
                inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/spawn", nil, .5)
            end),
            TimeEvent(2 * FRAMES, function(inst)
                inst.sg.statemem.tints = { 1, .6, .3, .1 }
                PlayFootstep(inst)
            end),
            TimeEvent(4 * FRAMES, function(inst)
                inst.sg:AddStateTag("noattack")
                inst.components.health:SetInvincible(true)
                inst.DynamicShadow:Enable(false)
            end),
        },
		
		
        ontimeout = function(inst)
			inst.sg.statemem.portaljumping = true
            inst.sg:GoToState("schjumpout", inst.sg.statemem.dest)
        end,
		
        onexit = function(inst)
            if not inst.sg.statemem.portaljumping then
                inst.components.health:SetInvincible(false)
                inst.DynamicShadow:Enable(true)
                DoPortalTint(inst, 0)
            end
        end,        
    } 
)
AddStategraphState("wilson", GLOBAL.State {
        name = "schjumpout",
        tags = {"evade", "no_stun", "busy", "nopredict", "nomorph", "noattack", "nointerrupt", "schtelpt"},
        onenter = function(inst, dest)
            ToggleOffPhysics(inst)
            inst.components.locomotor:Stop()
            inst.AnimState:PlayAnimation("wortox_portal_jumpout")
            if dest ~= nil then
                inst.Physics:Teleport(dest:Get())
            else
                dest = inst:GetPosition()
            end
			SpawnPrefab("sch_portal_jumpout_fx").Transform:SetPosition(dest:Get())
            inst.DynamicShadow:Enable(false)
            inst.sg:SetTimeout(14 * FRAMES)
            DoPortalTint(inst, 1)
            inst.components.health:SetInvincible(true)
			--inst:PushEvent("soulhop")
        end,
		
		onupdate = function(inst)
            if inst.sg.statemem.tints ~= nil then
                DoPortalTint(inst, table.remove(inst.sg.statemem.tints))
                if #inst.sg.statemem.tints <= 0 then
                    inst.sg.statemem.tints = nil
                end
            end
        end,
		
		timeline =
        {
            TimeEvent(FRAMES, function(inst) inst.SoundEmitter:PlaySound("dontstarve/characters/wortox/soul/hop_out") end),
            TimeEvent(5 * FRAMES, function(inst)
                inst.sg.statemem.tints = { 0, .4, .7, .9 }
            end),
            TimeEvent(7 * FRAMES, function(inst)
                inst.components.health:SetInvincible(false)
                inst.sg:RemoveStateTag("noattack")
                inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
            end),
            TimeEvent(8 * FRAMES, function(inst)
                inst.DynamicShadow:Enable(true)
                ToggleOnPhysics(inst)
            end),
        },
		
		ontimeout = function(inst)
            inst.sg:GoToState("idle", true)
        end,

        onexit = function(inst)
            inst.components.health:SetInvincible(false)
            inst.DynamicShadow:Enable(true)
            DoPortalTint(inst, 0)
        end,

    }
)