local function SetDirty(netvar, val)
    netvar:set_local(val)
    netvar:set(val)
end

local function OnEntityReplicated(inst)	
    inst._parent = inst.entity:GetParent()
    if inst._parent == nil then
        print("Unable to initialize classified data for [MOD Schwarzkirsche]")
    else
		inst._parent:AttachSchkeyClassified(inst)
    end
end

local function KeyCheckCommon(parent)
	return parent == ThePlayer 
		and TheFrontEnd:GetActiveScreen() ~= nil 
		and TheFrontEnd:GetActiveScreen().name == "HUD"
end

local function RegisterKeyEvent(classified)
	local parent = classified._parent
	
		if parent.HUD == nil then 
			return ---- do nothing
		end
	
	local TestKey1 = _G.SchKeyDownSkill -- or "KEY_O"
	TheInput:AddKeyDownHandler(_G[TestKey1], function()
		if KeyCheckCommon(parent) then
			if TheInput:IsKeyDown(KEY_SHIFT) then
				SendModRPCToServer(MOD_RPC["schwarzkirsche"]["schlungetest"]) 
			else
				SendModRPCToServer(MOD_RPC["schwarzkirsche"]["schruntest"]) 
			end
		end
	end) 

end

local SKILLS = { "schlungetest", "schruntest" }
local SKILLFN = {}
for k, v in pairs(SKILLS) do
	table.insert(SKILLFN, function(parent)
		if parent.components.hunger ~= nil and not parent.components.hunger:IsStarving() then
			parent.components.playercontroller:DoAction(BufferedAction(parent, nil, ACTIONS[v:upper()]))
		else
			parent.components.talker:Say(GetString(parent.prefab, "DESCRIBE_LOW_HUNGER"))
		end
	end)
end

local function RegisterNetListeners(inst)
	if TheWorld.ismastersim then
		inst._parent = inst.entity:GetParent()

		for i = 1, #SKILLS do
			inst:ListenForEvent("on"..SKILLS[i], SKILLFN[i], inst._parent)
		end
	else
		
	end
	RegisterKeyEvent(inst)
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform() -- So we can follow parent's sleep state
	inst.entity:SetPristine()
    inst.entity:AddNetwork()
    inst.entity:Hide()
	
    inst:AddTag("CLASSIFIED")

	inst.schlungetest = net_event(inst.GUID, "onschlungetest")
	inst.schruntest = net_event(inst.GUID, "onschruntest")

	--Delay net listeners until after initial values are deserialized
    inst:DoTaskInTime(0, RegisterNetListeners)

    if not TheWorld.ismastersim then
        inst.OnEntityReplicated = OnEntityReplicated
        return inst
    end

	inst.persists = false

    return inst
end

return Prefab("schwarzkirsche_key_classified", fn)