local MakePlayerCharacter = require "prefabs/player_common"

local assets = {
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
	Asset( "ANIM", "anim/player_basic.zip" ),
    Asset( "ANIM", "anim/player_idles_shiver.zip" ),
    Asset( "ANIM", "anim/player_actions.zip" ),
    Asset( "ANIM", "anim/player_actions_axe.zip" ),
    Asset( "ANIM", "anim/player_actions_pickaxe.zip" ),
    Asset( "ANIM", "anim/player_actions_shovel.zip" ),
    Asset( "ANIM", "anim/player_actions_blowdart.zip" ),
    Asset( "ANIM", "anim/player_actions_eat.zip" ),
    Asset( "ANIM", "anim/player_actions_item.zip" ),
    Asset( "ANIM", "anim/player_actions_uniqueitem.zip" ),
    Asset( "ANIM", "anim/player_actions_bugnet.zip" ),
    Asset( "ANIM", "anim/player_actions_fishing.zip" ),
    Asset( "ANIM", "anim/player_actions_boomerang.zip" ),
    Asset( "ANIM", "anim/player_bush_hat.zip" ),
    Asset( "ANIM", "anim/player_attacks.zip" ),
    Asset( "ANIM", "anim/player_idles.zip" ),
    Asset( "ANIM", "anim/player_rebirth.zip" ),
    Asset( "ANIM", "anim/player_jump.zip" ),
    Asset( "ANIM", "anim/player_amulet_resurrect.zip" ),
    Asset( "ANIM", "anim/player_teleport.zip" ),
    Asset( "ANIM", "anim/wilson_fx.zip" ),
    Asset( "ANIM", "anim/player_one_man_band.zip" ),
    Asset( "ANIM", "anim/shadow_hands.zip" ),
    Asset( "SOUND","sound/sfx.fsb" ),
    Asset( "SOUND","sound/wilson.fsb" ),
    Asset( "ANIM", "anim/beard.zip" ),
---------------------------[[ Build Skins ]]----------------------------
	Asset( "ANIM", "anim/schwarzkirsche.zip" ),
	Asset( "ANIM", "anim/schwarzkirsche_black.zip" ),
	Asset( "ANIM", "anim/schwarzkirsche_blue.zip" ),
	Asset( "ANIM", "anim/schwarzkirsche_red.zip" ),
	Asset( "ANIM", "anim/schwarzkirsche_aquatic.zip" ),
	Asset( "ANIM", "anim/schwarzkirsche_green.zip" ),
	Asset( "ANIM", "anim/schwarzkirsche_purple.zip" ),
	Asset( "ANIM", "anim/schwarzkirsche_sun.zip" ),
	Asset( "ANIM", "anim/schwarzkirsche_original.zip" ),
---------------------------[[ Skins 2nd ]]----------------------------
	Asset( "ANIM", "anim/schwarzkirsche_2nd.zip" ), 
	Asset( "ANIM", "anim/schwarzkirsche_black_2nd.zip" ), 
	Asset( "ANIM", "anim/schwarzkirsche_blue_2nd.zip" ), 
	Asset( "ANIM", "anim/schwarzkirsche_red_2nd.zip" ),  
	Asset( "ANIM", "anim/schwarzkirsche_aquatic_2nd.zip" ), 
	Asset( "ANIM", "anim/schwarzkirsche_green_2nd.zip" ), 
	Asset( "ANIM", "anim/schwarzkirsche_purple_2nd.zip" ), 
	Asset( "ANIM", "anim/schwarzkirsche_sun_2nd.zip" ), 
	Asset( "ANIM", "anim/schwarzkirsche_original_2nd.zip" ),
---------------------------[[ Adds New Action ]]----------------------------
	Asset("ANIM", "anim/player_actions_roll.zip"),
}

---------------------------[[ Item List ]]----------------------------
local prefabs = { 
--[[ Next Update"schwarzkirsche_key_classified", ]]
"sch_arcanist_stone", 
"sch_dark_soul",
"sch_dark_soul_fx",
"sch_dark_soul_in",
"sch_dark_soul_spawn",
"sch_portal",
"sch_treasure",
"sch_spin_fx",
"sch_darkshield_fx",
"sch_stalker_shield",
"sch_shadowsch",
"sch_piko",
"sch_teatree_nut_piko",
"sch_golden_teatree_nut",
"sch_twin",
"sch_scythe",
"sch_elec_charged_fx",
"sch_explode_fx",
"sch_fire_ring",
"sch_hit_sparks_fx",
"sch_sparks_fx_1",
"sch_sparks_fx_2",
"sch_shadowtentacle",
"sch_stalker_shield_rage",
"sch_hat",
"sch_dress_1",
"sch_dress_2",
"sch_hat_crown",
"sch_blade_1",
"sch_blade_2",
"sch_shot_projectile_fx",
"sch_compass",
"sch_dress_3",
"sch_gems",
"sch_redlantern",
"sch_ice_staff",
"sch_hammer",
"sch_hat_crown_1",
"sch_battle_staff",
"sch_spore",
"sch_stalker_shield_mod",
"sch_dead_gems",
"sch_sandfx",
"sch_markfx",
}


---------------------------[[ Starting Inventory ]]----------------------------
local start_inv = { 
	"sch_compass",
}

---------------------------[[ Sound ]]----------------------------
local schsound = 
{

	slide = "dontstarve_DLC003/characters/wheeler/slide",

}

---------------------------[[ ApplyUpgrades ]]----------------------------
local function ApplyExpLevel(inst, data)

	local max_exp = 30375
	local schwarzkirsche_level = math.min(inst.schwarzkirsche_level, max_exp)

	local health_percent = inst.components.health:GetPercent()
	local sanity_percent = inst.components.sanity:GetPercent()
	local shield_percent = inst.components.schshielder:GetPercent()

if inst.schwarzkirsche_level <= 30375 then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(inst.schwarzkirsche_level).."]")
end
			if inst.schwarzkirsche_level >= 0 and inst.schwarzkirsche_level < 375 then
	inst.components.health.maxhealth = math.ceil (100)
	inst.components.sanity.max = math.ceil (100)	
				inst.components.schshielder.max = math.ceil (10)	
			elseif inst.schwarzkirsche_level >= 375 and inst.schwarzkirsche_level < 750 then
	inst.components.health.maxhealth = math.ceil (105)
	inst.components.sanity.max = math.ceil (100)	
				inst.components.schshielder.max = math.ceil (10)	
			elseif inst.schwarzkirsche_level >= 750 and inst.schwarzkirsche_level < 1125 then
	inst.components.health.maxhealth = math.ceil (105)
	inst.components.sanity.max = math.ceil (105)	
				inst.components.schshielder.max = math.ceil (10)	
			elseif inst.schwarzkirsche_level >= 1125 and inst.schwarzkirsche_level < 1500 then
	inst.components.health.maxhealth = math.ceil (105)
	inst.components.sanity.max = math.ceil (105)	
				inst.components.schshielder.max = math.ceil (10)	
			elseif inst.schwarzkirsche_level >= 1500 and inst.schwarzkirsche_level < 1875 then
	inst.components.health.maxhealth = math.ceil (110)
	inst.components.sanity.max = math.ceil (110)	
				inst.components.schshielder.max = math.ceil (10)	
			elseif inst.schwarzkirsche_level >= 1875 and inst.schwarzkirsche_level < 2250 then
	inst.components.health.maxhealth = math.ceil (110)
	inst.components.sanity.max = math.ceil (110)	
				inst.components.schshielder.max = math.ceil (10)	
			elseif inst.schwarzkirsche_level >= 2250 and inst.schwarzkirsche_level < 2625 then
	inst.components.health.maxhealth = math.ceil (110)
	inst.components.sanity.max = math.ceil (115)
				inst.components.schshielder.max = math.ceil (10)	
			elseif inst.schwarzkirsche_level >= 2625 and inst.schwarzkirsche_level < 3000 then
	inst.components.health.maxhealth = math.ceil (115)
	inst.components.sanity.max = math.ceil (115)
				inst.components.schshielder.max = math.ceil (10)	
			elseif inst.schwarzkirsche_level >= 3000 and inst.schwarzkirsche_level < 3375 then
	inst.components.health.maxhealth = math.ceil (115)
	inst.components.sanity.max = math.ceil (120)
				inst.components.schshielder.max = math.ceil (10)	
			elseif inst.schwarzkirsche_level >= 3375 and inst.schwarzkirsche_level < 3750 then
	inst.components.health.maxhealth = math.ceil (115)
	inst.components.sanity.max = math.ceil (120)
				inst.components.schshielder.max = math.ceil (10)	
			elseif inst.schwarzkirsche_level >= 3750 and inst.schwarzkirsche_level < 4125 then
	inst.components.health.maxhealth = math.ceil (120)
	inst.components.sanity.max = math.ceil (125)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 4125 and inst.schwarzkirsche_level < 4500 then
	inst.components.health.maxhealth = math.ceil (120)
	inst.components.sanity.max = math.ceil (125)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 4500 and inst.schwarzkirsche_level < 4875 then
	inst.components.health.maxhealth = math.ceil (120)
	inst.components.sanity.max = math.ceil (130)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 4875 and inst.schwarzkirsche_level < 5250 then
	inst.components.health.maxhealth = math.ceil (125)
	inst.components.sanity.max = math.ceil (130)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 5250 and inst.schwarzkirsche_level < 5625 then
	inst.components.health.maxhealth = math.ceil (125)
	inst.components.sanity.max = math.ceil (135)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 5625 and inst.schwarzkirsche_level < 6000 then
	inst.components.health.maxhealth = math.ceil (125)
	inst.components.sanity.max = math.ceil (135)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 6000 and inst.schwarzkirsche_level < 6375 then
	inst.components.health.maxhealth = math.ceil (130)
	inst.components.sanity.max = math.ceil (140)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 6375 and inst.schwarzkirsche_level < 6750 then
	inst.components.health.maxhealth = math.ceil (130)
	inst.components.sanity.max = math.ceil (140)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 6750 and inst.schwarzkirsche_level < 7125 then
	inst.components.health.maxhealth = math.ceil (130)
	inst.components.sanity.max = math.ceil (145)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 7125 and inst.schwarzkirsche_level < 7500 then
	inst.components.health.maxhealth = math.ceil (135)
	inst.components.sanity.max = math.ceil (145)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 7500 and inst.schwarzkirsche_level < 7875 then
	inst.components.health.maxhealth = math.ceil (135)
	inst.components.sanity.max = math.ceil (150)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 7875 and inst.schwarzkirsche_level < 8250 then
	inst.components.health.maxhealth = math.ceil (135)
	inst.components.sanity.max = math.ceil (150)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 8250 and inst.schwarzkirsche_level < 8625 then
	inst.components.health.maxhealth = math.ceil (140)
	inst.components.sanity.max = math.ceil (155)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 8625 and inst.schwarzkirsche_level < 9000 then
	inst.components.health.maxhealth = math.ceil (140)
	inst.components.sanity.max = math.ceil (155)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 9000 and inst.schwarzkirsche_level < 9375 then
	inst.components.health.maxhealth = math.ceil (140)
	inst.components.sanity.max = math.ceil (160)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 9375 and inst.schwarzkirsche_level < 9750 then
	inst.components.health.maxhealth = math.ceil (145)
	inst.components.sanity.max = math.ceil (160)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 9750 and inst.schwarzkirsche_level < 10125 then
	inst.components.health.maxhealth = math.ceil (145)
	inst.components.sanity.max = math.ceil (165)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 10125 and inst.schwarzkirsche_level < 10500 then
	inst.components.health.maxhealth = math.ceil (145)
	inst.components.sanity.max = math.ceil (165)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 10500 and inst.schwarzkirsche_level < 10875 then
	inst.components.health.maxhealth = math.ceil (150)
	inst.components.sanity.max = math.ceil (170)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 10875 and inst.schwarzkirsche_level < 11250 then
	inst.components.health.maxhealth = math.ceil (150)
	inst.components.sanity.max = math.ceil (170)
				inst.components.schshielder.max = math.ceil (30)	
			elseif inst.schwarzkirsche_level >= 11250 and inst.schwarzkirsche_level < 11625 then
	inst.components.health.maxhealth = math.ceil (150)
	inst.components.sanity.max = math.ceil (175)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 11625 and inst.schwarzkirsche_level < 12000 then
	inst.components.health.maxhealth = math.ceil (155)
	inst.components.sanity.max = math.ceil (175)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 12000 and inst.schwarzkirsche_level < 12375 then
	inst.components.health.maxhealth = math.ceil (155)
	inst.components.sanity.max = math.ceil (180)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 12375 and inst.schwarzkirsche_level < 12750 then
	inst.components.health.maxhealth = math.ceil (155)
	inst.components.sanity.max = math.ceil (180)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 12750 and inst.schwarzkirsche_level < 13125 then
	inst.components.health.maxhealth = math.ceil (160)
	inst.components.sanity.max = math.ceil (185)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 13125 and inst.schwarzkirsche_level < 13500 then
	inst.components.health.maxhealth = math.ceil (160)
	inst.components.sanity.max = math.ceil (185)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 13500 and inst.schwarzkirsche_level < 13875 then
	inst.components.health.maxhealth = math.ceil (160)
	inst.components.sanity.max = math.ceil (190)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 13875 and inst.schwarzkirsche_level < 14250 then
	inst.components.health.maxhealth = math.ceil (165)
	inst.components.sanity.max = math.ceil (190)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 14250 and inst.schwarzkirsche_level < 14625 then
	inst.components.health.maxhealth = math.ceil (165)
	inst.components.sanity.max = math.ceil (195)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 14625 and inst.schwarzkirsche_level < 15000 then
	inst.components.health.maxhealth = math.ceil (165)
	inst.components.sanity.max = math.ceil (195)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 15000 and inst.schwarzkirsche_level < 15375 then
	inst.components.health.maxhealth = math.ceil (170)
	inst.components.sanity.max = math.ceil (200)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 15375 and inst.schwarzkirsche_level < 15750 then
	inst.components.health.maxhealth = math.ceil (170)
	inst.components.sanity.max = math.ceil (200)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 15750 and inst.schwarzkirsche_level < 16125 then
	inst.components.health.maxhealth = math.ceil (170)
	inst.components.sanity.max = math.ceil (205)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 16125 and inst.schwarzkirsche_level < 16500 then
	inst.components.health.maxhealth = math.ceil (175)
	inst.components.sanity.max = math.ceil (205)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 16500 and inst.schwarzkirsche_level < 16875 then
	inst.components.health.maxhealth = math.ceil (175)
	inst.components.sanity.max = math.ceil (210)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 16875 and inst.schwarzkirsche_level < 17250 then
	inst.components.health.maxhealth = math.ceil (175)
	inst.components.sanity.max = math.ceil (210)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 17250 and inst.schwarzkirsche_level < 17625 then
	inst.components.health.maxhealth = math.ceil (180)
	inst.components.sanity.max = math.ceil (215)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 17625 and inst.schwarzkirsche_level < 18000 then
	inst.components.health.maxhealth = math.ceil (180)
	inst.components.sanity.max = math.ceil (215)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 18000 and inst.schwarzkirsche_level < 18375 then
	inst.components.health.maxhealth = math.ceil (180)
	inst.components.sanity.max = math.ceil (220)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 18375 and inst.schwarzkirsche_level < 18750 then
	inst.components.health.maxhealth = math.ceil (185)
	inst.components.sanity.max = math.ceil (220)
				inst.components.schshielder.max = math.ceil (50)	
			elseif inst.schwarzkirsche_level >= 18750 and inst.schwarzkirsche_level < 19125 then
	inst.components.health.maxhealth = math.ceil (185)
	inst.components.sanity.max = math.ceil (225)
				inst.components.schshielder.max = math.ceil (80)	
			elseif inst.schwarzkirsche_level >= 19125 and inst.schwarzkirsche_level < 19500 then
	inst.components.health.maxhealth = math.ceil (185)
	inst.components.sanity.max = math.ceil (225)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 19500 and inst.schwarzkirsche_level < 19875 then
	inst.components.health.maxhealth = math.ceil (190)
	inst.components.sanity.max = math.ceil (230)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 19875 and inst.schwarzkirsche_level < 20250 then
	inst.components.health.maxhealth = math.ceil (190)
	inst.components.sanity.max = math.ceil (230)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 20250 and inst.schwarzkirsche_level < 20625 then
	inst.components.health.maxhealth = math.ceil (190)
	inst.components.sanity.max = math.ceil (235)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 20625 and inst.schwarzkirsche_level < 21000 then
	inst.components.health.maxhealth = math.ceil (195)
	inst.components.sanity.max = math.ceil (235)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 21000 and inst.schwarzkirsche_level < 21375 then
	inst.components.health.maxhealth = math.ceil (195)
	inst.components.sanity.max = math.ceil (240)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 21375 and inst.schwarzkirsche_level < 21750 then
	inst.components.health.maxhealth = math.ceil (195)
	inst.components.sanity.max = math.ceil (240)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 21750 and inst.schwarzkirsche_level < 22125 then
	inst.components.health.maxhealth = math.ceil (200)
	inst.components.sanity.max = math.ceil (245)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 22125 and inst.schwarzkirsche_level < 22500 then
	inst.components.health.maxhealth = math.ceil (200)
	inst.components.sanity.max = math.ceil (245)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 22500 and inst.schwarzkirsche_level < 22875 then
	inst.components.health.maxhealth = math.ceil (200)
	inst.components.sanity.max = math.ceil (250)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 22875 and inst.schwarzkirsche_level < 23250 then
	inst.components.health.maxhealth = math.ceil (205)
	inst.components.sanity.max = math.ceil (250)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 23250 and inst.schwarzkirsche_level < 23625 then
	inst.components.health.maxhealth = math.ceil (205)
	inst.components.sanity.max = math.ceil (255)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 23625 and inst.schwarzkirsche_level < 24000 then
	inst.components.health.maxhealth = math.ceil (205)
	inst.components.sanity.max = math.ceil (255)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 24000 and inst.schwarzkirsche_level < 24375 then
	inst.components.health.maxhealth = math.ceil (210)
	inst.components.sanity.max = math.ceil (260)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 24375 and inst.schwarzkirsche_level < 24750 then
	inst.components.health.maxhealth = math.ceil (210)
	inst.components.sanity.max = math.ceil (260)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 24750 and inst.schwarzkirsche_level < 25125 then
	inst.components.health.maxhealth = math.ceil (210)
	inst.components.sanity.max = math.ceil (265)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 25125 and inst.schwarzkirsche_level < 25500 then
	inst.components.health.maxhealth = math.ceil (215)
	inst.components.sanity.max = math.ceil (265)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 25500 and inst.schwarzkirsche_level < 25875 then
	inst.components.health.maxhealth = math.ceil (215)
	inst.components.sanity.max = math.ceil (270)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 25875 and inst.schwarzkirsche_level < 26250 then
	inst.components.health.maxhealth = math.ceil (215)
	inst.components.sanity.max = math.ceil (270)
				inst.components.schshielder.max = math.ceil (80)
			elseif inst.schwarzkirsche_level >= 26250 and inst.schwarzkirsche_level < 26625 then
	inst.components.health.maxhealth = math.ceil (220)
	inst.components.sanity.max = math.ceil (275)
				inst.components.schshielder.max = math.ceil (100)	
			elseif inst.schwarzkirsche_level >= 26625 and inst.schwarzkirsche_level < 27000 then
	inst.components.health.maxhealth = math.ceil (220)
	inst.components.sanity.max = math.ceil (280)
				inst.components.schshielder.max = math.ceil (100)	
			elseif inst.schwarzkirsche_level >= 27000 and inst.schwarzkirsche_level < 27375 then
	inst.components.health.maxhealth = math.ceil (220)
	inst.components.sanity.max = math.ceil (280)
				inst.components.schshielder.max = math.ceil (100)	
			elseif inst.schwarzkirsche_level >= 27375 and inst.schwarzkirsche_level < 27750 then
	inst.components.health.maxhealth = math.ceil (225)
	inst.components.sanity.max = math.ceil (285)
				inst.components.schshielder.max = math.ceil (100)	
			elseif inst.schwarzkirsche_level >= 27750 and inst.schwarzkirsche_level < 28125 then
	inst.components.health.maxhealth = math.ceil (225)
	inst.components.sanity.max = math.ceil (285)
				inst.components.schshielder.max = math.ceil (100)	
			elseif inst.schwarzkirsche_level >= 28125 and inst.schwarzkirsche_level < 28500 then
	inst.components.health.maxhealth = math.ceil (225)
	inst.components.sanity.max = math.ceil (290)
				inst.components.schshielder.max = math.ceil (100)	
			elseif inst.schwarzkirsche_level >= 28500 and inst.schwarzkirsche_level < 28875 then
	inst.components.health.maxhealth = math.ceil (230)
	inst.components.sanity.max = math.ceil (290)
				inst.components.schshielder.max = math.ceil (100)	
			elseif inst.schwarzkirsche_level >= 28875 and inst.schwarzkirsche_level < 29250 then
	inst.components.health.maxhealth = math.ceil (230)
	inst.components.sanity.max = math.ceil (295)
				inst.components.schshielder.max = math.ceil (100)	
			elseif inst.schwarzkirsche_level >= 29250 and inst.schwarzkirsche_level < 30000 then
	inst.components.health.maxhealth = math.ceil (240)
	inst.components.sanity.max = math.ceil (295)
				inst.components.schshielder.max = math.ceil (100)	
			elseif inst.schwarzkirsche_level >= 30000 and inst.schwarzkirsche_level < 30375 then
	inst.components.health.maxhealth = math.ceil (245)
	inst.components.sanity.max = math.ceil (300)
				inst.components.schshielder.max = math.ceil (100)	
			elseif inst.schwarzkirsche_level >= 30375 then
	inst.components.health.maxhealth = math.ceil (250)
	inst.components.sanity.max = math.ceil (300)
				inst.components.schshielder.max = math.ceil (100)	
			end
	inst.components.health:SetPercent(health_percent)
	inst.components.sanity:SetPercent(sanity_percent)
	inst.components.schshielder:SetPercent(shield_percent)
end

local function IsValidVictim(victim)
    return victim ~= nil
        and not (victim:HasTag("veggie") or
			victim:HasTag("structure") or
				victim:HasTag("wall") or
					victim:HasTag("balloon") or
						victim:HasTag("soulless") or
							victim:HasTag("chess") or
								victim:HasTag("shadow") or
									victim:HasTag("shadowcreature") or
										victim:HasTag("shadowminion") or
											victim:HasTag("shadowchesspiece") or
												victim:HasTag("groundspike") or
													victim:HasTag("smashable"))
													and victim.components.combat ~= nil
													and victim.components.health ~= nil 
end

---------------------------[[ Components Warlock ]]----------------------------
local Chance_1 = 0.4
local Chance_2 = 0.2
local Chance_3 = 0.1
local function WarlockCharge(inst, data)
if math.random() < Chance_1 then
	inst.components.schwarlock:DoDelta(30)
elseif math.random() < Chance_2 then
	inst.components.schwarlock:DoDelta(60)
elseif math.random() < Chance_3 then
	inst.components.schwarlock:DoDelta(90)
	end
end


---------------------------[[ Exp KIlling ]]----------------------------
local function wathgrithr_spiritfx(inst, x, y, z, scale)
    local fx = SpawnPrefab("wathgrithr_spirit")
			fx.Transform:SetPosition(x, y, z)
				fx.Transform:SetScale(scale, scale, scale)
end

local smallScale = 0.5
local medScale = 0.7
local largeScale = 1.1

local function OnKillSpawnDarkSoul(inst, data)
local victim = data.victim
if IsValidVictim(victim) then

---- Hostile
	if victim.prefab == "minotaur" then 
		inst.schwarzkirsche_level = inst.schwarzkirsche_level + 500
ApplyExpLevel(inst)
elseif victim.prefab == "batbat" then 
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 15
ApplyExpLevel(inst)
elseif victim.prefab == "killerbee" then 
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 2
ApplyExpLevel(inst)
elseif victim.prefab == "bishop" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 45
ApplyExpLevel(inst)
elseif victim.prefab == "bishop_nightmare" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 40
ApplyExpLevel(inst)
elseif victim.prefab == "knight" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 35
ApplyExpLevel(inst)
elseif victim.prefab == "knight_nightmare" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 30
ApplyExpLevel(inst)
elseif victim.prefab == "rook" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 55
ApplyExpLevel(inst)
elseif victim.prefab == "rook_nightmare" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 50
ApplyExpLevel(inst)
elseif victim.prefab == "deerclops" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 600
ApplyExpLevel(inst)
elseif victim.prefab == "worm" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 200
ApplyExpLevel(inst)
elseif victim.prefab == "spat" then 
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 150
ApplyExpLevel(inst)
elseif victim.prefab == "frog" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 5
ApplyExpLevel(inst)
elseif victim.prefab == "ghost" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 10
ApplyExpLevel(inst)
elseif victim.prefab == "hound" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 25
ApplyExpLevel(inst)
elseif victim.prefab == "firehound" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 35
ApplyExpLevel(inst)
elseif victim.prefab == "icehound" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 40
ApplyExpLevel(inst)
elseif victim.prefab == "moonhound" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 50
ApplyExpLevel(inst)
elseif victim.prefab == "clayhound" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 55
ApplyExpLevel(inst)
elseif victim.prefab == "walrus" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 50
ApplyExpLevel(inst)
elseif victim.prefab == "little_walrus" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 15
ApplyExpLevel(inst)
elseif victim.prefab == "merm" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 30
ApplyExpLevel(inst)
elseif victim.prefab == "mosquito" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 3
ApplyExpLevel(inst)
elseif victim.prefab == "pigguard" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 30
ApplyExpLevel(inst)
elseif victim.prefab == "moonpig" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 40
ApplyExpLevel(inst)
elseif (victim.prefab == "crawlinghorror" or victim.prefab == "crawlingnightmare") then --- Gain Magic Charge for Warlock components when killing Shadow Creature
WarlockCharge(inst)
	-- inst.schwarzkirsche_level = inst.schwarzkirsche_level + 120
--ApplyExpLevel(inst)
elseif (victim.prefab == "terrorbeak" or victim.prefab == "nightmarebeak") then --- Gain Magic Charge for Warlock components when killing Shadow Creature
WarlockCharge(inst)
	--inst.schwarzkirsche_level = inst.schwarzkirsche_level + 125
--ApplyExpLevel(inst)
elseif victim.prefab == "slurper" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 25
ApplyExpLevel(inst)
elseif victim.prefab == "spider" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 15
ApplyExpLevel(inst)
elseif victim.prefab == "spider_warrior" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 30
ApplyExpLevel(inst)
elseif victim.prefab == "spider_hider" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 35
ApplyExpLevel(inst)
elseif victim.prefab == "spider_spitter" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 40
ApplyExpLevel(inst)
elseif victim.prefab == "spider_dropper" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 30
ApplyExpLevel(inst)
elseif victim.prefab == "tallbird" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 25
ApplyExpLevel(inst)
elseif victim.prefab == "tentacle" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 35
ApplyExpLevel(inst)
elseif victim.prefab == "tentacle_pillar_arm" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 20
ApplyExpLevel(inst)
elseif victim.prefab == "bearger" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 800
ApplyExpLevel(inst)
elseif victim.prefab == "dragonfly" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 1000
ApplyExpLevel(inst)
elseif victim.prefab == "moose" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 250
ApplyExpLevel(inst)
elseif victim.prefab == "warg" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 200
ApplyExpLevel(inst)
elseif victim.prefab == "monkey" and victim:HasTag("nightmare") then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 25
ApplyExpLevel(inst)
elseif victim.prefab == "claywarg" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 230
ApplyExpLevel(inst)
elseif victim.prefab == "lightninggoat" and victim:HasTag("charged") then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 45
ApplyExpLevel(inst)
elseif victim.prefab == "beequeen" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 900
ApplyExpLevel(inst)
elseif victim.prefab == "deer_red" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 30
ApplyExpLevel(inst)
elseif victim.prefab == "deer_blue" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 30
ApplyExpLevel(inst)
elseif victim.prefab == "beeguard" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 5
ApplyExpLevel(inst)
elseif victim.prefab == "klaus" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 850
ApplyExpLevel(inst)
elseif victim.prefab == "lavae" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 60
ApplyExpLevel(inst)
elseif victim.prefab == "toadstool" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 1500
ApplyExpLevel(inst)
elseif victim.prefab == "toadstool_dark" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 2000
ApplyExpLevel(inst)
---- Neutral 
elseif victim.prefab == "buzzard" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 25
ApplyExpLevel(inst)
elseif (victim.prefab == "leif" or victim.prefab == "leif_sparse") then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 30
ApplyExpLevel(inst)
elseif victim.prefab == "pigman" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 20
ApplyExpLevel(inst)
elseif victim.prefab == "penguin" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 15
ApplyExpLevel(inst)
elseif victim.prefab == "rocky" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 40
ApplyExpLevel(inst)
elseif victim.prefab == "slurtle" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 30
ApplyExpLevel(inst)
elseif victim.prefab == "snurtle" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 35
ApplyExpLevel(inst)
elseif victim.prefab == "monkey" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 15
ApplyExpLevel(inst)
elseif victim.prefab == "bunnyman" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 20
ApplyExpLevel(inst)
elseif victim.prefab == "bee" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 1
ApplyExpLevel(inst)
elseif victim.prefab == "beefalo" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 25
ApplyExpLevel(inst)
elseif victim.prefab == "koalefant_summer" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 20
ApplyExpLevel(inst)
elseif victim.prefab == "koalefant_winter" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 22
ApplyExpLevel(inst)
elseif victim.prefab == "krampus" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 15
ApplyExpLevel(inst)
elseif victim.prefab == "mossling" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 15
ApplyExpLevel(inst)
elseif victim.prefab == "catcoon" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 5
ApplyExpLevel(inst)
elseif victim.prefab == "lightninggoat" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 30
ApplyExpLevel(inst)
elseif victim.prefab == "antlion" then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level + 500
ApplyExpLevel(inst)
---- Passive ?? Nope 

		end
local time = victim.components.health.destroytime or 2
local x, y, z = victim.Transform:GetWorldPosition()
local scale = (victim:HasTag("smallcreature") and smallScale)
           or (victim:HasTag("largecreature") and largeScale) or medScale
	inst:DoTaskInTime(time, wathgrithr_spiritfx, x, y, z, scale)
SpawnPrefab("sch_dark_soul_spawn").Transform:SetPosition(victim:GetPosition():Get())
	end
end

---------------------------[[ Exp Foods ]]----------------------------
local function ExpFoods(inst, food)
--local item = {"canary","crow","feather_crow","feather_robin","feather_robin_winter","feather_canary","spider","fish","froglegs","rabbit","bee","eel","butterfly","pigskin","tentaclespots","stinger","bird_egg","mosquito"}
--	local randomitem = item[math.random(#item)]
	--	SpawnPrefab(randomitem).Transform:SetPosition(pos:Get());SpawnPrefab("collapse_small").Transform:SetPosition(pos:Get()) 
if food and food.components.edible and 
	food.components.edible.foodtype == "MEAT" then
	
	
elseif food.components.edible and 
		food.components.edible.foodtype == "VEGGIE" then

	end 	--ApplyExpLevel(inst)

end

---------------------------[[ Soul Spawn ]]----------------------------
local function IsSoul(item)
    return item.prefab == "sch_dark_soul"
end
local function GetStackSize(item)
    return item.components.stackable ~= nil and item.components.stackable:StackSize() or 1
end
local function SortByStackSize(l, r)
    return GetStackSize(l) < GetStackSize(r)
end
local function CheckSoulsAdded(inst)
    inst._checksoulstask = nil
    local souls = inst.components.inventory:FindItems(IsSoul)
    local count = 0
    for i, v in ipairs(souls) do
        count = count + GetStackSize(v)
    end
    if count > 40 then
        --convert count to drop count
        count = count - math.floor(40 / 2) + math.random(0, 2) - 1
        table.sort(souls, SortByStackSize)
        local pos = inst:GetPosition()
        for i, v in ipairs(souls) do
            local vcount = GetStackSize(v)
            if vcount < count then
                inst.components.inventory:DropItem(v, true, true, pos)
                count = count - vcount
            else
                if vcount == count then
                    inst.components.inventory:DropItem(v, true, true, pos)
                else
                    v = v.components.stackable:Get(count)
                    v.Transform:SetPosition(pos:Get())
                    v.components.inventoryitem:OnDropped(true)
                end
                break
            end
        end
        inst.components.sanity:DoDelta(-20)
		inst.sg:GoToState("mindcontrolled")
		inst.components.talker:Say("I can't handle too much darkness")
    elseif count > 30 then
        inst.components.talker:Say("I have too much soul, i can't carry anymore!")
    end
end
local function OnGotNewItem(inst, data)
    if data.item ~= nil and data.item.prefab == "sch_dark_soul" then
        if inst._checksoulstask ~= nil then
            inst._checksoulstask:Cancel()
        end
        inst._checksoulstask = inst:DoTaskInTime(0, CheckSoulsAdded)
    end
end

-----------------------------[[ BADGE THIRSTY]]----------------------------
local function ClientSchThirstyPercentChange(inst)
	if not TheWorld.ismastersim and inst.schthirstybadge ~= nil then
		if inst._clientcurrentschthirstyperc ~= inst._currentschthirstypercen:value() then
			local oldperc = inst._clientcurrentschthirstyperc
			if oldperc == nil then oldperc = 0 end
			inst._clientcurrentschthirstyperc = inst._currentschthirstypercen:value()
			inst.schthirstybadge:SetPercent(inst._clientcurrentschthirstyperc, inst._clientschthirstymax)
			local up = (inst.SchThirstyIdleRegen or inst.SchThirstySleepRegen or inst.SchThirstyWalkRegen) 
			local anim = up and "arrow_loop_increase" or "neutral"
			if inst.arrowdir ~= anim then
				inst.arrowdir = anim
				inst.schthirstyarrow:GetAnimState():PlayAnimation(anim, true)
			end
		end
	end
end
local function ClientSetSchThirstyMax(inst)
	if not TheWorld.ismastersim and inst.schthirstybadge ~= nil then
		if inst._clientschthirstymax ~= inst._schthirstymax:value() then
			inst._clientschthirstymax = inst._schthirstymax:value()
		end
	end	
end
-----------------------------[[ BADGE SHIELDERS]]----------------------------
local function ClientSchShielderPercentChange(inst)
	if not TheWorld.ismastersim and inst.schshielderbadge ~= nil then
		if inst._clientcurrentschshielderperc ~= inst._currentschshielderpercen:value() then
			local oldperc = inst._clientcurrentschshielderperc
			if oldperc == nil then oldperc = 0 end
			inst._clientcurrentschshielderperc = inst._currentschshielderpercen:value()
			inst.schshielderbadge:SetPercent(inst._clientcurrentschshielderperc, inst._clientschshieldermax)
			local up = (inst.SchShieldRegen)
			local anim = up and "arrow_loop_increase" or "neutral"
			if inst.arrowdir ~= anim then
				inst.arrowdir = anim
				inst.schshielderarrow:GetAnimState():PlayAnimation(anim, true)
			end
		end
	end
end
local function ClientSetSchShielderMax(inst)
	if not TheWorld.ismastersim and inst.schshielderbadge ~= nil then
		if inst._clientschshieldermax ~= inst._schshieldermax:value() then
			inst._clientschshieldermax = inst._schshieldermax:value()
		end
	end	
end
-----------------------------[[ BADGE WARLOCK]]----------------------------
local function ClientSchWarlockPercentChange(inst)
	if not TheWorld.ismastersim and inst.schwarlockbadge ~= nil then
		if inst._clientcurrentschwarlockperc ~= inst._currentschwarlockpercen:value() then
			local oldperc = inst._clientcurrentschwarlockperc
			if oldperc == nil then oldperc = 0 end
			inst._clientcurrentschwarlockperc = inst._currentschwarlockpercen:value()
			inst.schwarlockbadge:SetPercent(inst._clientcurrentschwarlockperc, inst._clientschwarlockmax)
			local up = (inst:HasTag("")) 
			local anim = up and "arrow_loop_increase" or "neutral"
			if inst.arrowdir ~= anim then
				inst.arrowdir = anim
				inst.schwarlockarrow:GetAnimState():PlayAnimation(anim, true)
			end
		end
	end
end
local function ClientSetSchWarlockMax(inst)
	if not TheWorld.ismastersim and inst.schwarlockbadge ~= nil then
		if inst._clientschwarlockmax ~= inst._schwarlockmax:value() then
			inst._clientschwarlockmax = inst._schwarlockmax:value()
		end
	end	
end
-----------------------------[[ BADGE TREASURE]]----------------------------
local function ClientSchTreasurePercentChange(inst)
	if not TheWorld.ismastersim and inst.schtreasurebadge ~= nil then
		if inst._clientcurrentschtreasureperc ~= inst._currentschtreasurepercen:value() then
			local oldperc = inst._clientcurrentschtreasureperc
			if oldperc == nil then oldperc = 0 end
			inst._clientcurrentschtreasureperc = inst._currentschtreasurepercen:value()
			inst.schtreasurebadge:SetPercent(inst._clientcurrentschtreasureperc, inst._clientschtreasuremax)
			local up = (inst:HasTag("Schwarzkirsche") and inst.IsWalkingforTreasure) 
			local anim = up and "arrow_loop_increase" or "neutral"
			if inst.arrowdir ~= anim then
				inst.arrowdir = anim
				inst.schtreasurearrow:GetAnimState():PlayAnimation(anim, true)
			end
		end
	end
end
local function ClientSetSchTreasureMax(inst)
	if not TheWorld.ismastersim and inst.schtreasurebadge ~= nil then
		if inst._clientschtreasuremax ~= inst._schtreasuremax:value() then
			inst._clientschtreasuremax = inst._schtreasuremax:value()
		end
	end	
end
-----------------------------[[ BADGE BLOOMING]]----------------------------
local function ClientSchBloomlevelPercentChange(inst)
	if not TheWorld.ismastersim and inst.schbloomlevelbadge ~= nil then
		if inst._clientcurrentschbloomlevelperc ~= inst._currentschbloomlevelpercen:value() then
			local oldperc = inst._clientcurrentschbloomlevelperc
			if oldperc == nil then oldperc = 0 end
			inst._clientcurrentschbloomlevelperc = inst._currentschbloomlevelpercen:value()
			inst.schbloomlevelbadge:SetPercent(inst._clientcurrentschbloomlevelperc, inst._clientschbloomlevelmax)
			local up = (inst:HasTag("Schwarzkirsche")) 
			local anim = up and "arrow_loop_increase" or "neutral"
			if inst.arrowdir ~= anim then
				inst.arrowdir = anim
				inst.schbloomlevelarrow:GetAnimState():PlayAnimation(anim, true)
			end
		end
	end
end
local function ClientSetSchBloomlevelMax(inst)
	if not TheWorld.ismastersim and inst.schbloomlevelbadge ~= nil then
		if inst._clientschbloomlevelmax ~= inst._schbloomlevelmax:value() then
			inst._clientschbloomlevelmax = inst._schbloomlevelmax:value()
		end
	end	
end

-----------------------------[[ BADGE CRITICALHIT]]----------------------------
local function ClientSchCriticalhitPercentChange(inst)
	if not TheWorld.ismastersim and inst.schcriticalhitbadge ~= nil then
		if inst._clientcurrentschcriticalhitperc ~= inst._currentschcriticalhitpercen:value() then
			local oldperc = inst._clientcurrentschcriticalhitperc
			if oldperc == nil then oldperc = 0 end
			inst._clientcurrentschcriticalhitperc = inst._currentschcriticalhitpercen:value()
			inst.schcriticalhitbadge:SetPercent(inst._clientcurrentschcriticalhitperc, inst._clientschcriticalhitmax)
			local up = (inst:HasTag("Schwarzkirsche")) 
			local anim = up and "arrow_loop_increase" or "neutral"
			if inst.arrowdir ~= anim then
				inst.arrowdir = anim
				inst.schcriticalhitarrow:GetAnimState():PlayAnimation(anim, true)
			end
		end
	end
end
local function ClientSetSchCriticalhitMax(inst)
	if not TheWorld.ismastersim and inst.schcriticalhitbadge ~= nil then
		if inst._clientschcriticalhitmax ~= inst._schcriticalhitmax:value() then
			inst._clientschcriticalhitmax = inst._schcriticalhitmax:value()
		end
	end	
end
-----------------------------[[ END BADGE ]]----------------------------
local function fade(inst)
	inst.time = inst.time - 0.01
	if inst.time < 1 then
		inst.AnimState:SetMultColour(inst.time,inst.time,inst.time,inst.time)
		if inst.time  == 0 then
			--inst:Remove()
		end
	end
end

------------------------------------------------------------------------
-- Thanks Forest Stalker for your special ability
local MAX_TRAIL_VARIATIONS = 5
local MAX_RECENT_TRAILS = 3
local TRAIL_MIN_SCALE = 1
local TRAIL_MAX_SCALE = 1.5

local function PickTrail(inst)
    local rand = table.remove(inst.availabletrails, math.random(#inst.availabletrails))
    table.insert(inst.usedtrails, rand)
    if #inst.usedtrails > MAX_RECENT_TRAILS then
        table.insert(inst.availabletrails, table.remove(inst.usedtrails, 1))
    end
    return rand
end

local function RefreshTrail(inst, fx)
    if fx:IsValid() then
        fx:Refresh()
    else
        inst._trailtask:Cancel()
        inst._trailtask = nil
    end
end

local function DoTrail(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
	if inst.sg:HasStateTag("moving") then
        local theta = -inst.Transform:GetRotation() * DEGREES
        x = x + math.cos(theta)
        z = z + math.sin(theta)
    end
    local fx = SpawnPrefab("damp_trail")
    fx.Transform:SetPosition(x, 0, z)
    fx:SetVariation(PickTrail(inst), GetRandomMinMax(TRAIL_MIN_SCALE, TRAIL_MAX_SCALE), TUNING.STALKER_BLOOM_DECAY)
    if inst._trailtask ~= nil then
        inst._trailtask:Cancel()
    end
	inst._trailtask = inst:DoPeriodicTask(TUNING.STALKER_BLOOM_DECAY * .5, RefreshTrail, nil, fx)
end

local BLOOM_CHOICES =
{
    ["stalker_bulb"] = .3,
    ["stalker_bulb_double"] = .25,
    ["stalker_berry"] = 1,
	["stalker_fern"] = 3,
	["sch_spore"] = .2,
	["sch_spore_blue"] = .2,
	["sch_spore_red"] = .1,
	
}

local function DoPlantBloom(inst)
    local x, y, z = inst.Transform:GetWorldPosition()
    local map = TheWorld.Map
    local offset = FindValidPositionByFan(
        math.random() * 1 * PI,
        math.random() * 2,
        4,
        function(offset)
            local x1 = x + offset.x
            local z1 = z + offset.z
            return map:IsPassableAtPoint(x1, 0, z1)
                and map:IsDeployPointClear(Vector3(x1, 0, z1), nil, 1)
                and #TheSim:FindEntities(x1, 0, z1, 2.5, { "stalkerbloom" }) < 4
        end
    )

    if offset ~= nil then
        SpawnPrefab(weighted_random_choice(BLOOM_CHOICES)).Transform:SetPosition(x + offset.x, 0, z + offset.z)
    end
end

local function OnStartBlooming(inst)
    DoTrail(inst)
   -- inst._bloomtask = inst:DoPeriodicTask(3 * FRAMES, DoPlantBloom, 2 * FRAMES)
	inst._bloomtask = inst:DoPeriodicTask(9 * FRAMES, DoPlantBloom, 6 * FRAMES)
end

local function _StartBlooming(inst)
    if inst._bloomtask == nil then
        inst._bloomtask = inst:DoTaskInTime(0, OnStartBlooming)
    end
end

local function ForestOnEntityWake(inst)
    if inst._blooming then
		if not (inst.sg:HasStateTag("rowing") or inst.sg:HasStateTag("sailing") or inst.sg:HasStateTag("sail") or inst.sg:HasStateTag("row") or inst.sg:HasStateTag("boating") or inst:HasTag("aquatic")) then
        _StartBlooming(inst)
		end
    end
end

local function ForestOnEntitySleep(inst)
    if inst._bloomtask ~= nil then
        inst._bloomtask:Cancel()
        inst._bloomtask = nil
    end
    if inst._trailtask ~= nil then
        inst._trailtask:Cancel()
        inst._trailtask = nil
    end
end

local function StartBlooming(inst)
    if not inst._blooming then
        inst._blooming = true
        if not inst:IsAsleep() then
            _StartBlooming(inst)
        end
    end
end

local function StopBlooming(inst)
    if inst._blooming then
        inst._blooming = false
        ForestOnEntitySleep(inst)
    end
end

-- Thanks Wortox for your special action, soul hop
local function NoHoles(pt)
    return not TheWorld.Map:IsGroundTargetBlocked(pt)
end
local function ReticuleTargetFn(inst)
    local rotation = inst.Transform:GetRotation() * DEGREES
    local pos = inst:GetPosition()
    pos.y = 0
    for r = 13, 4, -.5 do
        local offset = FindWalkableOffset(pos, rotation, r, 1, false, true, NoHoles)
        if offset ~= nil then
            pos.x = pos.x + offset.x
            pos.z = pos.z + offset.z
            return pos
        end
    end
    for r = 13.5, 16, .5 do
        local offset = FindWalkableOffset(pos, rotation, r, 1, false, true, NoHoles)
        if offset ~= nil then
            pos.x = pos.x + offset.x
            pos.z = pos.z + offset.z
            return pos
        end
    end
    pos.x = pos.x + math.cos(rotation) * 13
    pos.z = pos.z - math.sin(rotation) * 13
    return pos
end

-- Thanks wheeler for your special action, dodge
local DODGE_COOLDOWN = 1.5
local function GetPointSpecialActions(inst, pos, useitem, right)
	local rider = inst.components.rider
    if right and not inst:HasTag("soulteleporter") and (rider == nil or not rider:IsRiding()) and not inst:HasTag("onthirsty") then
	    if GetTime() - inst.last_dodge_time > DODGE_COOLDOWN then
        	return { ACTIONS.SCHDODGE }
		end 
	end
	if right and inst:HasTag("soulteleporter") and (rider == nil or not rider:IsRiding()) then
		return { ACTIONS.SCHTELEPORT } 
	end
	return {}
end

local function ThirstyforDodge(inst, data)
	if inst.components.schthirsty.current >= 3 then
		inst:AddTag("schdodger")
		inst:RemoveTag("onthirsty")
	elseif inst.components.schthirsty.current < 3 then
		inst:AddTag("onthirsty")
		inst:RemoveTag("schdodger")
	end
end

local function OnSetOwner(inst)
    if inst.components.playeractionpicker ~= nil then
		inst.components.playeractionpicker.pointspecialactionsfn = GetPointSpecialActions
	end
	--[[ Next Update
	if TheWorld.ismastersim then
        inst.schwarzkirsche_key_classified.Network:SetClassifiedTarget(inst)
    end ]]
end

local function AttachClassified(inst, classified)
	inst.schwarzkirsche_key_classified = classified
    inst.ondetachschkeyclassified = function() inst:DetachSchkeyClassified() end
    inst:ListenForEvent("onremove", inst.ondetachschkeyclassified, classified)
end

local function DetachClassified(inst)
	inst.schwarzkirsche_key_classified = nil
    inst.ondetachschkeyclassified = nil
end

local function OverrideOnRemoveEntity(inst)
	inst.OnRemoveSchkey = inst.OnRemoveEntity
	function inst.OnRemoveEntity(inst)
		if inst.jointask ~= nil then
			inst.jointask:Cancel()
		end

		if inst.schwarzkirsche_key_classified ~= nil then
			if TheWorld.ismastersim then
				inst.schwarzkirsche_key_classified:Remove()
				inst.schwarzkirsche_key_classified = nil
			else
				inst:RemoveEventCallback("onremove", inst.ondetachschkeyclassified, inst.schwarzkirsche_key_classified)
				inst:DetachSchkeyClassified()
			end
		end
		return inst:OnRemoveSchkey()
	end
end

-----------------------------[[ DEATH PENALTY ]]----------------------------
local function DeathPenalty(inst, data)
if inst.components.schtreasure then
	inst.components.schtreasure:DoDelta(-15)
	end
if inst.components.schbloomlevel then
	inst.components.schbloomlevel:DoDelta(-40)
	end
if inst.components.schwarlock then
	inst.components.schwarlock:DoDelta(-30)
	end
if inst.components.schthirsty then
	inst.components.schthirsty:DoDelta(-40)
	end

if inst.schwarzkirsche_level >= 26250 then
	inst.schwarzkirsche_level = inst.schwarzkirsche_level - 375
	ApplyExpLevel(inst)
	end

	inst.IsBloomingState = false
	inst.IsStateRageMode = false
end


-----------------------------[[ TREASURE ]]----------------------------
local function On_Thirsty(inst, data)
if (inst.sg:HasStateTag("walking") or inst.sg:HasStateTag("moving")) and not inst.sg:HasStateTag("sleeping") then
		inst.SchThirstyWalkRegen = true
		inst.SchThirstySleepRegen = false
		inst.SchThirstyIdleRegen = false
elseif not (inst.sg:HasStateTag("walking") or inst.sg:HasStateTag("moving")) and not inst.sg:HasStateTag("sleeping")then
		inst.SchThirstyWalkRegen = false
		inst.SchThirstySleepRegen = false
		inst.SchThirstyIdleRegen = true
elseif not (inst.sg:HasStateTag("walking") or inst.sg:HasStateTag("moving")) and inst.sg:HasStateTag("sleeping") then
		inst.SchThirstyWalkRegen = false
		inst.SchThirstySleepRegen = true
		inst.SchThirstyIdleRegen = false
	end
end

-----------------------------[[ TREASURE ]]----------------------------
local function Treasure_start(inst, data)
if (inst.sg:HasStateTag("walking") or inst.sg:HasStateTag("moving")) and not 
	inst.sg:HasStateTag("sleeping") and not inst.sg:HasStateTag("attack") and not inst:HasTag("playerghost") then 
	inst.IsWalkingforTreasure = true
else
	inst.IsWalkingforTreasure = false
	end
end

local function Treasure_Revealed(inst, data)
if inst.components.schtreasure.current >= 100 then
	if not inst.TalkForTreasure then 
		inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_TREASURE_FOUND.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_TREASURE_BUTTON.."]", 1)
			inst.TalkForTreasure = true
		end
	end
end

-----------------------------[[ SOUL CHECK ]]----------------------------
local function IsDarkSoulinInv(inst, data)
if inst.components.inventory:Has("sch_dark_soul", 1) then
   inst:AddTag("soulteleporter")
  end
end

local function NoDarkSoulinInv(inst, data)
if not inst.components.inventory:Has("sch_dark_soul", 1) then
   inst:RemoveTag("soulteleporter")
  end
end

-----------------------------[[ SKIN ]]----------------------------
local function IsAutumnStart(season)
    return season == "autumn"
end
local function IsWinterStart(season)
    return season == "winter"
end
local function IsSpringStart(season)
    return season == "spring"
end
local function IsSummerStart(season)
    return season == "summer"
end
local function SeasonalSkin(inst, season)
if IsAutumnStart(season) then
if not inst.AutumnSkin then
	inst.AutumnSkin = true inst.WinterSkin = false
	inst.SpringSkin = false inst.SummerSkin = false
		end
	end
if IsWinterStart(season) then
if not inst.WinterSkin then
	inst.AutumnSkin = false inst.WinterSkin = true
	inst.SpringSkin = false inst.SummerSkin = false
		end
	end
if IsSpringStart(season) then
if not inst.SpringSkin then
	inst.AutumnSkin = false inst.WinterSkin = false
	inst.SpringSkin = true inst.SummerSkin = false
		end
	end
if IsSummerStart(season) then
if not inst.SummerSkin then
	inst.AutumnSkin = false inst.WinterSkin = false
	inst.SpringSkin = false inst.SummerSkin = true
		end
	end
end
local function OnWetStart(inst, data)
if inst.components.moisture:IsWet() then
	inst.NormalModeIsWet = true
	end
if not inst.components.moisture:IsWet() then
	inst.NormalModeIsWet = false
	end
end

-----------------------------[[ FULL MOON STATE ]]----------------------------
local function OnFullMoonLifeStealer(inst, data)
if TheWorld.state.isfullmoon then
local other = data.attacker
if other and 
	other.components.burnable and 
		other.components.health and not 
			other:HasTag("thorny") and not 
				other:HasTag("shadowcreature") and 
					other.components.combat then
            other.components.health:DoDelta(-15)
SpawnPrefab("statue_transition_2").Transform:SetPosition(other:GetPosition():Get())
			end
		inst.components.health:DoDelta(1)
	end
end

local function OnFullMoonMode(inst, data)
if TheWorld.state.isfullmoon then
inst.IsFullMoonState = true
--- Adds
	inst.SchwarzNormalMode = false
	--inst.FullMoonPriority = true
				inst.NormalModeIsWet = false
					--- Stop Bloom
					StopBlooming(inst)
						inst.IsBlooming = false
							--- Stop Rage
							inst.IsStateRageMode = false
								--- Rage Tags
									inst:RemoveTag("InRageMode")
										--- Normal Tags
											inst:RemoveTag("InNormalMode")
	end
if not TheWorld.state.isfullmoon then
inst.IsFullMoonState = false
--- Adds
	inst.SchwarzNormalMode = true
	--inst.FullMoonPriority = false
		inst:RemoveTag("monster")
			inst:RemoveTag("FullMoonMode")
	end
end

-----------------------------------------------------------------------------

local function AuraTarget(target)
	if (target:HasTag("monster") and not target:HasTag("shadowcreature")) then
		return true
	end
	return false
end

local function FullmoonAura(inst, dt)
	if not inst:HasTag("playerghost") then
		if inst:HasTag("FullMoonMode") then
			local pos = Vector3(inst.Transform:GetWorldPosition());pos.y = pos.y + .2
			local fx = SpawnPrefab("sch_fire_ring")
				  fx.Transform:SetPosition(pos:Get())
				  fx.Transform:SetScale(0.5,0.5,0.5)
				  
			local auraRange = 7 --------- Light Radius
			local hits = inst.components.combat:DoAreaAttack(inst, auraRange, inst, AuraTarget)
		end
	end
end

--------------------------------------- [[ Just Make Sure ]]--------------

local function SetWere(inst, data)
	inst:AddTag("spiderwhisperer")
	inst:AddTag("monster")
	inst:AddTag("LunarMode")
	inst:AddTag("FullMoonMode")
	inst:AddTag("playermonster")
	inst.SchwarzFullMoon = true
	inst.FullMoonState = true
	inst.IsFullMoonState = true
	inst.FullMoonPriority = true
	print("Schwarz : SetFullMoon : Werebeast = Yes")
    inst.Light:Enable(true)
    inst.Light:SetRadius(7)
    inst.Light:SetFalloff(.6)
    inst.Light:SetIntensity(0.9)
    inst.Light:SetColour(40/255, 40/255, 50/255)
	inst.EnergyShieldIsOn = false
	inst.components.eater.strongstomach = true
	inst.components.locomotor:SetTriggersCreep(false)
	
	inst.AuraAttack = inst:DoPeriodicTask(1, FullmoonAura, nil, 1)
	
	inst.components.talker:Say("Show time", 1)

end

local function SetNormal(inst, data)
	inst:RemoveTag("spiderwhisperer")
	inst:RemoveTag("monster")
	inst:RemoveTag("FullMoonMode")
	inst:RemoveTag("playermonster")
	inst.SchwarzFullMoon = false
	inst.FullMoonState = false
	inst.IsFullMoonState = false
	inst.FullMoonPriority = false
	inst.EnergyShieldIsOn = true
	print("Schwarz : SetNormal : Werebeast = No")
    inst.Light:Enable(false)
    inst.Light:SetRadius(7)
    inst.Light:SetFalloff(.6)
    inst.Light:SetIntensity(0.9)
    inst.Light:SetColour(40/255, 40/255, 50/255)
	inst.components.eater.strongstomach = false
	inst.components.locomotor:SetTriggersCreep(true)
	
	if inst.AuraAttack then
	   inst.AuraAttack:Cancel()
	   inst.AuraAttack = nil
	end
	
	inst.components.talker:Say("Lunar Dream is End", 1)
	
end

-----------------------------------------------------------------------------
local function GetFuelMasterBonus(inst, item, target)
    return (target:HasTag("LuxuryGems") or 
			target:HasTag("SchScythe") or target:HasTag("campfire") or 
			target:HasTag("ArmoredHat") or target:HasTag("SchDress") or 
	        target.prefab == "nightlight") and TUNING.WILLOW_CAMPFIRE_FUEL_MULT or 1
end
-----------------------------------------------------------------------------
local function sanityfn(inst)--, dt)
--[[
    local delta = inst.components.temperature:IsFreezing() and -TUNING.SANITYAURA_LARGE or 0
    local x, y, z = inst.Transform:GetWorldPosition() 
    local max_rad = 10
    local ents = TheSim:FindEntities(x, y, z, max_rad, { "fire", "flower", "butterfly" }, { "monster", "ghost" })
    for i, v in ipairs(ents) do
        if v.components.burnable ~= nil and v.components.burnable:IsBurning() then
            local rad = v.components.burnable:GetLargestLightRadius() or 1
            local sz = TUNING.DAPPERNESS_SMALL * math.min(max_rad, rad) / max_rad
            local distsq = inst:GetDistanceSqToInst(v) - 9
            delta = delta + sz / math.max(1, distsq)
        end
    end
    return delta
]]
	local x,y,z = inst.Transform:GetWorldPosition()	
	local delta = 0 ----- Hmmm
	local max_rad = 10
	local ents = TheSim:FindEntities(x,y,z, max_rad, { "fire", "flower", "butterfly" }, { "monster", "ghost" })
    for k,v in pairs(ents) do 
    	if v.components.burnable and v.components.burnable.burning then
    		local sz = TUNING.SANITYAURA_TINY
    		local rad = v.components.burnable:GetLargestLightRadius() or 1
    		sz = sz * ( math.min(max_rad, rad) / max_rad )
			local distsq = inst:GetDistanceSqToInst(v)
			delta = delta + sz/math.max(1, distsq)
    	end
    end

    return delta
end
-----------------------------------------------------------------------------
local function CalcSanityAura(inst, observer)
    return (inst:HasTag("FullMoonMode") and -TUNING.SANITYAURA_LARGE)
        or (inst.components.werebeast ~= nil and inst.components.werebeast:IsInWereState() and -TUNING.SANITYAURA_LARGE)
        or 0
end
-----------------------------[[ BLOOMING STATE ]]----------------------------
local function OnBlooming(inst, data)
if inst.IsBlooming then
	inst.components.schbloomlevel:DoDelta(-1)
		inst:AddTag("SchFlourishMode")
elseif not inst.IsBlooming then
	inst.components.schbloomlevel:DoDelta(0)
		inst:RemoveTag("SchFlourishMode")
	end
end

local function OnBloomingStart(inst, data)
if inst.IsBloomingState then
		StartBlooming(inst)
			inst.IsBlooming = true
				inst.NormalModeIsWet = false
elseif not inst.IsBloomingState then
		StopBlooming(inst)
			inst.IsBlooming = false
	end
end

local function CheckBloomLevels(inst, data)
if inst.components.schbloomlevel.current >= 200 then
	--	inst.IsBloomingState = true ----- Check Component : bloomlevel
elseif inst.components.schbloomlevel.current <= 0 then
		inst.IsBloomingState = false
	end
end

-----------------------------[[ RAGE STATE ]]----------------------------
local function OnRageMode(inst, data)
if not inst.components.health:IsDead() then
	if inst.components.health.currenthealth < 50 then
		if not inst.FullMoonPriority then
			inst.IsStateRageMode = true 
				inst.IsStateNormalMode = false 
					--- Disable Blooming Mode in Rage Mode
						inst.IsBloomingState = false
							--- Stop Bloom
								StopBlooming(inst)
									--- Keep in Rage
										inst.NormalModeIsWet = false
										--- Add Tag
											inst:AddTag("InRageMode")
												inst:RemoveTag("InNormalMode")
								end
		elseif inst.components.health.currenthealth > 50 then
					inst.IsStateRageMode = false
						inst.IsStateNormalMode = true 
							inst:RemoveTag("InRageMode")
								inst:AddTag("InNormalMode")
			end
			
	if inst.IsStateRageMode then 
if inst.strength == "ascendant" then
		inst.components.combat.damagemultiplier = 3
elseif inst.strength == "ancient" then
		inst.components.combat.damagemultiplier = 2.5
elseif inst.strength == "veteran" then
		inst.components.combat.damagemultiplier = 2
elseif inst.strength == "normal" then
		inst.components.combat.damagemultiplier = 1.5
elseif inst.strength == "midverage" then
		inst.components.combat.damagemultiplier = 1.1
elseif inst.strength == "sloth" then
		inst.components.combat.damagemultiplier = 0.8
elseif inst.strength == "empty" then
		inst.components.combat.damagemultiplier = 0.5
			end
		end
	end	
end

-----------------------------[[ UPDATE DAMAGE ]]----------------------------
local function UpdateDamagePerHungerChange(inst, data)
if inst.components.hunger.current >= 250 then
	inst.strength = "ascendant"
elseif inst.components.hunger.current >= 190 and inst.components.hunger.current < 250 then
	inst.strength = "ancient"
elseif inst.components.hunger.current >= 150 and inst.components.hunger.current < 190 then
	inst.strength = "veteran"
elseif inst.components.hunger.current >= 110 and inst.components.hunger.current < 150 then
	inst.strength = "normal"
elseif inst.components.hunger.current >= 70 and inst.components.hunger.current < 110 then
	inst.strength = "midverage"
elseif inst.components.hunger.current >= 30 and inst.components.hunger.current < 70 then
	inst.strength = "sloth"
elseif inst.components.hunger.current < 30 then
	inst.strength = "empty"
	end
	
	if not inst.IsStateRageMode then
if inst.strength == "ascendant" then
		inst.components.combat.damagemultiplier = 1.5
elseif inst.strength == "ancient" then
		inst.components.combat.damagemultiplier = 1.25
elseif inst.strength == "veteran" then
		inst.components.combat.damagemultiplier = 1
elseif inst.strength == "normal" then
		inst.components.combat.damagemultiplier = 0.75
elseif inst.strength == "midverage" then
		inst.components.combat.damagemultiplier = 0.55
elseif inst.strength == "sloth" then
		inst.components.combat.damagemultiplier = 0.4
elseif inst.strength == "empty" then
		inst.components.combat.damagemultiplier = 0.25
end
	end


if inst.sg:HasStateTag("nomorph") or
		inst:HasTag("playerghost") or
			inst.components.health:IsDead() then
		return
	end 
end
-----------------------------[[ UPDATE SKIN ]]----------------------------
local function OnRespawnforSkin(inst, data)
if not inst.components.health:IsDead() or inst.sg:HasStateTag("nomorph") or inst:HasTag("playerghost") then
		inst:DoTaskInTime( 3, function() 
			inst.CanUpdateSkin = true 
	SpawnPrefab("collapse_small").Transform:SetPosition(inst:GetPosition():Get()) 
	--------------[[ TEMPORARY ]]-------------
	if inst.components.locomotor ~= nil then
		if inst.PIko2ndState == "UP" then
			inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED*1.3    
			inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED*1.3 
		else
			inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED*1.25    
			inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED*1.25 
		end 
			end
		end)
	end 
end

-----------------------------[[ UPDATE SKIN ]]----------------------------
local function UpdateSkin(inst, data)
if inst.CanUpdateSkin then
------------------------------ [[ 1st ]] --------------------------------
if inst.PIko2ndState == "NO" then
----------- Autumn
if inst.AutumnSkin then
---- Normal
if not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche")
---- Normal Wet
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and --- False
					inst.NormalModeIsWet then --- True
	inst.AnimState:SetBuild("schwarzkirsche_blue")
---- Rage
elseif inst.IsStateRageMode and not --- True
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_red")
---- Bloom
elseif not inst.IsStateRageMode and  --- False
			inst.IsBloomingState and not --- true
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_green")
---- Moon
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and --- False
				inst.IsFullMoonState and not --- true
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_black")
	end
end


----------- Winter
if inst.WinterSkin then
---- Normal Winter
if not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_aquatic")
---- Normal Wet
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and --- False
					inst.NormalModeIsWet then --- True
	inst.AnimState:SetBuild("schwarzkirsche_blue")
---- Rage
elseif inst.IsStateRageMode and not --- True
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_red")
---- Bloom
elseif not inst.IsStateRageMode and  --- False
			inst.IsBloomingState and not --- true
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_green")
---- Moon
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and --- False
				inst.IsFullMoonState and not --- true
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_black")
	end
end


----------- Spring
if inst.SpringSkin then
---- Normal Winter
if not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_purple")
---- Normal Wet
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and --- False
					inst.NormalModeIsWet then --- True
	inst.AnimState:SetBuild("schwarzkirsche_blue")
---- Rage
elseif inst.IsStateRageMode and not --- True
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_red")
---- Bloom
elseif not inst.IsStateRageMode and  --- False
			inst.IsBloomingState and not --- true
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_green")
---- Moon
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and --- False
				inst.IsFullMoonState and not --- true
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_black")
	end
end


----------- Summer
if inst.SummerSkin then
if not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_sun")
---- Normal Wet
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and --- False
					inst.NormalModeIsWet then --- True
	inst.AnimState:SetBuild("schwarzkirsche_blue")
---- Rage
elseif inst.IsStateRageMode and not --- True
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_red")
---- Bloom
elseif not inst.IsStateRageMode and  --- False
			inst.IsBloomingState and not --- true
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_green")
---- Moon
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and --- False
				inst.IsFullMoonState and not --- true
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_black")
	end
end
		end
------------------------------ [[ 2nd ]] --------------------------------
if inst.PIko2ndState == "UP" then
----------- Autumn
if inst.AutumnSkin then
---- Normal
if not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_2nd")
---- Normal Wet
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and --- False
					inst.NormalModeIsWet then --- True
	inst.AnimState:SetBuild("schwarzkirsche_blue_2nd")
---- Rage
elseif inst.IsStateRageMode and not --- True
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_red_2nd")
---- Bloom
elseif not inst.IsStateRageMode and  --- False
			inst.IsBloomingState and not --- true
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_green_2nd")
---- Moon
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and --- False
				inst.IsFullMoonState and not --- true
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_black_2nd")
	end
end


----------- Winter
if inst.WinterSkin then
---- Normal Winter
if not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_aquatic_2nd")
---- Normal Wet
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and --- False
					inst.NormalModeIsWet then --- True
	inst.AnimState:SetBuild("schwarzkirsche_blue_2nd")
---- Rage
elseif inst.IsStateRageMode and not --- True
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_red_2nd")
---- Bloom
elseif not inst.IsStateRageMode and  --- False
			inst.IsBloomingState and not --- true
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_green_2nd")
---- Moon
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and --- False
				inst.IsFullMoonState and not --- true
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_black_2nd")
	end
end


----------- Spring
if inst.SpringSkin then
---- Normal Winter
if not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_purple_2nd")
---- Normal Wet
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and --- False
					inst.NormalModeIsWet then --- True
	inst.AnimState:SetBuild("schwarzkirsche_blue_2nd")
---- Rage
elseif inst.IsStateRageMode and not --- True
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_red_2nd")
---- Bloom
elseif not inst.IsStateRageMode and  --- False
			inst.IsBloomingState and not --- true
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_green_2nd")
---- Moon
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and --- False
				inst.IsFullMoonState and not --- true
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_black_2nd")
	end
end


----------- Summer
if inst.SummerSkin then
if not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_sun_2nd")
---- Normal Wet
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and --- False
					inst.NormalModeIsWet then --- True
	inst.AnimState:SetBuild("schwarzkirsche_blue_2nd")
---- Rage
elseif inst.IsStateRageMode and not --- True
			inst.IsBloomingState and not --- False
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_red_2nd")
---- Bloom
elseif not inst.IsStateRageMode and  --- False
			inst.IsBloomingState and not --- true
				inst.IsFullMoonState and not --- False
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_green_2nd")
---- Moon
elseif not inst.IsStateRageMode and not --- False
			inst.IsBloomingState and --- False
				inst.IsFullMoonState and not --- true
					inst.NormalModeIsWet then --- False
	inst.AnimState:SetBuild("schwarzkirsche_black_2nd")
	end
end
		end

	end
end
-----------------------------[[ Remove Invicible Buff ]]----------------------------
local function RemoveDodgeBuff(inst, data)
if inst:HasTag("dodging") then
	inst:RemoveTag("dodging")
		inst.components.health:SetInvincible(false)
	end
if inst.sg:HasStateTag("dodge") then
		if not inst.sg:GoToState("dodge_pst") and (inst.sg:HasStateTag("armorbroke") or 
												   inst.sg:HasStateTag("toolbroke") or 
												   inst.sg:HasStateTag("tool_slip")) then
					RemoveDodgeBuff(inst)
		end 
	end
end

-----------------------------[[ DEFENSE/SHIELD ]]----------------------------
local function BlockDamage(inst, data)
if not inst:HasTag("OnShield") then
local attacker = data.attacker
if not inst.components.health:IsDead() then
if attacker ~= nil then
		if attacker.components.health then
			if attacker.components.freezable then
				local spikes = "icespike_fx_"..math.random(1,4)
				local fx = SpawnPrefab(spikes)
				local sizefx = math.random(0.75,1.25)
					fx.Transform:SetScale(sizefx, sizefx, sizefx)
					fx.Transform:SetPosition(attacker:GetPosition():Get())
				attacker.components.freezable:AddColdness(1.25)
				attacker.components.freezable:SpawnShatterFX()
				
				else
		
					return  ----- Do Nothing
			end
		end
	inst.sg:GoToState("block_knockback")
	end
end
	end
end


-----------------------------[[ CRT Charge The Shield ]]----------------------------
local function ChargeTheShield()

end

-----------------------------[[ On Hit Normal ]]----------------------------
local MY_CHANCE_A = 0.2
local MY_CHANCE_B = 0.3
local MY_CHANCE_C = 0.7
local function CriticalHitNormal(inst, data)
local myvictim =  data.target
	if inst:HasTag("InNormalMode") then
		--- Lv 0 + UP --- Low Level
		if inst.schwarzkirsche_level < 3750 then
			if math.random() < MY_CHANCE_A then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_sparks_fx_1").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-10)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 10
		elseif inst.schwarzkirsche_level >= 3750 and inst.schwarzkirsche_level < 7500 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_sparks_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-20)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 20
		elseif inst.schwarzkirsche_level >= 7500 and inst.schwarzkirsche_level < 11250 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_sparks_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-40)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 30
		elseif inst.schwarzkirsche_level >= 11250 and inst.schwarzkirsche_level < 15000 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_sparks_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-60)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 40
		elseif inst.schwarzkirsche_level >= 15000 and inst.schwarzkirsche_level < 18750 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_sparks_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-80)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 50
		elseif inst.schwarzkirsche_level >= 18750 and inst.schwarzkirsche_level < 22500 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_sparks_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-100)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 60
		elseif inst.schwarzkirsche_level >= 22500 and inst.schwarzkirsche_level < 26250 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_sparks_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-120)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 70
		elseif inst.schwarzkirsche_level >= 26250 and inst.schwarzkirsche_level < 30375 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_sparks_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-140)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 80
		elseif inst.schwarzkirsche_level >= 30375 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_sparks_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-170)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
	end
	
	
	
	end
--[[if myvictim:IsValid() then
	   SpawnPrefab("sch_sparks_fx_1"):AlignToTarget(myvictim, inst)
	end]]
end

-----------------------------[[ On Hit Rage ]]----------------------------
local function CriticalHitRage(inst, data)
local myvictim =  data.target
	if inst:HasTag("InRageMode") then
		--- Lv 0 + UP --- Low Level
		if inst.schwarzkirsche_level < 3750 then
			if math.random() < MY_CHANCE_A then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_explode_fx_1").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-30)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 10
		elseif inst.schwarzkirsche_level >= 3750 and inst.schwarzkirsche_level < 7500 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_explode_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-50)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 20
		elseif inst.schwarzkirsche_level >= 7500 and inst.schwarzkirsche_level < 11250 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_explode_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-80)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 30
		elseif inst.schwarzkirsche_level >= 11250 and inst.schwarzkirsche_level < 15000 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_explode_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-110)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 40
		elseif inst.schwarzkirsche_level >= 15000 and inst.schwarzkirsche_level < 18750 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_explode_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-140)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 50
		elseif inst.schwarzkirsche_level >= 18750 and inst.schwarzkirsche_level < 22500 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_explode_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-170)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 60
		elseif inst.schwarzkirsche_level >= 22500 and inst.schwarzkirsche_level < 26250 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_explode_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-200)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 70
		elseif inst.schwarzkirsche_level >= 26250 and inst.schwarzkirsche_level < 30375 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_explode_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-230)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
		--- Lv 80
		elseif inst.schwarzkirsche_level >= 30375 then
			if math.random() < MY_CHANCE_B then
				if not (myvictim:HasTag("smashable") or myvictim:HasTag("wall") or myvictim:HasTag("engineering")) then
					SpawnPrefab("sch_explode_fx_2").Transform:SetPosition(myvictim:GetPosition():Get())
				end
				myvictim.components.health:DoDelta(-250)
				---- Crit effects
				if not inst.CritChargeInEffects then
					inst.components.schcriticalhit:DoDelta(0.5)
				end
				local fx1 = SpawnPrefab("tauntfire_fx") 
				local fx2 = SpawnPrefab("sch_elec_charged_fx") 
					  fx1.Transform:SetScale(0.5, 0.5, 0.5) 
					  fx2.Transform:SetScale(0.75, 0.75, 0.75)
				if (fx1 or fx2) then
					if (fx1:IsValid() or fx2:IsValid()) then
						fx1.entity:SetParent(inst.entity)
						fx2.entity:SetParent(inst.entity)
					end	
				end
			end
	end


	end
--[[if myvictim:IsValid() then
	   SpawnPrefab("sch_explode_fx_1"):AlignToTarget(myvictim, inst)
	end]]
end
-----------------------------[[ SHIELD CHARGED BY CRITICALHIT ]]----------------------------
---- Also do AOE when enemy is near
local function ChargedShield(inst, data)



end

-----------------------------[[ RAGE DEFENSE/SHIELD ]]----------------------------
local SHIELD_COOLDOWN = 0.75 
local function RageDefense(inst, data)
if inst:HasTag("InRageMode") and not inst.ShieldIsOn then
	if GetTime() - inst.LastShieldTime > SHIELD_COOLDOWN then
		local fx_1 = SpawnPrefab("sch_stalker_shield_rage")
		      fx_1.Transform:SetScale(0.30, 0.30, 0.30)
			  fx_1.Transform:SetPosition(inst:GetPosition():Get())
		local fx_2 = SpawnPrefab("sch_fire_ring") 
			  fx_2.Transform:SetScale(0.5, 0.5, 0.5)
		      fx_2.Transform:SetPosition(inst:GetPosition():Get())
		inst.LastShieldTime = GetTime() ---- Loop
	end 
end
end

-----------------------------[[ DEFENSE/SHIELD ]]----------------------------
---------- Shield Not Allowed at FullMoon
local function DarkShield(inst, data)
if not inst.FullMoonPriority then
if inst.DarkShieldIsOn then
	if not inst.ShieldCooldown then
		inst.ShieldCooldown = true
			inst.ShieldIsOn = true
			inst.components.health:SetInvincible(true)
local fx = SpawnPrefab("sch_darkshield_fx")
		fx.entity:SetParent(inst.entity)
if inst.components.rider ~= nil and inst.components.rider:IsRiding() then
	fx.Transform:SetScale(2, 2, 2)
		else fx.Transform:SetScale(0.8, 0.8, 0.8)	end
			fx.Transform:SetPosition(0, 0.2, 0)
local fx_hitanim = function()
		fx.AnimState:PlayAnimation("hit")
			fx.AnimState:PushAnimation("idle_loop")	end
				fx:ListenForEvent("blocked", fx_hitanim, inst)
-------------------[[ SHIELD DURATION ]]------------------------
local time = 20
inst:DoTaskInTime(time, function()
	fx:RemoveEventCallback("blocked", fx_hitanim, inst)
if inst:IsValid() then 
	fx.kill_fx(fx)
		inst.components.talker:Say("[Shield is Deactivate]\n[Need Sleep To Charge my Shield]")
				inst.DarkShieldIsOn = false
						inst.ShieldIsOn = false
						inst.components.health:SetInvincible(false)
			end end)
----------------------------------------------------------------
		end
	end
if inst.components.schshielder.current < 1 then
		inst.DarkShieldIsOn = true
		inst.ShieldIsCharging = true
		inst.ShieldFullyCharged = false
		end
	end
end

---------- Sparks Shield Not Allowed at FullMoon
local function PhaseShield(inst, data)
if not inst.FullMoonPriority then
if not inst.ShieldIsCharging then
if inst.components.schshielder then
		inst.components.schshielder:DoDelta(-1)
			end
	local fx1 = SpawnPrefab("sch_spin_fx")  ---------- SpawnPrefab("impact")
	local fx2 = SpawnPrefab("sch_elec_charged_fx")
		if (fx1 or fx2) then
			if (fx1:IsValid() or fx2:IsValid()) then
				fx1.entity:SetParent(inst.entity)
				fx2.entity:SetParent(inst.entity)
				inst:DoTaskInTime(0.25, function(inst) local fx2 = SpawnPrefab("sch_elec_charged_fx") fx2.entity:SetParent(inst.entity) fx2.Transform:SetScale(0.75, 0.75, 0.75) end)
				inst:DoTaskInTime(1, function(inst) local fx2 = SpawnPrefab("sch_elec_charged_fx") fx2.entity:SetParent(inst.entity) fx2.Transform:SetScale(0.75, 0.75, 0.75) end)
				inst:DoTaskInTime(1.5, function(inst) local fx2 = SpawnPrefab("sch_elec_charged_fx") fx2.entity:SetParent(inst.entity) fx2.Transform:SetScale(0.75, 0.75, 0.75) end)
			end	
		end
	fx1.Transform:SetScale(0.75, 0.75, 0.75)
	fx2.Transform:SetScale(0.75, 0.75, 0.75)
local other = data.attacker
if other and 
	other.components.burnable and 
		other.components.health and not 
			other:HasTag("thorny") and not 
				other:HasTag("shadowcreature") and 
					other.components.combat then
            other.components.health:DoDelta(-10)
SpawnPrefab("sparks").Transform:SetPosition(other:GetPosition():Get())
		end
		--inst:RemoveEventCallback("attacked", PhaseShield)
		end
	end
end

local function CheckMode(inst, data)

end

local function CheckShield(inst, data)
----------------- Regen
---- Sleeping
if not (inst.sg:HasStateTag("walking") or inst.sg:HasStateTag("moving")) and inst.sg:HasStateTag("sleeping") then
		inst.SchShieldRegen = true
	end
---- Moving
if (inst.sg:HasStateTag("walking") or inst.sg:HasStateTag("moving")) and not inst.sg:HasStateTag("sleeping") then
		inst.SchShieldRegen = false
	end
----------------- Shield
--[[
if inst.FullMoonPriority and not inst.SchwarzNormalMode then
	if not inst:HasTag("FullArmor") then
		
	end
    inst.components.health:SetAbsorptionAmount(1)

  else ]]
--if inst.EnergyShieldIsOn then ---------- Only Active in every next Phase or After sg sleeping [if you dc or reconnect from game, this function not enable by default]
if inst.components.schshielder.current < 1 then ---- Now you can use command GodMode
	inst.ShieldIsCharging = true
	inst.ShieldFullyCharged = false
	if inst.ShieldIsOn and not inst.FullMoonPriority then
		--inst.components.health:SetAbsorptionAmount(1)
		 --inst.components.health:SetInvincible(true)
		 inst:AddTag("OnShield")
	end
	if not inst.ShieldIsOn and not inst.FullMoonPriority then
		--inst.components.health:SetAbsorptionAmount(0)
		 --inst.components.health:SetInvincible(false)
		 inst:RemoveTag("OnShield")
	end
end
----- Shield Lv. (DEF)
--- If you relogin then you Must sleep (the character) till the (shield) charge full then the shield can be activated if the last saved < 10.
--- (After relogin) You also grant free shield after get 2-3 hit.
if inst.schwarzkirsche_level >= 0 and inst.schwarzkirsche_level < 3750 then
if inst.components.schshielder.current >= 10 then
		inst.ShieldFullyCharged = true  ---- Keep it "on" (also at fullmoon)till the carge depleted
		inst.ShieldIsCharging = false
		inst.ShieldCooldown = false
		inst.DarkShieldIsOn = false
		inst.ShieldIsOn = false
		inst.components.health:SetAbsorptionAmount(0.55)
	end
		
		if inst.FullMoonPriority and not inst.SchwarzNormalMode then --- at fullmoon then change it to 1 but not reduce the charge
				inst.components.health:SetAbsorptionAmount(1) ---- ShieldFullyCharged still "on" but changed to (1)
			elseif not inst.FullMoonPriority and inst.SchwarzNormalMode then --- continue use the charge
				---- Continue the Last saved (current) Shield --- If (0.55) then (0.55) and not (1) like at full moon
				if inst.ShieldFullyCharged then
					inst.components.health:SetAbsorptionAmount(0.55)
				elseif not inst.ShieldFullyCharged then -- If the amount of last charge is 0 then keep it 0 
					inst.components.health:SetAbsorptionAmount(0)
				end
		end	


elseif inst.schwarzkirsche_level >= 3750 and inst.schwarzkirsche_level < 11250 then
if inst.components.schshielder.current >= 30 then
		inst.ShieldFullyCharged = true  ---- Keep it "on" (also at fullmoon)till the carge depleted
		inst.ShieldIsCharging = false
		inst.ShieldCooldown = false
		inst.DarkShieldIsOn = false
		inst.ShieldIsOn = false
		inst.components.health:SetAbsorptionAmount(0.65)
	end
		
		if inst.FullMoonPriority and not inst.SchwarzNormalMode then --- at fullmoon then change it to 1 but not reduce the charge
				inst.components.health:SetAbsorptionAmount(1) ---- ShieldFullyCharged still "on" but changed to (1)
			elseif not inst.FullMoonPriority and inst.SchwarzNormalMode then --- continue use the charge
				---- Continue the Last saved (current) Shield --- If (0.55) then (0.55) and not (1) like at full moon
				if inst.ShieldFullyCharged then
					inst.components.health:SetAbsorptionAmount(0.65)
				elseif not inst.ShieldFullyCharged then -- If the amount of last charge is 0 then keep it 0 
					inst.components.health:SetAbsorptionAmount(0)
				end
		end		
		
		
elseif inst.schwarzkirsche_level >= 11250 and inst.schwarzkirsche_level < 18750 then
if inst.components.schshielder.current >= 50 then
		inst.ShieldFullyCharged = true  ---- Keep it "on" (also at fullmoon)till the carge depleted
		inst.ShieldIsCharging = false
		inst.ShieldCooldown = false
		inst.DarkShieldIsOn = false
		inst.ShieldIsOn = false
		inst.components.health:SetAbsorptionAmount(0.75)
	end

		if inst.FullMoonPriority and not inst.SchwarzNormalMode then --- at fullmoon then change it to 1 but not reduce the charge
				inst.components.health:SetAbsorptionAmount(1) ---- ShieldFullyCharged still "on" but changed to (1)
			elseif not inst.FullMoonPriority and inst.SchwarzNormalMode then --- continue use the charge
				---- Continue the Last saved (current) Shield --- If (0.55) then (0.55) and not (1) like at full moon
				if inst.ShieldFullyCharged then
					inst.components.health:SetAbsorptionAmount(0.75)
				elseif not inst.ShieldFullyCharged then -- If the amount of last charge is 0 then keep it 0 
					inst.components.health:SetAbsorptionAmount(0)
				end
		end	


elseif inst.schwarzkirsche_level >= 18750 and inst.schwarzkirsche_level < 26250 then
if inst.components.schshielder.current >= 80 then
		inst.ShieldFullyCharged = true  ---- Keep it "on" (also at fullmoon)till the carge depleted
		inst.ShieldIsCharging = false
		inst.ShieldCooldown = false
		inst.DarkShieldIsOn = false
		inst.ShieldIsOn = false
		inst.components.health:SetAbsorptionAmount(0.85)
	end
	
		if inst.FullMoonPriority and not inst.SchwarzNormalMode then --- at fullmoon then change it to 1 but not reduce the charge
				inst.components.health:SetAbsorptionAmount(1) ---- ShieldFullyCharged still "on" but changed to (1)
			elseif not inst.FullMoonPriority and inst.SchwarzNormalMode then --- continue use the charge
				---- Continue the Last saved (current) Shield --- If (0.55) then (0.55) and not (1) like at full moon
				if inst.ShieldFullyCharged then
					inst.components.health:SetAbsorptionAmount(0.85)
				elseif not inst.ShieldFullyCharged then -- If the amount of last charge is 0 then keep it 0 
					inst.components.health:SetAbsorptionAmount(0)
				end
		end	
		
		
elseif inst.schwarzkirsche_level >= 26250 then
if inst.components.schshielder.current >= 100 then
		inst.ShieldFullyCharged = true  ---- Keep it "on" (also at fullmoon)till the carge depleted
		inst.ShieldIsCharging = false
		inst.ShieldCooldown = false
		inst.DarkShieldIsOn = false
		inst.ShieldIsOn = false
		inst.components.health:SetAbsorptionAmount(0.95)
	end
	
		if inst.FullMoonPriority and not inst.SchwarzNormalMode then --- at fullmoon then change it to 1 but not reduce the charge
				inst.components.health:SetAbsorptionAmount(1) ---- ShieldFullyCharged still "on" but changed to (1)
			elseif not inst.FullMoonPriority and inst.SchwarzNormalMode then --- continue use the charge
				---- Continue the Last saved (current) Shield --- If (0.55) then (0.55) and not (1) like at full moon
				if inst.ShieldFullyCharged then
					inst.components.health:SetAbsorptionAmount(0.95)
				elseif not inst.ShieldFullyCharged then -- If the amount of last charge is 0 then keep it 0 
					inst.components.health:SetAbsorptionAmount(0)
				end
		end	
		
			end
--		end
--	end
end
----------------------------[[	SHADOW	]]-----------------------------
local function DoEffects(pet)
	local x, y, z = pet.Transform:GetWorldPosition()
		SpawnPrefab("shadow_despawn").Transform:SetPosition(x, y, z)
		SpawnPrefab("statue_transition_2").Transform:SetPosition(x, y, z)
end
local function GemsFX(pet)
	local x, y, z = pet.Transform:GetWorldPosition()
		SpawnPrefab("lucy_transform_fx").Transform:SetPosition(x, y, z)
end
local function KillPet(pet)
if pet.components.health then
		pet.components.health:Kill()
	end
end
local function OnSpawnPet(inst, pet)
    if pet:HasTag("LuxuryGems") then
		GemsFX(pet)
	end
    if pet:HasTag("schshadow") then
        --Delayed in case we need to relocate for migration spawning
        pet:DoTaskInTime(0, DoEffects)
        if not (inst.components.health:IsDead() or inst:HasTag("playerghost")) then
            inst.components.sanity:AddSanityPenalty(pet, TUNING.SHADOWWAXWELL_SANITY_PENALTY[string.upper(pet.prefab)])
            inst:ListenForEvent("onremove", inst._onpetlost, pet)
        elseif pet._killtask == nil then
            pet._killtask = pet:DoTaskInTime(math.random(), KillPet)
        end
    elseif inst._OnSpawnPet ~= nil then
        inst:_OnSpawnPet(pet)
    end
end
local function OnDespawnPet(inst, pet)
if pet:HasTag("schshadow") then
	DoEffects(pet)
        pet:Remove()
elseif inst._OnDespawnPet ~= nil then
        inst:_OnDespawnPet(pet)
    end
end
-------------------------------[[ Ultimate Awakening ]]------------------------

local function MorphUpPiko(inst, dofx)
    inst.PIko2ndState = "UP"
	inst:AddTag("fastbuilder")
	inst:AddTag("valkyrie")
	inst.components.builder.science_bonus = 1
		inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED*1.3    
		inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED*1.3 
	print("Schwarz : 2nd Form")
end

local function MorphNoPiko(inst, dofx)
    inst.PIko2ndState = "NO"
end

local function CanMorph(inst)

    if inst.PIko2ndState ~= "NO" then -- or not TheWorld.state.isfullmoon then
        return false
    end

    local inventory = inst.components.inventory

    local canUP = true

    for i = 1, inventory:GetNumSlots() do
        local item = inventory:GetItemInSlot(i)
        if item == nil then
            return false
        end

        canUP = canUP and item.prefab == "sch_dead_gems"

        if not canUP then
            return false
        end
    end

    return canUP
end

local function MorphPiko(inst)
    local canUP = inst:CanMorph()
    if not canUP then
        return
    end

    local inventory = inst.components.inventory
    for i = 1, inventory:GetNumSlots() do
        inventory:RemoveItem(inventory:GetItemInSlot(i)):Remove()
    end

	MorphUpPiko(inst, true)
end

local function CheckForMorph(inst)
    local piko2nd = inst:CanMorph()
    if piko2nd then
        if inst.MorphTask then
            inst.MorphTask:Cancel()
            inst.MorphTask = nil
        end
        inst.MorphTask = inst:DoTaskInTime(2, function(inst)
            inst.sg:GoToState("start_tranform_ultimate_awakening")
        end)
    end
end

----------------------------------------------------------------------------
-----[[ Cancel All Task Because when is "Dead" [Ghost skins] not "Working" ]]-----
local function CancelAllTask(inst, data)
------------------------------------------
    if (inst.Treasure_on or 
		inst.Treasure_Revealed or
		inst.OnThirsty or 
		inst.OnThirsty or
		inst.CheckShield or
		inst.OnFullMoonMode or 
		inst.OnWetStart or 
		inst.UpdateSkin or 
		inst.OnBlooming or 
		inst.CheckBloomLevels or 
		inst.OnRageMode or 
		inst.UpdateDamagePerHungerChange) ~= nil then
--[[ "1" ]]		inst.Treasure_on:Cancel()
				inst.Treasure_on = nil
--[[ "2" ]]		inst.Treasure_Revealed:Cancel()
				inst.Treasure_Revealed = nil
--[[ "3" ]]		inst.OnThirsty:Cancel()
				inst.OnThirsty = nil
--[[ "4" ]]		inst.CheckShield:Cancel()
				inst.CheckShield = nil
--[[ "5" ]]		inst.OnFullMoonMode:Cancel()
				inst.OnFullMoonMode = nil
--[[ "6" ]]		inst.OnWetStart:Cancel()
				inst.OnWetStart = nil
--[[ "7" ]]		inst.UpdateSkin:Cancel()
				inst.UpdateSkin = nil
--[[ "8" ]]		inst.OnBlooming:Cancel()
				inst.OnBlooming = nil
--[[ "9" ]]		inst.CheckBloomLevels:Cancel()
				inst.CheckBloomLevels = nil
--[[ "10" ]]	inst.OnRageMode:Cancel()
				inst.OnRageMode = nil
--[[ "11" ]]	inst.UpdateDamagePerHungerChange:Cancel()
				inst.UpdateDamagePerHungerChange = nil
    end
		print("Schwarzkirsche is 'dead' : All Schwarzkirsche Task Cancelled : All Components are Disabled")
end

local function ResumeAllTask(inst, data)
if not inst.components.health:IsDead() or 
			inst.sg:HasStateTag("nomorph") or 
				inst:HasTag("playerghost") then
				print("Ghost skins Animated before Task Resumed")
				inst:DoTaskInTime(1, function() print("Schwarzkirsche : Ghost is Animated") end)
				inst:DoTaskInTime(2, function() print("Schwarzkirsche : Prepare to Activate All Task") end)
				inst:DoTaskInTime( 3, function() 
--[[ "1" ]]		inst.Treasure_on = inst:DoPeriodicTask(0, Treasure_start)
--[[ "2" ]]		inst.Treasure_Revealed = inst:DoPeriodicTask(0, Treasure_Revealed)
--[[ "3" ]]		inst.OnThirsty = inst:DoPeriodicTask(0, On_Thirsty)
--[[ "4" ]]		inst.CheckShield = inst:DoPeriodicTask(0, CheckShield)
--[[ "5" ]]		inst.OnFullMoonMode = inst:DoPeriodicTask(0, OnFullMoonMode)
--[[ "6" ]]		inst.OnWetStart = inst:DoPeriodicTask(0, OnWetStart)
--[[ "7" ]]		inst.UpdateSkin = inst:DoPeriodicTask(0, UpdateSkin)
--[[ "8" ]]		inst.OnBlooming = inst:DoPeriodicTask(1, OnBlooming)
--[[ "9" ]]		inst.CheckBloomLevels = inst:DoPeriodicTask(0, CheckBloomLevels)
--[[ "10" ]]	inst.UpdateDamagePerHungerChange = inst:DoPeriodicTask(0, UpdateDamagePerHungerChange)
--[[ "11" ]]	inst.OnRageMode = inst:DoPeriodicTask(0, OnRageMode)
			print("Schwarzkirsche is now 'alive' : All Schwarzkirsche Task Resumed : All Components are Enabled")
		end)
	end
end

----------------------------------------------------------------------------
local function OnNewState(inst)
    if inst._wasnomorph ~= inst.sg:HasStateTag("nomorph") then
        inst._wasnomorph = not inst._wasnomorph
        if not inst._wasnomorph then
            UpdateDamagePerHungerChange(inst)
        end
    end
end

local function onbecamehuman(inst)
    if inst._wasnomorph == nil then
        inst.strength = "midverage"
        inst._wasnomorph = inst.sg:HasStateTag("nomorph")
        inst.talksoundoverride = nil
        inst.hurtsoundoverride = nil
        inst:ListenForEvent("hungerdelta", UpdateDamagePerHungerChange)
        inst:ListenForEvent("newstate", OnNewState)
        UpdateDamagePerHungerChange(inst, nil, true)
    end
	--inst.components.locomotor:SetExternalSpeedMultiplier(inst, "schwarzkirsche_speed_mod", 1)
end

local function onbecameghost(inst)
    if inst._wasnomorph ~= nil then
        inst.strength = "midverage"
        inst._wasnomorph = nil
        inst.talksoundoverride = nil
        inst.hurtsoundoverride = nil
        inst:RemoveEventCallback("hungerdelta", UpdateDamagePerHungerChange)
        inst:RemoveEventCallback("newstate", OnNewState)
    end
	inst.CanUpdateSkin = false
	--inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "schwarzkirsche_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)
    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local function OnSaveData(inst, data)
	data.schwarzkirsche_level = inst.schwarzkirsche_level > 0 and inst.schwarzkirsche_level or nil
	data.PIko2ndState = inst.PIko2ndState
end

local function OnPreLoadData(inst, data)
if not data then return end
if data.schwarzkirsche_level ~= nil then
inst.schwarzkirsche_level = data.schwarzkirsche_level
if data.health and 
	data.health.health then 
		inst.components.health.currenthealth = data.health.health  
			end

if data.sanity and 
	data.sanity.current then 
		inst.components.sanity.current = data.sanity.current 
			end
	
if data.schshielder and 
	data.schshielder.current then 
		inst.components.schshielder.current = data.schshielder.current 
			end

	inst.components.health:DoDelta(0) 
	inst.components.sanity:DoDelta(0)
	inst.components.schshielder:DoDelta(0)
		ApplyExpLevel(inst)
	end
    if data.PIko2ndState == "UP" then
        MorphUpPiko(inst)
    end
end

local untouchables = {
	------ Heyyy please dont remove this !! stop animal abuse !! keep that little beef alive!
	babybeefalo = true,
}  
local tools = {	
	knive = true, 
	lance = true,
}
-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
	inst.MiniMapEntity:SetIcon( "schwarzkirsche.tex" )
	-- Adding Tag
	inst:AddTag("bookbuilder")
	-- Special Tag
	inst:AddTag("dodger") -- Wheeler Ability
	inst:AddTag("schcaster")
	inst:AddTag("shieldersch")
	inst:AddTag("soulcollector")
	inst:AddTag("SoulController")
	inst:AddTag("ArmoredPriest")
	inst:AddTag("myMaster")
	inst:AddTag("QueenAnimator")
	inst:AddTag("GemsMaker")
	inst:AddTag("stranger")
	inst:AddTag("schteleporter")
	inst:AddTag("schwarz")
	inst:AddTag("Schwarz")
	inst:AddTag("schwarzkirsche")
	inst:AddTag("Schwarzkirsche")
	inst:AddTag("TreasureHunter")
	inst:AddTag("ShadowMaster")
	inst:AddTag("ShadowCreator")
	inst:AddTag("ShadowLeader")
	-- Neutral/Passive Creature ..
	inst:DoTaskInTime(0, function()
		local old = inst.replica.combat.IsValidTarget
		inst.replica.combat.IsValidTarget = function(self, target)
			if target and untouchables[target.prefab] then
				return false
			end
			return old(self, target)
		end
	end)
	-- Selected weapon/item can't be equip ..
	inst:ListenForEvent("equip", function(inst, data) 
		if tools[data.item.prefab] then 
			inst:DoTaskInTime(0.5, function(inst)
				inst.components.inventory:GiveItem(data.item)
			end)
			inst.components.talker:Say("I can't use that ..", 2.5)
		end
	end)
-- Dodge
	inst:ListenForEvent("setowner", OnSetOwner)
	inst.last_dodge_time = GetTime()
	-----------------------------[[ BADGE THIRSTY ]]----------------------------
	inst._schthirstymax = net_float(inst.GUID, "_schthirstymax", "clientsetschthirstymax")
	inst._currentschthirstypercen = net_float(inst.GUID, "_currentschthirstypercen", "clientschthirstypercentchange")	
	-----------------------------[[ BADGE WARLOCK ]]----------------------------
	inst._schwarlockmax = net_float(inst.GUID, "_schwarlockmax", "clientsetschwarlockmax")
	inst._currentschwarlockpercen = net_float(inst.GUID, "_currentschwarlockpercen", "clientschwarlockpercentchange")	
	-----------------------------[[ BADGE TREASURE ]]----------------------------
	inst._schtreasuremax = net_float(inst.GUID, "_schtreasuremax", "clientsetschtreasuremax")
	inst._currentschtreasurepercen = net_float(inst.GUID, "_currentschtreasurepercen", "clientschtreasurepercentchange")	
	-----------------------------[[ BADGE SHIELDERS ]]----------------------------
	inst._schshieldermax = net_float(inst.GUID, "_schshieldermax", "clientsetschshieldermax")
	inst._currentschshielderpercen = net_float(inst.GUID, "_currentschshielderpercen", "clientschshielderpercentchange")
	-----------------------------[[ BADGE BLOOMLEVEL ]]----------------------------
	inst._schbloomlevelmax = net_float(inst.GUID, "_schbloomlevelmax", "clientsetschbloomlevelmax")
	inst._currentschbloomlevelpercen = net_float(inst.GUID, "_currentschbloomlevelpercen", "clientschbloomlevelpercentchange")
	-----------------------------[[ BADGE CRITICALHIT ]]----------------------------
	inst._schcriticalhitmax = net_float(inst.GUID, "_schcriticalhitmax", "clientsetschcriticalhitmax")
	inst._currentschcriticalhitpercen = net_float(inst.GUID, "_currentschcriticalhitpercen", "clientschcriticalhitpercentchange")
	-----------------------------------------------------------------------------
	if not TheWorld.ismastersim then
		inst:ListenForEvent("clientschthirstypercentchange", ClientSchThirstyPercentChange)
		inst:ListenForEvent("clientsetschthirstymax", ClientSetSchThirstyMax)
		inst:ListenForEvent("clientschshielderpercentchange", ClientSchShielderPercentChange)
		inst:ListenForEvent("clientsetschshieldermax", ClientSetSchShielderMax)
		inst:ListenForEvent("clientschwarlockpercentchange", ClientSchWarlockPercentChange)
		inst:ListenForEvent("clientsetschwarlockmax", ClientSetSchWarlockMax)
		inst:ListenForEvent("clientschtreasurepercentchange", ClientSchTreasurePercentChange)
		inst:ListenForEvent("clientsetschtreasuremax", ClientSetSchTreasureMax)
		inst:ListenForEvent("clientschbloomlevelpercentchange", ClientSchBloomlevelPercentChange)
		inst:ListenForEvent("clientsetschbloomlevelmax", ClientSetSchBloomlevelMax)
		inst:ListenForEvent("clientschcriticalhitpercentchange", ClientSchCriticalhitPercentChange)
		inst:ListenForEvent("clientsetschcriticalhitmax", ClientSetSchCriticalhitMax)
	end	
----------------------------------------------------------------	
    inst:AddComponent("reticule")
    inst.components.reticule.targetfn = ReticuleTargetFn
    inst.components.reticule.ease = true
----------------------------------------------------------------	
	inst:AddComponent("keyhandler")
	inst.components.keyhandler:AddActionListener("schwarzkirsche", TUNING.SCHWARZKIRSCHE.KEY_1, "SHOWLEVEL")
	inst.components.keyhandler:AddActionListener("schwarzkirsche", TUNING.SCHWARZKIRSCHE.KEY_2, "SHOWSTATUS")
	inst.components.keyhandler:AddActionListener("schwarzkirsche", TUNING.SCHWARZKIRSCHE.KEY_3, "CHARGEWARLOCK")
	inst.components.keyhandler:AddActionListener("schwarzkirsche", TUNING.SCHWARZKIRSCHE.KEY_4, "REVEALTHETREASURE")
	inst.components.keyhandler:AddActionListener("schwarzkirsche", TUNING.SCHWARZKIRSCHE.KEY_5, "BOOKSKILLS")
	inst.components.keyhandler:AddActionListener("schwarzkirsche", TUNING.SCHWARZKIRSCHE.KEY_6, "PIKOCOMMAND")
---------------------------------------------------------------- 
-- Data[0] : Key Classified
--[[ Next Update
	OverrideOnRemoveEntity(inst)
	inst.AttachSchkeyClassified = AttachClassified
	inst.DetachSchkeyClassified = DetachClassified
	]]
end
-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
-- choose which sounds this character will play
-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
--inst.talker_path_override = "dontstarve_DLC001/characters/"
	inst.soundsname = "willow"
	inst.components.talker.fontsize = 28
	inst.components.talker.colour = Vector3(1, 0.8, 0.95, 1)
	--inst.components.talker.colour = Vector3(40, 40, 50, 0.75)
-- Lastest Components ----------- Upcomng update 
	inst:AddComponent("schwarzkirsche")
-- Data[0] : Key Classified
--[[ Next Update
	inst.schwarzkirsche_key_classified = SpawnPrefab("schwarzkirsche_key_classified")
	inst:AddChild(inst.schwarzkirsche_key_classified) ]]
-- Data[1] : Load/Spawn/Respawn
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
-- Data[2] : Data Level
	inst.OnSave = OnSaveData
	inst.OnPreLoad = OnPreLoadData
-- Data[3] : Data Hunger Damage
    inst.strength = "midverage"
    inst._wasnomorph = nil
    inst.talksoundoverride = nil
    inst.hurtsoundoverride = nil
	--UpdateDamagePerHungerChange(inst)
	--inst:ListenForEvent("hungerdelta", UpdateDamagePerHungerChange)
	inst.UpdateDamagePerHungerChange = inst:DoPeriodicTask(0, UpdateDamagePerHungerChange)
-- Data[4] : Data Health Damage
	--OnRageMode(inst)
	--inst:ListenForEvent("healthdelta", OnRageMode)
	inst.OnRageMode = inst:DoPeriodicTask(0, OnRageMode)
-- Data[5] : Blooming
	inst.usedtrails = {}
    inst.availabletrails = {}
    for i = 1, MAX_TRAIL_VARIATIONS do
        table.insert(inst.availabletrails, i)
    end
    inst._blooming = false
    inst.DoTrail = DoTrail
    inst.StartBlooming = StartBlooming
    inst.StopBlooming = StopBlooming
    inst.OnEntityWake = ForestOnEntityWake
    inst.OnEntitySleep = ForestOnEntitySleep
	inst.OnBlooming = inst:DoPeriodicTask(1, OnBlooming)
	inst.CheckBloomLevels = inst:DoPeriodicTask(0, CheckBloomLevels)
	inst:ListenForEvent("schbloomleveldelta", OnBloomingStart)
    --StartBlooming(inst)
-- Stats
	-- Temp (Custom)
--	inst.components.temperature.mintemp = 10
	inst.components.temperature.inherentinsulation = 5
	inst.components.temperature.inherentsummerinsulation = 5
	-- Health
	local percent = inst.components.health:GetPercent()
	inst.components.health:SetMaxHealth(100)
    inst.components.health:SetPercent(percent)
--  inst.components.health:SetAbsorptionAmount(0)
	-- Hunger
    local hunger_percent = inst.components.hunger:GetPercent()
	inst.components.hunger:SetMax(300)
    inst.components.hunger:SetPercent(hunger_percent)
	inst.components.hunger:SetKillRate(1.25)
    inst.components.hunger:SetRate(TUNING.WILSON_HUNGER_RATE * TUNING.WARLY_HUNGER_RATE_MODIFIER)
	-- Sanity
	local sanity_percent = inst.components.sanity:GetPercent()
	inst.components.sanity:SetMax(100)
    inst.components.sanity:SetPercent(sanity_percent)
	inst.components.sanity.custom_rate_fn = sanityfn
	inst.components.sanity.rate_modifier = TUNING.WILLOW_SANITY_MODIFIER
	inst.components.sanity.neg_aura_mult = 0.05 -- When near evil flower or monster
	inst.components.sanity.night_drain_mult = 0.05 -- Drained at dusk and night -- i think so
	-- Eater
	inst.components.eater:SetOnEatFn(ExpFoods)
	inst.components.eater.stale_hunger = TUNING.WICKERBOTTOM_STALE_FOOD_HUNGER
    inst.components.eater.stale_health = TUNING.WICKERBOTTOM_STALE_FOOD_HEALTH
    inst.components.eater.spoiled_hunger = TUNING.WICKERBOTTOM_SPOILED_FOOD_HUNGER
    inst.components.eater.spoiled_health = TUNING.WICKERBOTTOM_SPOILED_FOOD_HEALTH
	-- Builder (Bonus/Not)
	inst.components.builder.science_bonus = 0
	inst.components.builder.magic_bonus = 1
	-- Normal mode -- can't eat monster meat!
	inst.components.eater.strongstomach = false 
	-- Combat -- Damage multiplier (optional)
    inst.components.combat.damagemultiplier = 1.5
	inst.components.combat:SetAttackPeriod(0.5)
	-- Speed
	inst.components.locomotor.walkspeed = TUNING.WILSON_WALK_SPEED*1.25    
	inst.components.locomotor.runspeed = TUNING.WILSON_RUN_SPEED*1.25 
	-- Drop Item on death
--	inst.components.inventory.dropondeath = false
-- Adding Level (USAGE FOR : UPGRADE HEALTH/SANITY)
	inst.schwarzkirsche_level = 0
-- Adding Special Components
	inst:AddComponent("schcastspells")
	-- Treasure (REGEN ON WALK ONLY)
	inst:AddComponent("schtreasure")
	inst.components.schtreasure:SetMax(100)
	inst.components.schtreasure:SetPercent(0.2)
	-- Exp Level (STATS FOR SHIELD)
	inst:AddComponent("schbloomlevel")
	inst.components.schbloomlevel:SetMax(200)
	inst.components.schbloomlevel:SetPercent(0)
	-- Warlock (USAGE FOR CASTING SPELLS)
	inst:AddComponent("schwarlock")
	inst.components.schwarlock:SetMax(300)
	inst.components.schwarlock:SetPercent(0.5)
	-- Shield (-1 PER HIT & ABSORB DAMAGE)
	inst:AddComponent("schshielder")
	inst.components.schshielder:SetMax(10)
	-- Thirsty (USAGE FOR DODGE/JUMP/BOOST)
	inst:AddComponent("schthirsty")
	inst.components.schthirsty:SetMax(100)
	inst.components.schthirsty:SetPercent(0.5)
	-- Critical Hit (GRANT SHIELD TO ABSORB 100% DAMAGE cd 2)
	inst:AddComponent("schcriticalhit")
	inst.components.schcriticalhit:SetMax(100)
	inst.components.schcriticalhit:SetPercent(0)
-- Task 
	inst.LastShieldTime = GetTime()
	inst.SchBloomRegen = true
	inst.CanUpdateSkin = true
	inst.EnergyShieldIsOn = true
	inst.ShieldIsCharging = false
	inst.Treasure_on = inst:DoPeriodicTask(0, Treasure_start)
	inst.Treasure_Revealed = inst:DoPeriodicTask(0, Treasure_Revealed)
	inst.OnThirsty = inst:DoPeriodicTask(0, On_Thirsty)
	inst.CheckShield = inst:DoPeriodicTask(0, CheckShield)
	inst.OnFullMoonMode = inst:DoPeriodicTask(0, OnFullMoonMode)
	inst.OnWetStart = inst:DoPeriodicTask(0, OnWetStart)
	inst.UpdateSkin = inst:DoPeriodicTask(0, UpdateSkin)
	inst.RemoveDodgeBuff = inst:DoPeriodicTask(0.75, RemoveDodgeBuff) --- Waiting
	--inst:DoPeriodicTask(0.01, fade)
-- Additional Components
	-- Aura Weapon
	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(5)
	inst.components.weapon:SetElectric()
	inst.components.weapon:SetRange(7)
	-- Timer
	inst:AddComponent("timer")
	-- Fuel Master
	inst:AddComponent("fuelmaster")
	inst.components.fuelmaster:SetBonusFn(GetFuelMasterBonus)
	-- FullMoon
	inst:AddComponent("werebeast")
	inst.components.werebeast:SetOnWereFn(SetWere)
	inst.components.werebeast:SetOnNormalFn(SetNormal)
	inst.components.werebeast:SetTriggerLimit(2)
	-- Can Readbook
	inst:AddComponent("reader")
	-- Small sanity gain for Allies
	inst:AddComponent("sanityaura")
	inst.components.sanityaura.aura = 0.25
	inst.components.sanityaura.aurafn = CalcSanityAura
	-- Spawn Pet
	--SpawnPikos(inst)
	if inst.components.petleash ~= nil then
	inst._OnSpawnPet = inst.components.petleash.onspawnfn
	inst._OnDespawnPet = inst.components.petleash.ondespawnfn
	inst.components.petleash:SetMaxPets(inst.components.petleash:GetMaxPets() + 7)	else
	inst:AddComponent("petleash") ------------- Total 8 Pets
	inst.components.petleash:SetMaxPets(7)	end ---- 3 Piko 3 Shadow 1 Twin 1 Gems = 8
--	inst.components.petleash:SetPetPrefab("sch_piko")
--	inst.components.petleash:SetPetPrefab("sch_shadowsch")
    inst.components.petleash:SetOnSpawnFn(OnSpawnPet)
    inst.components.petleash:SetOnDespawnFn(OnDespawnPet)
    inst._onpetlost = function(pet) inst.components.sanity:RemoveSanityPenalty(pet) end
-- Adds
	-- Character Scale
	inst.Transform:SetScale(1, 1, 1)
-- Light
	inst.entity:AddLight()
    inst.Light:Enable(false)
    inst.Light:SetRadius(7)
    inst.Light:SetFalloff(.6)
    inst.Light:SetIntensity(0.9)
    inst.Light:SetColour(40/255, 40/255, 50/255)
--- Sound
	inst.sounds = schsound
--- Event
	ApplyExpLevel(inst)
    inst._checksoulstask = nil
	inst:ListenForEvent("killed", OnKillSpawnDarkSoul)
--	inst:ListenForEvent("murdered", OnKillSpawnDarkSoul)
	inst:ListenForEvent("itemget", IsDarkSoulinInv)
	inst:ListenForEvent("itemlose", NoDarkSoulinInv)	
	inst:ListenForEvent("levelup", 	ApplyExpLevel)
    inst:ListenForEvent("gotnewitem", OnGotNewItem)
	inst:ListenForEvent("onhitother", CriticalHitRage)
	inst:ListenForEvent("onhitother", CriticalHitNormal)
	inst:ListenForEvent("onhitother", ChargeTheShield)
	inst:ListenForEvent("attacked", PhaseShield)
	inst:ListenForEvent("attacked", DarkShield)
	inst:ListenForEvent("attacked", RageDefense)
--	inst:ListenForEvent("attacked", ChargedShield)
--	inst:ListenForEvent("blocked", BlockDamage) ---- Work when dodging
	inst:ListenForEvent("attacked", OnFullMoonLifeStealer)
	inst:ListenForEvent("death", DeathPenalty)
    inst:ListenForEvent("respawnfromghost", OnRespawnforSkin)
	inst:ListenForEvent("death", CancelAllTask)
    inst:ListenForEvent("respawnfromghost", ResumeAllTask)
--	inst:ListenForEvent("equip", 	)
--	inst:ListenForEvent("unequip", 	)
--	inst:ListenForEvent("ms_respawnedfromghost", 	)
--	inst:ListenForEvent("ms_becameghost", 	)
--	inst:WatchWorldState("phase", CheckMode)
	inst:WatchWorldState("isfullmoon", OnFullMoonMode)
	inst:WatchWorldState("season", SeasonalSkin)
	inst:WatchWorldState("isautumn", SeasonalSkin)
	inst:WatchWorldState("iswinter", SeasonalSkin)
	inst:WatchWorldState("isspring", SeasonalSkin)
	inst:WatchWorldState("issummer", SeasonalSkin)
	inst:WatchWorldState("phase", SeasonalSkin)
	inst:WatchWorldState("isday", SeasonalSkin)
	inst:WatchWorldState("isdusk", SeasonalSkin)
	inst:WatchWorldState("isnight", SeasonalSkin)
--	inst:WatchWorldState("israining", )
--	inst:StopWatchingWorldState("startday", onday)  
	SeasonalSkin(inst, TheWorld.state.season)
-- my Components
	inst:ListenForEvent("schthirstydelta", ThirstyforDodge)
----------------------[[ Ultimate Awakening ]]--------------
	inst.PIko2ndState = "NO"
    inst.CanMorph = CanMorph
    inst.MorphPiko = MorphPiko
	inst:WatchWorldState("phase", CheckForMorph)
--  inst:WatchWorldState("isfullmoon", CheckForMorph)
	--[[  ---------- Up Coming Update --------------
	inst:WatchWorldState( "startday", function(inst) end )
	inst:WatchWorldState( "startdusk", function(inst) end )
	inst:WatchWorldState( "startnight", function(inst) end )
	inst:WatchWorldState( "startcaveday", function(inst) end )
	inst:WatchWorldState( "startcavedusk", function(inst) end )
	inst:WatchWorldState( "startcavenight", function(inst) end )
	]]

end

return MakePlayerCharacter("schwarzkirsche", prefabs, assets, common_postinit, master_postinit, start_inv)
