--------------------[[ ... ]]-------------------------
_G = GLOBAL
local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TUNING = GLOBAL.TUNING
local resolvefilepath = GLOBAL.resolvefilepath
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local Recipe = GLOBAL.Recipe
local TECH = GLOBAL.TECH
local ACTIONS = GLOBAL.ACTIONS
local TheInput = GLOBAL.TheInput
local ThePlayer = GLOBAL.ThePlayer
local Profile = GLOBAL.Profile
local TimeEvent = GLOBAL.TimeEvent
local State = GLOBAL.State
local TheWorld = GLOBAL.TheWorld
local BufferedAction = GLOBAL.BufferedAction
local ActionHandler = GLOBAL.ActionHandler
local EventHandler = GLOBAL.EventHandler
local EQUIPSLOTS = GLOBAL.EQUIPSLOTS
local FRAMES = GLOBAL.FRAMES
local Widget = require("widgets/widget")
local Image = require("widgets/image")
local Text = require("widgets/text")
local PlayerBadge = require("widgets/playerbadge")
local Badge = require("widgets/badge")
local containers = require("containers")
local IsServer = GLOBAL.TheNet:GetIsServer()
Recipe = GLOBAL.Recipe
TECH = GLOBAL.TECH

Assets = {
    ---------------------------[[ Common ]]----------------------------
    Asset( "IMAGE", "images/saveslot_portraits/schwarzkirsche.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/schwarzkirsche.xml" ),
    Asset( "IMAGE", "images/selectscreen_portraits/schwarzkirsche.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/schwarzkirsche.xml" ),
    Asset( "IMAGE", "images/selectscreen_portraits/schwarzkirsche_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/schwarzkirsche_silho.xml" ),
    Asset( "IMAGE", "bigportraits/schwarzkirsche.tex" ),
    Asset( "ATLAS", "bigportraits/schwarzkirsche.xml" ),
	Asset( "IMAGE", "images/map_icons/schwarzkirsche.tex" ),
	Asset( "ATLAS", "images/map_icons/schwarzkirsche.xml" ),
	Asset( "IMAGE", "images/avatars/avatar_schwarzkirsche.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_schwarzkirsche.xml" ),
	Asset( "IMAGE", "images/avatars/avatar_ghost_schwarzkirsche.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_schwarzkirsche.xml" ),
	Asset( "IMAGE", "images/avatars/self_inspect_schwarzkirsche.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_schwarzkirsche.xml" ),
	Asset( "IMAGE", "images/names_schwarzkirsche.tex" ),
    Asset( "ATLAS", "images/names_schwarzkirsche.xml" ),
	Asset( "IMAGE", "images/names_gold_schwarzkirsche.tex" ),
    Asset( "ATLAS", "images/names_gold_schwarzkirsche.xml" ),
    Asset( "IMAGE", "bigportraits/schwarzkirsche_none.tex" ),
    Asset( "ATLAS", "bigportraits/schwarzkirsche_none.xml" ),
	---------------------------[[ X Mark ]]----------------------------
	Asset( "IMAGE", "images/map_icons/sch_treasure_x_marks_spot.tex" ),
	Asset( "ATLAS", "images/map_icons/sch_treasure_x_marks_spot.xml" ),
	---------------------------[[ Skins ]]----------------------------
	Asset( "ANIM", "anim/schwarzkirsche.zip" ), --- Autumn
	Asset( "ANIM", "anim/schwarzkirsche_black.zip" ), --- Fullmoon
	Asset( "ANIM", "anim/schwarzkirsche_blue.zip" ),  --- Wet
	Asset( "ANIM", "anim/schwarzkirsche_red.zip" ), --- Rage
	Asset( "ANIM", "anim/schwarzkirsche_aquatic.zip" ), --- Winter
	Asset( "ANIM", "anim/schwarzkirsche_green.zip" ), --- Bloom
	Asset( "ANIM", "anim/schwarzkirsche_purple.zip" ),  --- Spring
	Asset( "ANIM", "anim/schwarzkirsche_sun.zip" ), --- Summer
	Asset( "ANIM", "anim/schwarzkirsche_original.zip" ),
	---------------------------[[ Skins 2nd ]]----------------------------
	Asset( "ANIM", "anim/schwarzkirsche_2nd.zip" ), --- Autumn
	Asset( "ANIM", "anim/schwarzkirsche_black_2nd.zip" ), --- Fullmoon
	Asset( "ANIM", "anim/schwarzkirsche_blue_2nd.zip" ),  --- Wet
	Asset( "ANIM", "anim/schwarzkirsche_red_2nd.zip" ), --- Rage
	Asset( "ANIM", "anim/schwarzkirsche_aquatic_2nd.zip" ), --- Winter
	Asset( "ANIM", "anim/schwarzkirsche_green_2nd.zip" ), --- Bloom
	Asset( "ANIM", "anim/schwarzkirsche_purple_2nd.zip" ),  --- Spring
	Asset( "ANIM", "anim/schwarzkirsche_sun_2nd.zip" ), --- Summer
	Asset( "ANIM", "anim/schwarzkirsche_original_2nd.zip" ),
	---------------------------[[ Badge ]]----------------------------
	Asset( "ANIM", "anim/sch_health_badge.zip" ),
	Asset( "ANIM", "anim/sch_magic_badge.zip" ),
	Asset( "ANIM", "anim/sch_shield_badge.zip" ),
	Asset( "ANIM", "anim/sch_thirsty_badge.zip" ),
	Asset( "ANIM", "anim/sch_treasure_badge.zip" ),
	Asset( "ANIM", "anim/sch_bloom_level_badge.zip" ),
	Asset( "ANIM", "anim/sch_critical_hit_badge.zip" ),
	---------------------------[[ Stuff ]]----------------------------
	---- Schwarzkirsche Arcanist Stone
	Asset( "ANIM", "anim/sch_arcanist_stone.zip" ),
	Asset("ATLAS", "images/inventoryimages/sch_arcanist_stone.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_arcanist_stone.tex"),
	---- Dark Soul
	Asset( "ANIM", "anim/sch_dark_soul.zip" ),
	Asset("ATLAS", "images/inventoryimages/sch_dark_soul.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_dark_soul.tex"),
	---- Scythe
	Asset( "ANIM", "anim/sch_scythe.zip" ),
	Asset( "ANIM", "anim/sch_swap_scythe.zip" ),
	Asset("ATLAS", "images/inventoryimages/sch_scythe.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_scythe.tex"),
	---- FX
	Asset( "ANIM", "anim/sch_portal.zip" ),
	Asset( "ANIM", "anim/sch_dark_soul_fx.zip" ),
	Asset( "ANIM", "anim/sch_spin_fx.zip" ),
	Asset( "ANIM", "anim/sch_darkshield_fx.zip" ),
	Asset( "ANIM", "anim/sch_stalker_shield.zip" ),
	Asset( "ANIM", "anim/sch_elec_charged_fx.zip" ),
	Asset( "ANIM", "anim/sch_elec_hit_fx.zip" ),
	Asset( "ANIM", "anim/sch_explode_fx.zip" ),
	Asset( "ANIM", "anim/sch_fire_ring.zip" ),
	Asset( "ANIM", "anim/sch_hit_sparks_fx.zip" ),
	Asset( "ANIM", "anim/sch_sparks_fx.zip" ),
	---- X Mark Treasure
	Asset( "ANIM", "anim/sch_treasure_x_marks_spot.zip" ),
	---- Piko Map Icon
	Asset("ATLAS", "images/map_icons/sch_piko_normal.xml"),
	Asset("IMAGE", "images/map_icons/sch_piko_normal.tex"),
	Asset("ATLAS", "images/map_icons/sch_piko_orange.xml"),
	Asset("IMAGE", "images/map_icons/sch_piko_orange.tex"),
	Asset("ATLAS", "images/map_icons/sch_piko_red.xml"),
	Asset("IMAGE", "images/map_icons/sch_piko_red.tex"),
	---- Piko : Normal
	Asset( "ANIM", "anim/sch_squirrel_build.zip" ),
	Asset( "ANIM", "anim/sch_squirrel_cheeks_build.zip" ),
	---- Piko : Orange
	Asset( "ANIM", "anim/sch_squirrel_orange_build.zip" ),
	Asset( "ANIM", "anim/sch_squirrel_orange_cheeks_build.zip" ),
	---- Piko : Red
	Asset( "ANIM", "anim/sch_squirrel_red_build.zip" ),
	Asset( "ANIM", "anim/sch_squirrel_red_cheeks_build.zip" ),
	----- Piko : Build
	Asset( "ANIM", "anim/sch_ds_squirrel_basic.zip" ),
	---- Tea Tree Piko
	Asset("ANIM", "anim/sch_teatree_nut.zip" ),
	Asset("ATLAS", "images/inventoryimages/sch_teatree_piko.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_teatree_piko.tex"),
	Asset("ATLAS", "images/inventoryimages/sch_teatree_piko_cooked.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_teatree_piko_cooked.tex"),
	---- Golden Teatree nut
	Asset("ATLAS", "images/map_icons/sch_golden_teatree_nut.xml"),
	Asset("IMAGE", "images/map_icons/sch_golden_teatree_nut.tex"),
	Asset("ATLAS", "images/inventoryimages/sch_golden_teatree_nut.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_golden_teatree_nut.tex"),
	---- Container
	Asset( "ANIM", "anim/sch_ui_chest_3x2.zip" ),
	Asset( "ANIM", "anim/sch_ui_chest_5x5.zip" ),
	Asset( "ANIM", "anim/sch_ui_oneslot_1x1.zip" ),
	---- Sound
	Asset("SOUNDPACKAGE", "sound/dontstarve_DLC003.fev"), 
	Asset("SOUND", "sound/DLC003_sfx.fsb"), 
	Asset("SOUNDPACKAGE", "sound/wheeler.fev"), 
	Asset("SOUND", "sound/wheeler.fsb"), 
	---- Recipe Tab
	Asset( "IMAGE", "images/sch_tabs.tex" ),
    Asset( "ATLAS", "images/sch_tabs.xml" ),
	Asset( "IMAGE", "images/sch_adv_tabs.tex" ),
    Asset( "ATLAS", "images/sch_adv_tabs.xml" ),
	---- Other
    Asset("ANIM", "anim/sch_tentacle_arm.zip"),
    Asset("ANIM", "anim/sch_tentacle_arm_black_build.zip"),
	---- Stuff
    Asset("ANIM", "anim/sch_hat.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_hat.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_hat.tex"),
	---- Dress (Armor)
    Asset("ANIM", "anim/sch_dress_1.zip"),
    Asset("ATLAS", "images/inventoryimages/sch_dress_1.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_dress_1.tex"),
    Asset("ANIM", "anim/sch_dress_2.zip"),
    Asset("ATLAS", "images/inventoryimages/sch_dress_2.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_dress_2.tex"),
	---- Hat (Helmet)
    Asset("ANIM", "anim/sch_hat_crown.zip"),
    Asset("ANIM", "anim/sch_swap_hat_crown.zip"), 
    Asset("ATLAS", "images/inventoryimages/sch_hat_crown.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_hat_crown.tex"),
	---- Other Stuff : BRS
	Asset("ANIM", "anim/sch_blade_1.zip"),
	Asset("ANIM", "anim/sch_swap_blade_1.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_blade_1.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_blade_1.tex"),
	Asset("ANIM", "anim/sch_blade_2.zip"),
	Asset("ANIM", "anim/sch_swap_blade_2.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_blade_2.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_blade_2.tex"),
	---- Other things like Gems or Stone
	Asset("ANIM", "anim/sch_gems.zip"),
	Asset("IMAGE", "images/inventoryimages/sch_gems.tex"),
	Asset("ATLAS", "images/inventoryimages/sch_gems.xml"),
	---- Game Stuff (Modified)
    Asset("ANIM", "anim/sch_compass.zip"),
    Asset("ANIM", "anim/sch_swap_compass.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_compass.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_compass.tex"),
	---- Maid Dress
    Asset("ANIM", "anim/sch_dress_3.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_dress_3.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_dress_3.tex"),
	---- Lantern
    Asset("ANIM", "anim/sch_redlantern.zip"),
    Asset("ANIM", "anim/sch_swap_redlantern.zip"),
	Asset( "IMAGE", "images/inventoryimages/sch_redlantern.tex" ),
    Asset( "ATLAS", "images/inventoryimages/sch_redlantern.xml" ),
	---- Cool Sunny
	Asset("ANIM", "anim/sch_hammer.zip"),
	Asset("ANIM", "anim/sch_swap_hammer.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_hammer.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_hammer.tex"),
	---- Crown 2nd
    Asset("ANIM", "anim/sch_hat_crown_1.zip"),
    Asset("ATLAS", "images/inventoryimages/sch_hat_crown_1.xml"),
    Asset("IMAGE", "images/inventoryimages/sch_hat_crown_1.tex"),
	---- 2nd Ice Staff
	Asset("ANIM", "anim/sch_battle_staff.zip"),
	Asset("ANIM", "anim/sch_swap_battle_staff.zip"),
	Asset("ATLAS", "images/inventoryimages/sch_battle_staff.xml"),
	Asset("IMAGE", "images/inventoryimages/sch_battle_staff.tex"),
	---- Test ---- #Temp
	Asset("ANIM", "anim/ydj_dst_td1madao_attack.zip"),
	---- Building
	Asset("ANIM", "anim/sch_street_lamp.zip"),
	Asset("IMAGE", "images/inventoryimages/sch_street_lamp.tex"),
	Asset("ATLAS", "images/inventoryimages/sch_street_lamp.xml"),
    Asset("ANIM", "anim/sch_street_lamp_short.zip"),
	Asset("IMAGE", "images/inventoryimages/sch_street_lamp_short.tex"),
	Asset("ATLAS", "images/inventoryimages/sch_street_lamp_short.xml"),
}

PrefabFiles = {
	"schwarzkirsche",
	"schwarzkirsche_none",
	"schwarzkirsche_key_classified",
	"sch_twin",
	------[[ Stuff ]]-----
	"sch_arcanist_stone",
	"sch_teatree_nut_piko",
	"sch_golden_teatree_nut",
	"sch_scythe",
	"sch_hat",
	"sch_dress_1",
	"sch_dress_2",
	"sch_hat_crown",
	"sch_blade_1",
	"sch_blade_2",
	"sch_compass",
	"sch_gems",
	"sch_dress_3",
	"sch_redlantern",
	"sch_ice_staff",
	"sch_hammer",
	"sch_hat_crown_1",
	"sch_battle_staff",
	"sch_spore",
	"sch_dead_gems",
	------[[ Dark Soul ]]-----
	"sch_dark_soul",
	"sch_dark_soul_fx",
	"sch_dark_soul_in",
	"sch_dark_soul_spawn",
	"sch_portal",
	------[[ Treasure ]]------
	"sch_treasure",
	------[[Other FX]]--------
	"sch_spin_fx",
	"sch_darkshield_fx",
	"sch_stalker_shield",
	"sch_stalker_shield_rage",
	"sch_stalker_shield_mod",
	"sch_sandfx",
	"sch_markfx",
	------[[Lastest FX]]----------
	"sch_elec_charged_fx", --- Charge FX
	"sch_explode_fx", --- Explode & Fireworks [1 & 2]
	"sch_fire_ring", --- Dragonfly FX
	"sch_hit_sparks_fx", --- Weapon Sparks
	"sch_sparks_fx_1", --- Sparks
	"sch_sparks_fx_2", --- Electric Sparks
	"sch_shot_projectile_fx", --- BRS FX
	------[[Shadow]]----------
	"sch_shadowsch",
	------[[Hamlet Pet]]-----------
	"sch_piko",
	------[[ Other ]]----------
	"sch_shadowtentacle",
	"sch_street_lamp",
	"sch_street_lamp_short",
}

--------------------[[ ... ]]-------------------------
modimport("libs/env.lua")
use "libs/mod_env"(env)
use "data/widgets/controls"
use "data/screens/chatinputscreen"
use "data/screens/consolescreen"


---------------------------[[ BADGE DISPLAY ]]----------------------------
modimport("scripts/widgets/schthirsty_statusdisplays.lua")
modimport("scripts/widgets/schshielder_statusdisplays.lua")
modimport("scripts/widgets/schwarlock_statusdisplays.lua")
modimport("scripts/widgets/schtreasure_statusdisplays.lua")
modimport("scripts/widgets/schbloomlevel_statusdisplays.lua")
modimport("scripts/widgets/schcriticalhit_statusdisplays.lua")

---------------------------[[ ACTION ]]------------------------
modimport("scripts/schextra/schextrastates.lua")
modimport("scripts/schextra/schxtrastatebk.lua")
modimport("scripts/schextra/schxtrastatetp.lua")
modimport("scripts/schextra/schxtrastatedg.lua")
modimport("scripts/schextra/schxtrastatepw.lua")
modimport("scripts/schextra/schxtrastateum.lua")
modimport("scripts/schextra/schxtrastatebm.lua")


--------------------[[ MINIMAP ICONS (OTHER) ]]-------------------
AddMinimapAtlas("images/map_icons/schwarzkirsche.xml")
AddMinimapAtlas("images/map_icons/sch_treasure_x_marks_spot.xml")
AddMinimapAtlas("images/map_icons/sch_piko_normal.xml")
AddMinimapAtlas("images/map_icons/sch_piko_orange.xml")
AddMinimapAtlas("images/map_icons/sch_piko_red.xml")
AddMinimapAtlas("images/map_icons/sch_golden_teatree_nut.xml")
AddMinimapAtlas("images/map_icons/sch_street_lamp.xml")
AddMinimapAtlas("images/map_icons/sch_street_lamp_short.xml")

----------------------[[ MINIMAP ICONS ]]-------------------------------
AddMinimapAtlas("images/inventoryimages/sch_arcanist_stone.xml")
AddMinimapAtlas("images/inventoryimages/sch_dark_soul.xml")
AddMinimapAtlas("images/inventoryimages/sch_teatree_piko.xml")
AddMinimapAtlas("images/inventoryimages/sch_teatree_piko_cooked.xml")
AddMinimapAtlas("images/inventoryimages/sch_golden_teatree_nut.xml")
AddMinimapAtlas("images/inventoryimages/sch_scythe.xml")
AddMinimapAtlas("images/inventoryimages/sch_hat.xml")
AddMinimapAtlas("images/inventoryimages/sch_dress_1.xml")
AddMinimapAtlas("images/inventoryimages/sch_dress_2.xml")
AddMinimapAtlas("images/inventoryimages/sch_hat_crown.xml")
AddMinimapAtlas("images/inventoryimages/sch_blade_1.xml")
AddMinimapAtlas("images/inventoryimages/sch_blade_2.xml")
AddMinimapAtlas("images/inventoryimages/sch_compass.xml")
AddMinimapAtlas("images/inventoryimages/sch_gems.xml")
AddMinimapAtlas("images/inventoryimages/sch_dress_3.xml")
AddMinimapAtlas("images/inventoryimages/sch_redlantern.xml")
AddMinimapAtlas("images/inventoryimages/sch_ice_staff.xml")
AddMinimapAtlas("images/inventoryimages/sch_hammer.xml")
AddMinimapAtlas("images/inventoryimages/sch_hat_crown_1.xml")
AddMinimapAtlas("images/inventoryimages/sch_battle_staff.xml")
AddMinimapAtlas("images/inventoryimages/sch_dead_gems.xml")

--[[ --- States
teleportato_teleport

catch_equip + Effects
use_fan

]]
----------------------[[ Item Descriptions ]]-------------------------------
STRINGS.NAMES.SCH_ARCANIST_STONE = "Mysterious Stone"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_ARCANIST_STONE = "This stone is Useless!"
STRINGS.NAMES.SCH_DARK_SOUL = "Dark Soul"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_DARK_SOUL = {
"It's Another Soul",
"This soul comes from life of a Nightmare",
}
STRINGS.NAMES.SCH_TREASURE = "X - Spot"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_TREASURE = "I'm curious what's the inside, can i dig it up ?"
STRINGS.NAMES.SCH_TEATREE_NUT_PIKO = "Teatree Nut"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_TEATREE_NUT_PIKO = "Now i can make Teatree farm."
STRINGS.NAMES.SCH_TEATREE_NUT_COOKED_PIKO = "Teatree Nut Cooked"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_TEATREE_NUT_COOKED_PIKO = "It's cooked. No more Teatree now."
STRINGS.NAMES.SCH_GOLDEN_TEATREE_NUT = "Golden Teatree Nut"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_GOLDEN_TEATREE_NUT = "This is the new experiment from Scientists"
STRINGS.NAMES.SCH_SCYTHE = "Scythe"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_SCYTHE = "Scythe from Death Angel"
STRINGS.NAMES.SCH_HAT = "Armored Headband"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_HAT = {
"It's good for battle ?",
"It's from Advance Tech",
}
STRINGS.NAMES.SCH_DRESS_1 = "Battle Dress"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_DRESS_1 = "It's a Battle Dress"
STRINGS.NAMES.SCH_DRESS_2 = "Dress"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_DRESS_2 = "It's a Dress good for your Style"
STRINGS.NAMES.SCH_DRESS_3 = "Maid Dress"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_DRESS_3 = "It's Maid Dress"
STRINGS.NAMES.SCH_HAT_CROWN = "Schwarz Crown"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_HAT_CROWN = "It's come from little Kingdom"
STRINGS.NAMES.SCH_BLADE_1 = "Black Blade"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_BLADE_1 = "Looks sharp"
STRINGS.NAMES.SCH_BLADE_2 = "Blade Claw"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_BLADE_2 = "It's Different from all Weapon."
STRINGS.NAMES.SCH_COMPASS = "Smart Compass"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_COMPASS = "It's the new tech from Schwarz"
STRINGS.NAMES.SCH_GEMS = "Mysterious Gems"
STRINGS.NAMES.SCH_GEMS_ONBUILD = "Mysterious Gems"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_GEMS = {
"It's just another Gems from another Dimension",
"This Gems has Hidden Power",
}
STRINGS.NAMES.SCH_REDLANTERN = "White Lantern"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_REDLANTERN = "It's a White Lantern"
STRINGS.NAMES.SCH_ICE_STAFF = "Ice Staff"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_ICE_STAFF = "It's Ice Staff from Ice Mage"
STRINGS.NAMES.SCH_HAMMER = "Ice Hammer"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_HAMMER = "It's Ice Hammer"
STRINGS.NAMES.SCH_HAT_CROWN_1 = "Schwarz Crown 2nd"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_HAT_CROWN_1 = "It's usable Crown"
STRINGS.NAMES.SCH_BATTLE_STAFF = "Battle Staff"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_BATTLE_STAFF = "It's a Battle Staff"
STRINGS.NAMES.SCH_SPORE = "Spore"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_SPORE = "It's spore"
STRINGS.NAMES.SCH_SPORE_RED = "Red Spore"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_SPORE_RED = "It's red spore"
STRINGS.NAMES.SCH_SPORE_BLUE = "Blue Spore"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_SPORE_BLUE = "It's blue spore"
STRINGS.NAMES.SCH_DEAD_GEMS = "Dead Gems"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_DEAD_GEMS = "It's a dead gems, useless."
STRINGS.NAMES.SCHSANDSPIKE = "Sand Spike"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCHSANDSPIKE = "Watch out, it can hit you."
STRINGS.NAMES.SCHSANDBLOCK = "Sand Castle"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCHSANDBLOCK = "Now we have Castle."
STRINGS.NAMES.SCH_STREET_LAMP = "Street Lamp"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_STREET_LAMP = "Uhm .. what a nice Technology."
STRINGS.NAMES.SCH_STREET_LAMP_SHORT = "Short Street Lamp"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_STREET_LAMP_SHORT = "Short but it still usefull."
----------------------[[ Our Desc ]]-------------------------------
STRINGS.NAMES.SHADOW_SCH_TIMBER = "Schwarz Timber"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SHADOW_SCH_TIMBER = "Chop-chop-chop"
STRINGS.NAMES.SHADOW_SCH_DIGGER = "Schwarz Digger"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SHADOW_SCH_DIGGER = "Keep Digging"
STRINGS.NAMES.SHADOW_SCH_MINER = "Schwarz Miner"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SHADOW_SCH_MINER = "It's just another one shadow"
STRINGS.NAMES.SCH_PIKO = "Cute Piko"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_PIKO = "Oh look at the little friend here, so cute."
STRINGS.NAMES.SCH_PIKO_FARMER = "Little Farmer"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_PIKO_FARMER = "He looks so busy."
STRINGS.NAMES.SCH_PIKO_ATTACKER = "Red Piko"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_PIKO_ATTACKER = "He looks so Aggressive."
STRINGS.NAMES.SCH_TWIN = "Schwarz Twins"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCH_TWIN =
{ 
	"She looks so different.",
	"It's Another Twin from Schwarz.",
	"How's going Schwarz ?",
}
----------------------[[ My Strings ]]-------------------------------
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP = "Exp"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_0 = "Level : 0"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_1 = "Level : 1"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_2 = "Level : 2"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_3 = "Level : 3"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_4 = "Level : 4"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_5 = "Level : 5"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_6 = "Level : 6"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_7 = "Level : 7"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_8 = "Level : 8"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_9 = "Level : 9"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_10 = "Level : 10"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_11 = "Level : 11"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_12 = "Level : 12"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_13 = "Level : 13"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_14 = "Level : 14"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_15 = "Level : 15"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_16 = "Level : 16"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_17 = "Level : 17"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_18 = "Level : 18"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_19 = "Level : 19"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_20 = "Level : 20"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_21 = "Level : 21"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_22 = "Level : 22"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_23 = "Level : 23"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_24 = "Level : 24"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_25 = "Level : 25"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_26 = "Level : 26"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_27 = "Level : 27"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_28 = "Level : 28"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_29 = "Level : 29"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_30 = "Level : 30"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_31 = "Level : 31"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_32 = "Level : 32"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_33 = "Level : 33"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_34 = "Level : 34"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_35 = "Level : 35"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_36 = "Level : 36"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_37 = "Level : 37"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_38 = "Level : 38"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_39 = "Level : 39"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_40 = "Level : 40"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_41 = "Level : 41"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_42 = "Level : 42"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_43 = "Level : 43"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_44 = "Level : 44"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_45 = "Level : 45"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_46 = "Level : 46"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_47 = "Level : 47"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_48 = "Level : 48"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_49 = "Level : 49"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_50 = "Level : 50"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_51 = "Level : 51"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_52 = "Level : 52"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_53 = "Level : 53"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_54 = "Level : 54"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_55 = "Level : 55"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_56 = "Level : 56"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_57 = "Level : 57"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_58 = "Level : 58"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_59 = "Level : 59"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_60 = "Level : 60"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_61 = "Level : 61"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_62 = "Level : 62"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_63 = "Level : 63"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_64 = "Level : 64"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_65 = "Level : 65"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_66 = "Level : 66"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_67 = "Level : 67"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_68 = "Level : 68"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_69 = "Level : 69"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_70 = "Level : 70"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_71 = "Level : 71"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_72 = "Level : 72"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_73 = "Level : 73"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_74 = "Level : 74"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_75 = "Level : 75"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_76 = "Level : 76"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_77 = "Level : 77"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_78 = "Level : 78"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_79 = "Level : 79"
STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_80 = "Level : 80"

------------------- NORMAL
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ASCENDANT_STRENGTH = "Strength : Normal Ascendant"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ASCENDANT_DAMAGE = "Damage : 150%"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ASCENDANT_HUNGER = "Hunger : 250+"


STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ANCIENT_STRENGTH = "Strength : Normal Ancient"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ANCIENT_DAMAGE = "Damage : 125%"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ANCIENT_HUNGER = "Hunger : 190+"


STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_VETERAN_STRENGTH = "Strength : Normal Veteran"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_VETERAN_DAMAGE = "Damage : 100"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_VETERAN_HUNGER = "Hunger : 150+"


STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_NORMAL_STRENGTH = "Strength : Normal"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_NORMAL_DAMAGE = "Damage : 75%"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_NORMAL_HUNGER = "Hunger : 110+"


STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_MIDVERAGE_STRENGTH = "Strength : Midverage"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_MIDVERAGE_DAMAGE = "Damage : 55%"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_MIDVERAGE_HUNGER = "Hunger : 70+"


STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_SLOTH_STRENGTH = "Strength : Sloth"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_SLOTH_DAMAGE = "Damage : 40%"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_SLOTH_HUNGER = "Hunger : 30+"


STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_EMPTY_STRENGTH = "Strength : Empty"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_EMPTY_DAMAGE = "Damage : 25%"
STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_EMPTY_HUNGER = "Hunger : 30-"

------------------- RAGE
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ASCENDANT_STRENGTH = "Strength : Rage Ascendant"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ASCENDANT_DAMAGE = "Damage : 300%"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ASCENDANT_HUNGER = "Hunger : 250+"


STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ANCIENT_STRENGTH = "Strength : Rage Ancient"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ANCIENT_DAMAGE = "Damage : 250%"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ANCIENT_HUNGER = "Hunger : 190+"


STRINGS.SCHWARZKIRSCHE_DESC_RAGE_VETERAN_STRENGTH = "Strength : Rage Veteran"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_VETERAN_DAMAGE = "Damage : 200"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_VETERAN_HUNGER = "Hunger : 150+"


STRINGS.SCHWARZKIRSCHE_DESC_RAGE_NORMAL_STRENGTH = "Strength : Rage"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_NORMAL_DAMAGE = "Damage : 150%"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_NORMAL_HUNGER = "Hunger : 110+"


STRINGS.SCHWARZKIRSCHE_DESC_RAGE_MIDVERAGE_STRENGTH = "Strength : Rage Midverage"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_MIDVERAGE_DAMAGE = "Damage : 110%"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_MIDVERAGE_HUNGER = "Hunger : 70+"


STRINGS.SCHWARZKIRSCHE_DESC_RAGE_SLOTH_STRENGTH = "Strength : Rage Sloth"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_SLOTH_DAMAGE = "Damage : 80%"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_SLOTH_HUNGER = "Hunger : 30+"


STRINGS.SCHWARZKIRSCHE_DESC_RAGE_EMPTY_STRENGTH = "Strength : Rage Empty"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_EMPTY_DAMAGE = "Damage : 50%"
STRINGS.SCHWARZKIRSCHE_DESC_RAGE_EMPTY_HUNGER = "Hunger : 30-"


STRINGS.SCHWARZKIRSCHE_DESC_TREASURE_FOUND = "Treasure Points is Full"
STRINGS.SCHWARZKIRSCHE_DESC_TREASURE_BUTTON = "Press : 'R' to Reveal it"
----------------------[[ Mod. GEMS ]]-------------------------------
------------- Not Working ---- Huh --------- 
GLOBAL.FUELTYPE["LUXURYGEMS"] = "LUXURYGEMS"
local function Small_Gems_Fuel(inst)
if GLOBAL.TheWorld.ismastersim then
	inst:AddComponent("fuel")
	inst.components.fuel.fuelvalue = 20
	inst.components.fuel.fueltype = FUELTYPE.LUXURYGEMS
inst:AddTag("LUXURYFUEL")
inst:AddTag("FUELGEMS")
inst:AddTag("SMALLFUELGEMS")
		else
		return
	end
end

local function Medium_Gems_Fuel(inst)
if GLOBAL.TheWorld.ismastersim then
	inst:AddComponent("fuel")
	inst.components.fuel.fuelvalue = 40
	inst.components.fuel.fueltype = FUELTYPE.LUXURYGEMS
inst:AddTag("LUXURYFUEL")
inst:AddTag("FUELGEMS")
inst:AddTag("MEDIUMFUELGEMS")
		else
		return
	end
end

local function Large_Gems_Fuel(inst)
if GLOBAL.TheWorld.ismastersim then
	inst:AddComponent("fuel")
	inst.components.fuel.fuelvalue = 100
	inst.components.fuel.fueltype = FUELTYPE.LUXURYGEMS
inst:AddTag("LUXURYFUEL")
inst:AddTag("FUELGEMS")
inst:AddTag("LARGEFUELGEMS")
		else
		return
	end
end

AddPrefabPostInit("redgem", Small_Gems_Fuel)
AddPrefabPostInit("bluegem", Small_Gems_Fuel)
AddPrefabPostInit("purplegem", Medium_Gems_Fuel)
AddPrefabPostInit("orangegem", Medium_Gems_Fuel)
AddPrefabPostInit("yellowgem", Medium_Gems_Fuel)
AddPrefabPostInit("greengem", Medium_Gems_Fuel)
AddPrefabPostInit("opalpreciousgem", Large_Gems_Fuel)

local function Mineral_Fuel_Med(inst) ---- or Metal Fuel
if GLOBAL.TheWorld.ismastersim then
--[[ Components already exist in the game	
	inst:AddComponent("fuel")
	inst.components.fuel.fuelvalue = 60
	inst.components.fuel.fueltype = FUELTYPE.MINERALFUEL
]]
inst:AddTag("MINERALFUEL")
inst:AddTag("METALFUEL")
inst:AddTag("METALMEDFUEL")
		else
		return
	end
end

AddPrefabPostInit("rocks", Mineral_Fuel_Med)
AddPrefabPostInit("nitre", Mineral_Fuel_Med)
AddPrefabPostInit("flint", Mineral_Fuel_Med)

local function Mineral_Fuel_Large(inst) ---- or Metal Fuel
if GLOBAL.TheWorld.ismastersim then
--[[ Components already exist in the game	
	inst:AddComponent("fuel")
	inst.components.fuel.fuelvalue = 100
	inst.components.fuel.fueltype = FUELTYPE.MINERALFUEL
]]
inst:AddTag("MINERALFUEL")
inst:AddTag("METALFUEL")
inst:AddTag("METALLARGEFUEL")
		else
		return
	end
end

AddPrefabPostInit("goldnugget", Mineral_Fuel_Large)

local function SetTrader(inst)
if GLOBAL.TheWorld.ismastersim then
    inst:AddComponent("tradable")
	inst:AddTag("LuxuryGemsFuel")
		else
		return
	end
end
AddPrefabPostInit("sch_dark_soul", SetTrader)
AddPrefabPostInit("nightmarefuel", SetTrader)
AddPrefabPostInit("healingsalve", SetTrader)
AddPrefabPostInit("bandage", SetTrader)

-----------------------------[[ POND ]]-----------------------------------
local function Fishable_Stuff(inst)
	if GLOBAL.ThePlayer and GLOBAL.ThePlayer.prefab == "schwarzkirsche" and inst.components.fishable then
		inst.components.fishable:AddFish("sch_teatree_nut_piko")
	end
end
AddPrefabPostInit("pond", Fishable_Stuff)
AddPrefabPostInit("pond_mos", Fishable_Stuff)
-- AddPrefabPostInit("oasislake", Fishable_Stuff)

----------------------[[ Ingredient Tabs ]]-------------------------------
local SCH_SCYTHE_INGREDIENT = Ingredient( "sch_scythe", 1)
SCH_SCYTHE_INGREDIENT.atlas = "images/inventoryimages/sch_scythe.xml"
local SCH_DRESS_1_INGREDIENT = Ingredient( "sch_dress_1", 1)
SCH_DRESS_1_INGREDIENT.atlas = "images/inventoryimages/sch_dress_1.xml"
local SCH_DRESS_2_INGREDIENT = Ingredient( "sch_dress_2", 1)
SCH_DRESS_2_INGREDIENT.atlas = "images/inventoryimages/sch_dress_2.xml"
local SCH_BLADE_1_INGREDIENT = Ingredient( "sch_blade_1", 1)
SCH_BLADE_1_INGREDIENT.atlas = "images/inventoryimages/sch_blade_1.xml"
local SCH_BLADE_2_INGREDIENT = Ingredient( "sch_blade_2", 1)
SCH_BLADE_2_INGREDIENT.atlas = "images/inventoryimages/sch_blade_2.xml"
local SCH_HAT_CROWN_INGREDIENT = Ingredient( "sch_hat_crown", 1)
SCH_HAT_CROWN_INGREDIENT.atlas = "images/inventoryimages/sch_hat_crown.xml"

local SCH_DARKSOUL_INGREDIENT = Ingredient( "sch_dark_soul", 10)
SCH_DARKSOUL_INGREDIENT.atlas = "images/inventoryimages/sch_dark_soul.xml"
local SCH_DARKSOUL_INGREDIENT_1 = Ingredient( "sch_dark_soul", 1)
SCH_DARKSOUL_INGREDIENT_1.atlas = "images/inventoryimages/sch_dark_soul.xml"
local SCH_DARKSOUL_INGREDIENT_2 = Ingredient( "sch_dark_soul", 2)
SCH_DARKSOUL_INGREDIENT_2.atlas = "images/inventoryimages/sch_dark_soul.xml"
local SCH_DARKSOUL_INGREDIENT_3 = Ingredient( "sch_dark_soul", 3)
SCH_DARKSOUL_INGREDIENT_3.atlas = "images/inventoryimages/sch_dark_soul.xml"
local SCH_DARKSOUL_INGREDIENT_6 = Ingredient( "sch_dark_soul", 6)
SCH_DARKSOUL_INGREDIENT_6.atlas = "images/inventoryimages/sch_dark_soul.xml"

local SCH_ICE_STAFF_INGREDIENT = Ingredient( "sch_ice_staff", 1)
SCH_ICE_STAFF_INGREDIENT.atlas = "images/inventoryimages/sch_ice_staff.xml"
local SCH_DEAD_GEM_INGREDIENT = Ingredient( "sch_dead_gems", 1)
SCH_DEAD_GEM_INGREDIENT.atlas = "images/inventoryimages/sch_dead_gems.xml"



-------------------------------[[ TABS ]]----------------------------------------
GLOBAL.STRINGS.TABS.SCHWARZ = "Schwarz : Tech"
GLOBAL.RECIPETABS['SCHWARZ'] = {str = "SCHWARZ", sort = 12, icon = "sch_tabs.tex", icon_atlas = "images/sch_tabs.xml", "schwarzkirsche"}
--[[
GLOBAL.STRINGS.TABS.SCHWARZADVANCE = "Schwarz : Advance Tech"
GLOBAL.RECIPETABS['SCHWARZADVANCE'] = {str = "SCHWARZADVANCE", sort = 11, icon = "sch_adv_tabs.tex", icon_atlas = "images/sch_adv_tabs.xml", "schwarzkirsche"}
]]
-------------------------------[[ RECIPE ]]----------------------------------------

local SCH_STREET_LAMP_RECIPE = AddRecipe("sch_street_lamp", 
{ 	GLOBAL.Ingredient("boards", 2), 
	GLOBAL.Ingredient("cutstone", 2), 
	GLOBAL.Ingredient("fireflies", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_ONE, "sch_street_lamp_placer", nil, nil, nil, nil, "images/inventoryimages/sch_street_lamp.xml", "sch_street_lamp.tex" )
SCH_STREET_LAMP_RECIPE.tagneeded = false
SCH_STREET_LAMP_RECIPE.builder_tag = "schwarzkirsche"
SCH_STREET_LAMP_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_street_lamp.xml")
STRINGS.SCH_STREET_LAMP_RECIPE = "Eternal Street Lamp" 
STRINGS.RECIPE_DESC.SCH_STREET_LAMP = "Bigger Better." 


local SCH_STREET_LAMP_SHORT_RECIPE = AddRecipe("sch_street_lamp_short", 
{ 	GLOBAL.Ingredient("boards", 1), 
	GLOBAL.Ingredient("cutstone", 1), 
	GLOBAL.Ingredient("fireflies", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_ONE, "sch_street_lamp_short_placer", nil, nil, nil, nil, "images/inventoryimages/sch_street_lamp_short.xml", "sch_street_lamp_short.tex" )
SCH_STREET_LAMP_SHORT_RECIPE.tagneeded = false
SCH_STREET_LAMP_SHORT_RECIPE.builder_tag = "schwarzkirsche"
SCH_STREET_LAMP_SHORT_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_street_lamp_short.xml")
STRINGS.SCH_STREET_LAMP_SHORT_RECIPE = "Eternal Street Lamp" 
STRINGS.RECIPE_DESC.SCH_STREET_LAMP_SHORT = "Cheaper Better." 


----- Leveling System
local SCH_SCYTHE_RECIPE = AddRecipe("sch_scythe", 
{ 	SCH_BLADE_2_INGREDIENT, 
	GLOBAL.Ingredient("bluegem", 1), 
	SCH_DARKSOUL_INGREDIENT
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/sch_scythe.xml", "sch_scythe.tex" )
SCH_SCYTHE_RECIPE.tagneeded = false
SCH_SCYTHE_RECIPE.builder_tag = "schwarzkirsche"
SCH_SCYTHE_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_scythe.xml")
STRINGS.SCH_SCYTHE_RECIPE = "Scythe" 
STRINGS.RECIPE_DESC.SCH_SCYTHE = "Dark Soul can makes you Mad." 


----- Leveling System
local SCH_HAT_RECIPE = AddRecipe("sch_hat", 
{ 	GLOBAL.Ingredient("flint", 5), 
	GLOBAL.Ingredient("goldnugget", 2), 
	GLOBAL.Ingredient("footballhat", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/sch_hat.xml", "sch_hat.tex" )
SCH_HAT_RECIPE.tagneeded = false
SCH_HAT_RECIPE.builder_tag = "schwarzkirsche"
SCH_HAT_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_hat.xml")
STRINGS.SCH_HAT_RECIPE = "Headband" 
STRINGS.RECIPE_DESC.SCH_HAT = "Armored Headband!" 


local SCH_HAT_CROWN_RECIPE = AddRecipe("sch_hat_crown", 
{ 	GLOBAL.Ingredient("strawhat", 1), 
	GLOBAL.Ingredient("onemanband", 1), 
	GLOBAL.Ingredient("goldnugget", 3), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/sch_hat_crown.xml", "sch_hat_crown.tex" )
SCH_HAT_CROWN_RECIPE.tagneeded = false
SCH_HAT_CROWN_RECIPE.builder_tag = "schwarzkirsche"
SCH_HAT_CROWN_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_hat_crown.xml")
STRINGS.SCH_HAT_CROWN_RECIPE = "Crown" 
STRINGS.RECIPE_DESC.SCH_HAT_CROWN = "Take your crown!" 

--[[ Next Update
----- Leveling System (Waiting)
local SCH_HAT_CROWN_1_RECIPE = AddRecipe("sch_hat_crown_1", 
{ 	SCH_HAT_CROWN_INGREDIENT, 
	GLOBAL.Ingredient("strawhat", 1), 
	GLOBAL.Ingredient("goldnugget", 3), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/sch_hat_crown_1.xml", "sch_hat_crown_1.tex" )
SCH_HAT_CROWN_1_RECIPE.tagneeded = false
SCH_HAT_CROWN_1_RECIPE.builder_tag = "schwarzkirsche"
SCH_HAT_CROWN_1_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_hat_crown_1.xml")
STRINGS.SCH_HAT_CROWN_1_RECIPE = "Crown" 
STRINGS.RECIPE_DESC.SCH_HAT_CROWN_1 = "Lv me up!" 
]]--

local SCH_DRESS_2_RECIPE = AddRecipe("sch_dress_2", 
{ 	GLOBAL.Ingredient("tentaclespots", 1), 
	GLOBAL.Ingredient("armorgrass", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/sch_dress_2.xml", "sch_dress_2.tex" )
SCH_DRESS_2_RECIPE.tagneeded = false
SCH_DRESS_2_RECIPE.builder_tag = "schwarzkirsche"
SCH_DRESS_2_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_dress_2.xml")
STRINGS.SCH_DRESS_2_RECIPE = "Armored Dress" 
STRINGS.RECIPE_DESC.SCH_DRESS_2 = "Feel pretty ?" 


----- Leveling System
local SCH_DRESS_1_RECIPE = AddRecipe("sch_dress_1", 
{ 	SCH_DRESS_2_INGREDIENT,
	GLOBAL.Ingredient("armorwood", 1), 
	GLOBAL.Ingredient("redgem", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/sch_dress_1.xml", "sch_dress_1.tex" )
SCH_DRESS_1_RECIPE.tagneeded = false
SCH_DRESS_1_RECIPE.builder_tag = "schwarzkirsche"
SCH_DRESS_1_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_dress_1.xml")
STRINGS.SCH_DRESS_1_RECIPE = "Armored Dress" 
STRINGS.RECIPE_DESC.SCH_DRESS_1 = "Safety better" 


----- Leveling System (Waiting)
local SCH_DRESS_3_RECIPE = AddRecipe("sch_dress_3", 
{ 	GLOBAL.Ingredient("silk", 12), 
	GLOBAL.Ingredient("bluegem", 2), 
	GLOBAL.Ingredient("pigskin", 3), 
}, 	RECIPETABS.SCHWARZ, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/sch_dress_3.xml", "sch_dress_3.tex" )
SCH_DRESS_3_RECIPE.tagneeded = false
SCH_DRESS_3_RECIPE.builder_tag = "schwarzkirsche"
SCH_DRESS_3_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_dress_3.xml")
STRINGS.SCH_DRESS_3_RECIPE = "Maid Dress"
STRINGS.RECIPE_DESC.SCH_DRESS_3 = "The true power of Blue Gems" 

----- BRS Stuff
local SCH_BLADE_1_RECIPE = AddRecipe("sch_blade_1", 
{ 	GLOBAL.Ingredient("spear", 1), 
	SCH_DARKSOUL_INGREDIENT_2, 
	GLOBAL.Ingredient("flint", 4), 
}, 	RECIPETABS.SCHWARZ, TECH.NONE, nil, nil, nil, nil, nil, "images/inventoryimages/sch_blade_1.xml", "sch_blade_1.tex" )
SCH_BLADE_1_RECIPE.tagneeded = false
SCH_BLADE_1_RECIPE.builder_tag = "schwarzkirsche"
SCH_BLADE_1_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_blade_1.xml")
STRINGS.SCH_BLADE_1_RECIPE = "Black Blade" 
STRINGS.RECIPE_DESC.SCH_BLADE_1 = "Thrust your enemy!" 


local SCH_BLADE_2_RECIPE = AddRecipe("sch_blade_2", 
{ 	SCH_BLADE_1_INGREDIENT, 
	GLOBAL.Ingredient("goldnugget", 3), 
	SCH_DARKSOUL_INGREDIENT_6, 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/sch_blade_2.xml", "sch_blade_2.tex" )
SCH_BLADE_2_RECIPE.tagneeded = false
SCH_BLADE_2_RECIPE.builder_tag = "schwarzkirsche"
SCH_BLADE_2_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_blade_2.xml")
STRINGS.SCH_BLADE_2_RECIPE = "Blade Claw" 
STRINGS.RECIPE_DESC.SCH_BLADE_2 = "Hit your enemy harder!" 

--[[ Also Musha stuff
----- Leveling System (Waiting)
local SCH_HAMMER_RECIPE = AddRecipe("sch_hammer", 
{ 	SCH_BLADE_2_INGREDIENT, 
	GLOBAL.Ingredient("hammer", 1), 
	GLOBAL.Ingredient("spear", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/sch_hammer.xml", "sch_hammer.tex" )
SCH_HAMMER_RECIPE.tagneeded = false
SCH_HAMMER_RECIPE.builder_tag = "schwarzkirsche"
SCH_HAMMER_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_hammer.xml")
STRINGS.SCH_HAMMER_RECIPE = "Battle Hammer" 
STRINGS.RECIPE_DESC.SCH_HAMMER = "Smack your Enemy" 
]]

--[[ Extra Recps. Next Update

local SCH_ICE_STAFF_RECIPE = AddRecipe("sch_ice_staff", 
{ 	GLOBAL.Ingredient("icestaff", 1), 
	GLOBAL.Ingredient("bluegem", 1), 
	GLOBAL.Ingredient("nightmarefuel", 2), 
}, 	RECIPETABS.SCHWARZ, TECH.MAGIC_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/sch_ice_staff.xml", "sch_ice_staff.tex" )
SCH_ICE_STAFF_RECIPE.tagneeded = false
SCH_ICE_STAFF_RECIPE.builder_tag = "schwarzkirsche"
SCH_ICE_STAFF_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_ice_staff.xml")
STRINGS.SCH_ICE_STAFF_RECIPE = "Ice Mage Staff" 
STRINGS.RECIPE_DESC.SCH_ICE_STAFF = "Freeze Your Enemy" 

local SCH_BATTLE_STAFF_RECIPE = AddRecipe("sch_battle_staff", 
{ 	SCH_ICE_STAFF_INGREDIENT, 
	GLOBAL.Ingredient("spear", 1), 
	GLOBAL.Ingredient("nightmarefuel", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.MAGIC_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/sch_battle_staff.xml", "sch_battle_staff.tex" )
SCH_BATTLE_STAFF_RECIPE.tagneeded = false
SCH_BATTLE_STAFF_RECIPE.builder_tag = "schwarzkirsche"
SCH_BATTLE_STAFF_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_battle_staff.xml")
STRINGS.SCH_BATTLE_STAFF_RECIPE = "Battle Staff" 
STRINGS.RECIPE_DESC.SCH_BATTLE_STAFF = "It's different from other staff" 

local SCH_REDLANTERN_RECIPE = AddRecipe("sch_redlantern", 
{ 	GLOBAL.Ingredient("fireflies", 3), 
	GLOBAL.Ingredient("twigs", 3), 
	GLOBAL.Ingredient("redgem", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/sch_redlantern.xml", "sch_redlantern.tex" )
SCH_REDLANTERN_RECIPE.tagneeded = false
SCH_REDLANTERN_RECIPE.builder_tag = "schwarzkirsche"
SCH_REDLANTERN_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_redlantern.xml")
STRINGS.SCH_REDLANTERN_RECIPE = "Ghost Lantern" 
STRINGS.RECIPE_DESC.SCH_REDLANTERN = "Lantern" 

]]

----------------------------------------------------------------------

local SCH_COMPASS_RECIPE = AddRecipe("sch_compass", 
{ 	GLOBAL.Ingredient("compass", 1), 
	GLOBAL.Ingredient("featherpencil", 1), 
	GLOBAL.Ingredient("mapscroll", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_ONE, nil, nil, nil, nil, nil, "images/inventoryimages/sch_compass.xml", "sch_compass.tex" )
SCH_COMPASS_RECIPE.tagneeded = false
SCH_COMPASS_RECIPE.builder_tag = "schwarzkirsche"
SCH_COMPASS_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_compass.xml")
STRINGS.SCH_COMPASS_RECIPE = "Smart Compass" 
STRINGS.RECIPE_DESC.SCH_COMPASS = "How smart your compass ?" 

local SCH_DEAD_GEMS_RECIPE = AddRecipe("sch_dead_gems", 
{ 	SCH_DARKSOUL_INGREDIENT_1, 
	GLOBAL.Ingredient("rocks", 1), 
	GLOBAL.Ingredient("goldnugget", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_TWO, nil, nil, nil, nil, nil, "images/inventoryimages/sch_dead_gems.xml", "sch_dead_gems.tex" )
SCH_DEAD_GEMS_RECIPE.tagneeded = false
SCH_DEAD_GEMS_RECIPE.builder_tag = "schwarzkirsche"
SCH_DEAD_GEMS_RECIPE.atlas = resolvefilepath("images/inventoryimages/sch_dead_gems.xml")
STRINGS.SCH_DEAD_GEMS_RECIPE = "Dead Gems" 
STRINGS.RECIPE_DESC.SCH_DEAD_GEMS = "Not Dead but it's Sealed" 

local SCH_GEMS_ONBUILD = AddRecipe("sch_gems_onbuild", 
{ 	SCH_DARKSOUL_INGREDIENT_3, 
	GLOBAL.Ingredient("redgem", 1), 
	SCH_DEAD_GEM_INGREDIENT, 
}, 	RECIPETABS.SCHWARZ, TECH.MAGIC_THREE, nil, nil, nil, nil, nil, "images/inventoryimages/sch_gems.xml", "sch_gems.tex" )
SCH_GEMS_ONBUILD.tagneeded = false
SCH_GEMS_ONBUILD.builder_tag = "schwarzkirsche"
SCH_GEMS_ONBUILD.atlas = resolvefilepath("images/inventoryimages/sch_gems.xml")
STRINGS.SCH_GEMS_ONBUILD = "Mysterious Gems" 
STRINGS.RECIPE_DESC.SCH_GEMS_ONBUILD = "Stolen from Celestial Castel and has Hidden Potential" 

---------------------- Data added : Jan 13 2020 (9:55 PM)

local RECP_TURF_GRASS = AddRecipe("turf_grass", 
{ 	GLOBAL.Ingredient("ash", 1), 
	GLOBAL.Ingredient("spoiled_food", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_ONE, nil, nil, nil, nil, "schwarzkirsche")
RECP_TURF_GRASS.tagneeded = false
STRINGS.RECP_TURF_GRASS = "Grass Turf" 
-- STRINGS.RECIPE_DESC.turf_grass = "Let's make Grass Turf!" 

local RECP_TURF_FOREST = AddRecipe("turf_forest", 
{ 	GLOBAL.Ingredient("ash", 1), 
	GLOBAL.Ingredient("log", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_ONE, nil, nil, nil, nil, "schwarzkirsche")
RECP_TURF_FOREST.tagneeded = false
STRINGS.RECP_TURF_FOREST = "Forest Turf" 
-- STRINGS.RECIPE_DESC.turf_forest = "Let's Make Forest Turf" 

local RECP_TURF_SAVANNA = AddRecipe("turf_savanna", 
{ 	GLOBAL.Ingredient("ash", 1), 
	GLOBAL.Ingredient("cutgrass", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_ONE, nil, nil, nil, nil, "schwarzkirsche")
RECP_TURF_SAVANNA.tagneeded = false
STRINGS.RECP_TURF_SAVANNA = "Savana Turf" 
-- STRINGS.RECIPE_DESC.turf_savanna = "Let's Make Savana Turf" 

local RECP_TURF_ROCKY = AddRecipe("turf_rocky", 
{ 	GLOBAL.Ingredient("flint", 1), 
	GLOBAL.Ingredient("rocks", 1), 
}, 	RECIPETABS.SCHWARZ, TECH.SCIENCE_ONE, nil, nil, nil, nil, "schwarzkirsche")
RECP_TURF_ROCKY.tagneeded = false
STRINGS.RECP_TURF_ROCKY = "Savana Turf" 
-- STRINGS.RECIPE_DESC.turf_savanna = "Let's Make Rocky Turf" 

-----------------------------[[ FOODS : COOK POT ]]------------------------------
--[[         Future Update
AddIngredientValues({""}, { cutnettle = 1, sweetener = 1})
local FreshNettle = {
	name = "",
	test = function(cooker, names, tags) return (tags.cutnettle and tags.cutnettle >= 2) and (tags.cutnettle and tags.cutnettle >= 2) end,
	priority = 50,
	weight = 1,
	foodtype = "VEGGIE",
	health = 60,
	hunger = 25,
	sanity = 5,
	perishtime = TUNING.PERISH_SUPERSLOW,
	cooktime = 3,
}
AddCookerRecipe("cookpot", FreshNettle)
------------ New Update [Compatible with Warly Toys]
AddCookerRecipe("portablecookpot", FreshNettle)
AddCookerRecipe("portablespicer", FreshNettle)
]]

---------------------------------------------------------------------------
--[[
local ARMOR_SKELETON = AddRecipe("armorskeleton", 
{ 	GLOBAL.Ingredient("armor_sanity", 5), 
	GLOBAL.Ingredient("boneshard", 120), 
	GLOBAL.Ingredient("armormarble", 7), 
}, 	RECIPETABS.SCHWARZADVANCE, TECH.NONE, nil, nil, nil, nil, "madnessanimator")
ARMOR_SKELETON.tagneeded = false
STRINGS.ARMOR_SKELETON = "Armor Skeleton" 
STRINGS.RECIPE_DESC.ARMORSKELETON = "How much you spend ?" 
]]
---------------------------------------------------------------------------
--- IDK IT'S STILL WORK ON FUTURE UPDATE (DST)
--[[ --- Old
local SITCOMMAND = GLOBAL.Action({4, true, true, 10, false, false, nil})
local SITCOMMAND_CANCEL = GLOBAL.Action({4, true, true, 10,	false, false, nil})
]]

---- New
local SITCOMMAND = GLOBAL.Action({ mount_valid = true })
local SITCOMMAND_CANCEL = GLOBAL.Action({ mount_valid = true })

AddReplicableComponent("followersitcommand")

SITCOMMAND.id = "SITCOMMAND"
SITCOMMAND.str = "Order to Stay"
SITCOMMAND.fn = function(act)
	local targ = act.target
	if targ and targ.components.followersitcommand and act.doer:HasTag("myMaster") then
		act.doer.components.locomotor:Stop()
		act.doer.components.talker:Say("Stay Here!")
		targ.components.follower:StopFollowing()
		targ.components.followersitcommand:SetStaying(true)
		targ.components.followersitcommand:RememberSitPos("currentstaylocation", GLOBAL.Point(targ.Transform:GetWorldPosition())) 
		return true
	end
end
AddAction(SITCOMMAND)
-- AddStategraphActionHandler("wilson", ActionHandler(SITCOMMAND, "give"))
SITCOMMAND_CANCEL.id = "SITCOMMAND_CANCEL"
SITCOMMAND_CANCEL.str = "Order to Follow"
SITCOMMAND_CANCEL.fn = function(act)
	local targ = act.target
	if targ and targ.components.followersitcommand and act.doer:HasTag("myMaster") then
		act.doer.components.locomotor:Stop()
		act.doer.components.talker:Say("Follow Me!")
		targ.components.follower:SetLeader(act.doer)
		targ.components.followersitcommand:SetStaying(false)
		return true
	end
end
AddAction(SITCOMMAND_CANCEL)
-- AddStategraphActionHandler("wilson", ActionHandler(SITCOMMAND_CANCEL, "give"))

AddComponentAction("SCENE", "followersitcommand", function(inst, doer, actions, rightclick)
	if rightclick and inst.replica.followersitcommand then
		if not inst.replica.followersitcommand:IsCurrentlyStaying() then
			table.insert(actions, GLOBAL.ACTIONS.SITCOMMAND)
		else
			table.insert(actions, GLOBAL.ACTIONS.SITCOMMAND_CANCEL)
		end
	end
end)



----------------------[[ ACT FROM KEY ACT ]]-------------------------------

local function Check_Hunted_Treasure(inst)
	local pos1 = inst:GetPosition()
	local offset1 = FindWalkableOffset(pos1, math.random() * 2 * math.pi, math.random(5, 10), 10)
	local spawn_pos1 = pos1 + offset1 
if offset1 then 
		local chest_spawn = SpawnPrefab("sch_treasure")
					chest_spawn.Transform:SetPosition(spawn_pos1:Get())
					chest_spawn:SetTreasureHunt()
		local spawn_fx = SpawnPrefab("small_puff")
					spawn_fx.Transform:SetPosition(spawn_pos1:Get())
		local spawn_fx_2 = SpawnPrefab("collapse_small")
					spawn_fx_2.Transform:SetPosition(spawn_pos1:Get())
		local spawn_shovel = SpawnPrefab("shovel")
					spawn_shovel.Transform:SetPosition(spawn_pos1:Get())
					spawn_shovel.components.finiteuses.current = 1
			inst.components.talker:Say("Hey!")
		end	
	print("Treasure Spawned marked 'X' on the Map ") 
end

----------------------[[ CALLED FROM KEYHANDLER ]]-------------------------------
local function SHOW_LEVEL(inst)
	inst.writing = false
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
	for k,v in pairs(ents) do
		inst.writing = true
	end 
	if not inst.writing then
		local TheInput = TheInput
			----------------------
	local max_exp = 30375
	local minexp = 0
			local maxp=math.floor(max_exp-minexp)
			local curxp=math.floor(inst.schwarzkirsche_level-minexp)
			totalexp = ""..math.floor(curxp*30375/maxp)..""
			----------------------
		inst.keep_check = false			
		if not inst.keep_check then		
			inst.keep_check = true	
			----------------------
			if inst.schwarzkirsche_level >= 0 and inst.schwarzkirsche_level < 375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_0.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 375 and inst.schwarzkirsche_level < 750 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_1.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 750 and inst.schwarzkirsche_level < 1125 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_2.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 1125 and inst.schwarzkirsche_level < 1500 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_3.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")

			elseif inst.schwarzkirsche_level >= 1500 and inst.schwarzkirsche_level < 1875 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_4.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 1875 and inst.schwarzkirsche_level < 2250 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_5.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 2250 and inst.schwarzkirsche_level < 2625 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_6.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 2625 and inst.schwarzkirsche_level < 3000 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_7.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 3000 and inst.schwarzkirsche_level < 3375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_8.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 3375 and inst.schwarzkirsche_level < 3750 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_9.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 3750 and inst.schwarzkirsche_level < 4125 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_10.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 4125 and inst.schwarzkirsche_level < 4500 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_11.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 4500 and inst.schwarzkirsche_level < 4875 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_12.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 4875 and inst.schwarzkirsche_level < 5250 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_13.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 5250 and inst.schwarzkirsche_level < 5625 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_14.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 5625 and inst.schwarzkirsche_level < 6000 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_15.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 6000 and inst.schwarzkirsche_level < 6375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_16.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 6375 and inst.schwarzkirsche_level < 6750 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_17.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 6750 and inst.schwarzkirsche_level < 7125 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_18.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 7125 and inst.schwarzkirsche_level < 7500 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_19.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 7500 and inst.schwarzkirsche_level < 7875 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_20.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 7875 and inst.schwarzkirsche_level < 8250 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_21.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 8250 and inst.schwarzkirsche_level < 8625 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_22.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 8625 and inst.schwarzkirsche_level < 9000 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_23.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 9000 and inst.schwarzkirsche_level < 9375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_24.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 9375 and inst.schwarzkirsche_level < 9750 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_25.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 9750 and inst.schwarzkirsche_level < 10125 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_26.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 10125 and inst.schwarzkirsche_level < 10500 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_27.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 10500 and inst.schwarzkirsche_level < 10875 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_28.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 10875 and inst.schwarzkirsche_level < 11250 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_29.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 11250 and inst.schwarzkirsche_level < 11625 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_30.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 11625 and inst.schwarzkirsche_level < 12000 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_31.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 12000 and inst.schwarzkirsche_level < 12375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_32.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 12375 and inst.schwarzkirsche_level < 12750 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_33.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 12750 and inst.schwarzkirsche_level < 13125 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_34.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 13125 and inst.schwarzkirsche_level < 13500 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_35.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 13500 and inst.schwarzkirsche_level < 13875 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_36.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 13875 and inst.schwarzkirsche_level < 14250 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_37.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 14250 and inst.schwarzkirsche_level < 14625 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_38.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 14625 and inst.schwarzkirsche_level < 15000 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_39.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 15000 and inst.schwarzkirsche_level < 15375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_40.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 15375 and inst.schwarzkirsche_level < 15750 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_41.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 15750 and inst.schwarzkirsche_level < 16125 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_42.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 16125 and inst.schwarzkirsche_level < 16500 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_43.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 16500 and inst.schwarzkirsche_level < 16875 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_44.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 16875 and inst.schwarzkirsche_level < 17250 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_45.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 17250 and inst.schwarzkirsche_level < 17625 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_46.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 17625 and inst.schwarzkirsche_level < 18000 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_47.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 18000 and inst.schwarzkirsche_level < 18375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_48.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 18375 and inst.schwarzkirsche_level < 18750 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_49.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 18750 and inst.schwarzkirsche_level < 19125 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_50.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 19125 and inst.schwarzkirsche_level < 19500 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_51.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 19500 and inst.schwarzkirsche_level < 19875 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_52.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 19875 and inst.schwarzkirsche_level < 20250 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_53.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 20250 and inst.schwarzkirsche_level < 20625 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_54.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 20625 and inst.schwarzkirsche_level < 21000 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_55.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 21000 and inst.schwarzkirsche_level < 21375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_56.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 21375 and inst.schwarzkirsche_level < 21750 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_57.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 21750 and inst.schwarzkirsche_level < 22125 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_58.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 22125 and inst.schwarzkirsche_level < 22500 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_59.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 22500 and inst.schwarzkirsche_level < 22875 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_60.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 22875 and inst.schwarzkirsche_level < 23250 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_61.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 23250 and inst.schwarzkirsche_level < 23625 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_62.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 23625 and inst.schwarzkirsche_level < 24000 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_63.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 24000 and inst.schwarzkirsche_level < 24375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_64.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 24375 and inst.schwarzkirsche_level < 24750 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_65.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 24750 and inst.schwarzkirsche_level < 25125 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_66.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 25125 and inst.schwarzkirsche_level < 25500 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_67.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 25500 and inst.schwarzkirsche_level < 25875 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_68.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 25875 and inst.schwarzkirsche_level < 26250 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_69.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 26250 and inst.schwarzkirsche_level < 26625 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_70.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 26625 and inst.schwarzkirsche_level < 27000 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_71.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 27000 and inst.schwarzkirsche_level < 27375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_72.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 27375 and inst.schwarzkirsche_level < 27750 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_73.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 27750 and inst.schwarzkirsche_level < 28125 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_74.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 28125 and inst.schwarzkirsche_level < 28500 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_75.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 28500 and inst.schwarzkirsche_level < 28875 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_76.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 28875 and inst.schwarzkirsche_level < 29250 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_77.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 29250 and inst.schwarzkirsche_level < 30000 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_78.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 30000 and inst.schwarzkirsche_level < 30375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_79.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			elseif inst.schwarzkirsche_level >= 30375 then
				inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_LEVEL_80.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_CURRENT_EXP.." : "..(totalexp).."]")
			
			end
			--inst.sg:AddStateTag("notalking")
		elseif inst.keep_check then		
			inst.keep_check = false	
			--inst.components.talker:ShutUp()
			--inst.sg:RemoveStateTag("notalking")
		end
		inst:DoTaskInTime( 0.5, function()
			if inst.keep_check then
				inst.keep_check = false
				--inst.sg:RemoveStateTag("notalking") 
			end 
		end)
		----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
	end
end
AddModRPCHandler("schwarzkirsche", "SHOWLEVEL", SHOW_LEVEL)

local function SHOW_STATUS(inst)
	inst.writing = false
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
	for k,v in pairs(ents) do
		inst.writing = true
	end 
	if not inst.writing then
		local TheInput = TheInput
		----------------------
		----------------------
		inst.keep_check = false	
		if not inst.keep_check then		
			inst.keep_check = true	
		----------------------
	if not inst.IsStateRageMode then
if inst.strength == "ascendant" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ASCENDANT_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ASCENDANT_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ASCENDANT_HUNGER.."]")

elseif inst.strength == "ancient" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ANCIENT_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ANCIENT_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_ANCIENT_HUNGER.."]")

elseif inst.strength == "veteran" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_VETERAN_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_VETERAN_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_VETERAN_HUNGER.."]")

elseif inst.strength == "normal" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_NORMAL_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_NORMAL_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_NORMAL_HUNGER.."]")

elseif inst.strength == "midverage" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_MIDVERAGE_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_MIDVERAGE_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_MIDVERAGE_HUNGER.."]")

elseif inst.strength == "sloth" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_SLOTH_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_SLOTH_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_SLOTH_HUNGER.."]")

elseif inst.strength == "empty" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_EMPTY_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_EMPTY_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_NORMAL_EMPTY_HUNGER.."]")
end
	end

	if inst.IsStateRageMode then
if inst.strength == "ascendant" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ASCENDANT_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ASCENDANT_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ASCENDANT_HUNGER.."]")

elseif inst.strength == "ancient" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ANCIENT_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ANCIENT_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_ANCIENT_HUNGER.."]")

elseif inst.strength == "veteran" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_VETERAN_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_VETERAN_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_VETERAN_HUNGER.."]")

elseif inst.strength == "normal" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_NORMAL_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_NORMAL_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_NORMAL_HUNGER.."]")

elseif inst.strength == "midverage" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_MIDVERAGE_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_MIDVERAGE_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_MIDVERAGE_HUNGER.."]")

elseif inst.strength == "sloth" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_SLOTH_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_SLOTH_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_SLOTH_HUNGER.."]")

elseif inst.strength == "empty" then
	inst.components.talker:Say("["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_EMPTY_STRENGTH.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_EMPTY_DAMAGE.."]\n["..STRINGS.SCHWARZKIRSCHE_DESC_RAGE_EMPTY_HUNGER.."]")
end
	end
		--inst.sg:AddStateTag("notalking")
		elseif inst.keep_check then		
			inst.keep_check = false	
			--inst.components.talker:ShutUp()
			--inst.sg:RemoveStateTag("notalking")
		end
		inst:DoTaskInTime( 0.5, function()
			if inst.keep_check then
				inst.keep_check = false
				--inst.sg:RemoveStateTag("notalking") 
			end 
		end)
		----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
	end
end
AddModRPCHandler("schwarzkirsche", "SHOWSTATUS", SHOW_STATUS)

local function CHARGE_WARLOCK(inst)
	inst.writing = false
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
	for k,v in pairs(ents) do
		inst.writing = true
	end 
	if not inst.writing then
		local TheInput = TheInput
		----------------------
		----------------------
		inst.keep_check = false	
		if not inst.keep_check then		
			inst.keep_check = true	
		----------------------
if not inst.sg:HasStateTag("sleeping") then
if inst.components.inventory:Has("sch_dark_soul", 1)then
	if inst.components.schwarlock.current >= 300 then
		inst.sg:GoToState("mindcontrolled")
		inst.components.talker:Say("Too much darkness makes me crazy", 2.5)
	end
end
if inst.components.inventory:Has("sch_dark_soul", 1)then
	if inst.components.schwarlock.current < 300 then
			inst.components.inventory:ConsumeByName("sch_dark_soul", 1)
			--SpawnPrefab("statue_transition").Transform:SetPosition(inst:GetPosition():Get())
				SpawnPrefab("statue_transition_2").Transform:SetPosition(inst:GetPosition():Get())
					local fx_1 = SpawnPrefab("sch_elec_charged_fx")
						  fx_1.Transform:SetScale(0.75, 0.75, 0.75)
						  fx_1.Transform:SetPosition(inst:GetPosition():Get())
				-- inst.components.talker:Say("I feels the darkness trying to control me.", 2.5)
			inst.components.schwarlock:DoDelta(10)
				inst.components.locomotor:StopMoving()
		inst.sg:GoToState("doshortaction")
	end
end
if not inst.components.inventory:Has("sch_dark_soul", 1)then
	if inst.components.schwarlock.current <= 300 then
		inst.components.talker:Say("Now i have no more Dark Soul", 1)
	end
end
if not inst.components.inventory:Has("sch_dark_soul", 1)then
	if inst.components.schwarlock.current >= 300 then
		inst.components.talker:Say("I have Too much of Dark Power", 1)
	end
end
		--inst.sg:AddStateTag("notalking")
		elseif inst.keep_check then		
			inst.keep_check = false	
			--inst.components.talker:ShutUp()
			--inst.sg:RemoveStateTag("notalking")
		end
		inst:DoTaskInTime( 0.5, function()
			if inst.keep_check then
				inst.keep_check = false
				--inst.sg:RemoveStateTag("notalking") 
			end 
		end)
			----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
		end
	end
end
AddModRPCHandler("schwarzkirsche", "CHARGEWARLOCK", CHARGE_WARLOCK)

local function TREASURE_REVEALED(inst)
	inst.writing = false
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
	for k,v in pairs(ents) do
		inst.writing = true
	end 
	if not inst.writing then
		local TheInput = TheInput
		----------------------
		----------------------
		inst.keep_check = false	
		if not inst.keep_check then		
			inst.keep_check = true	
		----------------------
if inst.components.schtreasure.current >= 100 then
	inst.components.schtreasure:DoDelta(-100)
		inst.TalkForTreasure = false
			inst.sg:GoToState("doshortaction")
				inst.components.talker:Say("Treasure will Revealed on This Area", 2.5)
					inst:DoTaskInTime( 1.5 , function() Check_Hunted_Treasure(inst) end)
elseif inst.components.schtreasure.current < 100 then
			inst.sg:GoToState("doshortaction")
				inst.components.talker:Say("Treasure Points is not enough, Try again to Explore the Map!", 2.5)
end
		--inst.sg:AddStateTag("notalking")
		elseif inst.keep_check then		
			inst.keep_check = false	
			--inst.components.talker:ShutUp()
			--inst.sg:RemoveStateTag("notalking")
		end
		inst:DoTaskInTime( 0.5, function()
			if inst.keep_check then
				inst.keep_check = false
				--inst.sg:RemoveStateTag("notalking") 
			end 
		end)
		----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
	end
end
AddModRPCHandler("schwarzkirsche", "REVEALTHETREASURE", TREASURE_REVEALED)

local function BOOK_SKILLS(inst)
	inst.writing = false
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
	for k,v in pairs(ents) do
		inst.writing = true
	end 
	if not inst.writing then
		local TheInput = TheInput
		----------------------
		----------------------
		inst.keep_check = false	
		if not inst.keep_check then		
			inst.keep_check = true	
		----------------------
if not inst.ligtningpower  and not inst.icemaiden and not inst.theshadowmaker and not inst.mypetcompaion and not inst.sandcaster and not inst.extinguisher and not inst.fullbloom then
	inst.ligtningpower = true
	inst.theshadowmaker = false
	inst.mypetcompaion = false
	inst.icemaiden = false
	inst.sandcaster = false
	inst.extinguisher = false
	inst.fullbloom = false
		inst:RemoveTag("fullbloom")
		inst:RemoveTag("extinguisher")
		inst:AddTag("ligtningpower")
		inst:RemoveTag("theshadowmaker")
		inst:RemoveTag("mypetcompaion")
		inst:RemoveTag("sandcaster")
		inst:RemoveTag("icemaiden")
	inst.components.talker:Say("Power Lightning", 1)

elseif inst.ligtningpower and not inst.icemaiden and not inst.theshadowmaker and not inst.mypetcompaion and not inst.sandcaster and not inst.extinguisher and not inst.fullbloom then
	inst.icemaiden = true
	inst.ligtningpower = false
	inst.theshadowmaker = false
	inst.mypetcompaion = false
	inst.sandcaster = false
	inst.extinguisher = false
	inst.fullbloom = false
		inst:RemoveTag("fullbloom")
		inst:RemoveTag("extinguisher")
		inst:AddTag("icemaiden")
		inst:RemoveTag("theshadowmaker")
		inst:RemoveTag("ligtningpower")
		inst:RemoveTag("sandcaster")
		inst:RemoveTag("mypetcompaion")
	inst.components.talker:Say("Frozen Curse", 1)

elseif not inst.ligtningpower and inst.icemaiden and not inst.theshadowmaker and not inst.mypetcompaion and not inst.sandcaster and not inst.extinguisher and not inst.fullbloom then
	inst.ligtningpower = false
	inst.theshadowmaker = false
	inst.mypetcompaion = false
	inst.sandcaster = true
	inst.icemaiden = false
	inst.extinguisher = false
	inst.fullbloom = false
		inst:RemoveTag("fullbloom")
		inst:RemoveTag("extinguisher")
		inst:AddTag("sandcaster")
		inst:RemoveTag("mypetcompaion")
		inst:RemoveTag("theshadowmaker")
		inst:RemoveTag("ligtningpower")
		inst:RemoveTag("icemaiden")
	inst.components.talker:Say("Sand Castel", 1)

elseif not inst.icemaiden and not inst.ligtningpower and not inst.theshadowmaker and not inst.mypetcompaion and inst.sandcaster and not inst.extinguisher and not inst.fullbloom then
	inst.ligtningpower = false
	inst.theshadowmaker = true
	inst.mypetcompaion = false
	inst.sandcaster = false
	inst.icemaiden = false
	inst.extinguisher = false
	inst.fullbloom = false
		inst:RemoveTag("fullbloom")
		inst:RemoveTag("extinguisher")
		inst:AddTag("theshadowmaker")
		inst:RemoveTag("ligtningpower")
		inst:RemoveTag("mypetcompaion")
		inst:RemoveTag("sandcaster")
		inst:RemoveTag("icemaiden")
	inst.components.talker:Say("Dark Shadow", 1)

elseif not inst.ligtningpower and not inst.icemaiden and inst.theshadowmaker and not inst.mypetcompaion and not inst.sandcaster and not inst.extinguisher and not inst.fullbloom then
	inst.ligtningpower = false
	inst.theshadowmaker = false
	inst.sandcaster = false
	inst.mypetcompaion = true
	inst.icemaiden = false
	inst.extinguisher = false
	inst.fullbloom = false
		inst:RemoveTag("fullbloom")
		inst:RemoveTag("extinguisher")
		inst:AddTag("mypetcompaion")
		inst:RemoveTag("theshadowmaker")
		inst:RemoveTag("sandcaster")
		inst:RemoveTag("ligtningpower")
		inst:RemoveTag("icemaiden")
	inst.components.talker:Say("Piko-piko", 1)

elseif not inst.ligtningpower and not inst.icemaiden and not inst.theshadowmaker and inst.mypetcompaion and not inst.sandcaster and not inst.extinguisher and not inst.fullbloom then
	inst.ligtningpower = false
	inst.theshadowmaker = false
	inst.sandcaster = false
	inst.mypetcompaion = false
	inst.icemaiden = false
	inst.extinguisher = true
	inst.fullbloom = false
		inst:RemoveTag("fullbloom")
		inst:AddTag("extinguisher")
		inst:RemoveTag("mypetcompaion")
		inst:RemoveTag("sandcaster")
		inst:RemoveTag("theshadowmaker")
		inst:RemoveTag("ligtningpower")
		inst:RemoveTag("icemaiden")
	inst.components.talker:Say("Fluerloscher", 1)
	
elseif not inst.ligtningpower and not inst.icemaiden and not inst.theshadowmaker and not inst.mypetcompaion and not inst.sandcaster and inst.extinguisher and not inst.fullbloom then
	inst.ligtningpower = false
	inst.theshadowmaker = false
	inst.sandcaster = false
	inst.mypetcompaion = false
	inst.icemaiden = false
	inst.extinguisher = false
	inst.fullbloom = true
		inst:AddTag("fullbloom")
		inst:RemoveTag("extinguisher")
		inst:RemoveTag("mypetcompaion")
		inst:RemoveTag("sandcaster")
		inst:RemoveTag("theshadowmaker")
		inst:RemoveTag("ligtningpower")
		inst:RemoveTag("icemaiden")
	inst.components.talker:Say("Blumenkranze", 1)
	
elseif not inst.ligtningpower and not inst.icemaiden and not inst.theshadowmaker and not inst.mypetcompaion and not inst.sandcaster and not inst.extinguisher and inst.fullbloom then
	inst.ligtningpower = false
	inst.theshadowmaker = false
	inst.sandcaster = false
	inst.mypetcompaion = false
	inst.icemaiden = false
	inst.extinguisher = false
	inst.fullbloom = false
		inst:RemoveTag("fullbloom")
		inst:RemoveTag("extinguisher")
		inst:RemoveTag("mypetcompaion")
		inst:RemoveTag("sandcaster")
		inst:RemoveTag("theshadowmaker")
		inst:RemoveTag("ligtningpower")
		inst:RemoveTag("icemaiden")
	inst.components.talker:Say("All Spells Disabled", 1)
end
		--inst.sg:AddStateTag("notalking")
		elseif inst.keep_check then		
			inst.keep_check = false	
			--inst.components.talker:ShutUp()
			--inst.sg:RemoveStateTag("notalking")
		end
		inst:DoTaskInTime( 0.5, function()
			if inst.keep_check then
				inst.keep_check = false
				--inst.sg:RemoveStateTag("notalking") 
			end 
		end)
		----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
	end
end
AddModRPCHandler("schwarzkirsche", "BOOKSKILLS", BOOK_SKILLS)

local function PIKO_SKILLS(inst)
	inst.writing = false
	local x,y,z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x,y,z, 1, {"_writeable"})
	for k,v in pairs(ents) do
		inst.writing = true
	end 
	if not inst.writing then
		local TheInput = TheInput
		----------------------
		----------------------
		inst.keep_check = false	
		if not inst.keep_check then		
			inst.keep_check = true	
		----------------------
local x,y,z = inst.Transform:GetWorldPosition()
local ents = TheSim:FindEntities(x,y,z, 10)
for k,v in pairs(ents) do
if inst.components.leader:CountFollowers("pikofarmer") == 1 then
if v:HasTag("pikofarmer") and not v.CanPickUpItem1 and not v.CanPickUpItem2 and not v.CanFarming then
	inst.components.talker:Say("Piko, Let's Collecting Item!", 1)
		v.components.talker:Say("Start Collecting", 1)
			v.CanPickUpItem1 = true
			v.CanPickUpItem2 = false
				v.CanFarming = false
elseif v:HasTag("pikofarmer") and v.CanPickUpItem1 and not v.CanPickUpItem2 and not v.CanFarming then
	inst.components.talker:Say("Piko, Let's Collecting Foods!", 1)
		v.components.talker:Say("Collecting Foods", 1)
			v.CanPickUpItem1 = false
			v.CanPickUpItem2 = true
				v.CanFarming = false
elseif v:HasTag("pikofarmer") and not v.CanPickUpItem1 and v.CanPickUpItem2 and not v.CanFarming then
	inst.components.talker:Say("Piko, Let's Start Farm", 1)
		v.components.talker:Say("Start Farming", 1)
			v.CanPickUpItem1 = false
			v.CanPickUpItem2 = false
				v.CanFarming = true
elseif v:HasTag("pikofarmer") and not v.CanPickUpItem1 and not v.CanPickUpItem2 and v.CanFarming then
	inst.components.talker:Say("Piko, Stop Working", 1)
		v.components.talker:Say("Piko Stop Working", 1)
			v.components.inventory:DropEverything(true)
				v.CanPickUpItem1 = false
				v.CanPickUpItem2 = false
					v.CanFarming = false
		end
elseif inst.components.leader:CountFollowers("pikofarmer") == 0 --[[ or inst.components.leader:IsBeingFollowedBy("sch_piko_farmer")  ]]then
	inst.components.talker:Say("No Piko to Command", 1)
	end
end
		--inst.sg:AddStateTag("notalking")
		elseif inst.keep_check then		
			inst.keep_check = false	
			--inst.components.talker:ShutUp()
			--inst.sg:RemoveStateTag("notalking")
		end
		inst:DoTaskInTime( 0.5, function()
			if inst.keep_check then
				inst.keep_check = false
				--inst.sg:RemoveStateTag("notalking") 
			end 
		end)
		----inst.components.talker.colour = Vector3(0.7, 0.85, 1, 1)
	end
end
AddModRPCHandler("schwarzkirsche", "PIKOCOMMAND", PIKO_SKILLS)


----------------------[[ Container ]]-------------------------------
local params = {}
local old_widgetsetup = containers.widgetsetup
function containers.widgetsetup(container, prefab, data)
    local t = data or params[prefab or container.inst.prefab]
	local pref = prefab or container.inst.prefab
	if pref == "sch_piko" or pref == "sch_piko2nd" or pref == "sch_twin" or pref == "smartcompass" or pref == "chest5x5" then
		local t = params[pref]
		if t ~= nil then
			for k, v in pairs(t) do
				container[k] = v
			end
		container:SetNumSlots(container.widget.slotpos ~= nil and #container.widget.slotpos or 0)
		end
	else
		return old_widgetsetup(container, prefab)
	end
end

params.sch_piko =
{
	widget =
	{
		slotpos = {},
		animbank = "ui_chest_3x2",
		animbuild = "sch_ui_chest_3x2",
		pos = GLOBAL.Vector3(0, 200, 0),
		side_align_tip = 160,
	},
	type = "chest",
}
for y = 1, -0, -1 do
	for x = 0, 2 do
		table.insert(params.sch_piko.widget.slotpos, GLOBAL.Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 120, 0))
	end
end

params.sch_piko2nd =
{
	widget =
	{
		slotpos = {},
		animbank = "ui_chest_3x3",
		animbuild = "ui_chest_3x3",
		pos = GLOBAL.Vector3(0, 200, 0),
		side_align_tip = 160,
	},
	type = "chest",
}
for y = 2, 0, -1 do
	for x = 0, 2 do
		table.insert(params.sch_piko2nd.widget.slotpos, GLOBAL.Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
	end
end

params.sch_twin =
{
	widget =
	{
		slotpos = {},
		animbank = "ui_chester_shadow_3x4",
		animbuild = "ui_chester_shadow_3x4",
		pos = GLOBAL.Vector3(0, 220, 0),
		side_align_tip = 160,
	},
	type = "chest",
}
for y = 2.5, -0.5, -1 do
    for x = 0, 2 do
		table.insert(params.sch_twin.widget.slotpos, GLOBAL.Vector3(75 * x - 75 * 2 + 75, 75 * y - 75 * 2 + 75, 0))
	end
end

params.smartcompass =
{
	widget =
	{
		slotpos = {},
		animbank = "ui_oneslot_1x1",
		animbuild = "sch_ui_oneslot_1x1",
		pos = GLOBAL.Vector3(500, -300, 50),
		side_align_tip = 0,
	},
	type = "chest",
}
table.insert(params.smartcompass.widget.slotpos, GLOBAL.Vector3(0, 0, 0))


params.chest5x5 =
{
	widget =
	{
		slotpos = {},
		animbank = "ui_chest_5x5",
		animbuild = "sch_ui_chest_5x5",
		pos = GLOBAL.Vector3(0, 200, 0),
		side_align_tip = 160,
	},
	type = "chest",
}

for y = 3, -1, -1 do
	for x = -1, 3 do
		table.insert(params.chest5x5.widget.slotpos, GLOBAL.Vector3(80 * x - 80 * 2 + 80, 80 * y - 80 * 2 + 80, 0))
	end
end
	

for k, v in pairs(params) do
	containers.MAXITEMSLOTS = math.max(containers.MAXITEMSLOTS, v.widget.slotpos ~= nil and #v.widget.slotpos or 0)
end
----------------------[[ FROM TRACKER ]]-------------------------------
AddComponentPostInit("lootdropper", function(self)
	function self:GetPotentialLoot()
		local total_loot = {}

		if self.loot then
			for i,v in ipairs(self.loot) do
				table.insert(total_loot, v)
			end
		end

		if self.externalloot then
			for i,v in ipairs(self.externalloot) do
				table.insert(total_loot, v)
			end
		end

		if self.randomloot then
			for i,v in ipairs(self.randomloot) do
				if v.weight >=  4 * (self.totalrandomweight/10) then -- If the weight is bigger than 80%
					table.insert(total_loot, v.prefab)
				end
			end
		end

		if self.chanceloot then
			for i,v in ipairs(self.chanceloot) do
				if v.chance >= 1 then
					table.insert(total_loot, v.prefab)
				end
			end
		end

		return total_loot
	end
end)

-------------------------- New Sets -----------------

--[[ Next Update
local modname = KnownModIndex:GetModActualName("Schwarzkirsche")
GLOBAL.SchKeyDownSkill = GetModConfigData("sch_key_down", modname)


GLOBAL.IsPreemptiveEnemy = function(inst, target)
	return (target:HasTag("monster") 
		or (target:HasTag("epic") 
		and not target:HasTag("leif")))
		and not (target:HasTag("companion") 
		and (TheNet:GetTargetEnabled() or not target:HasTag("player"))) 
		or (target.components.combat ~= nil and target.components.combat.target == inst) 
		and target ~= inst
end
local IsPreemptiveEnemy = GLOBAL.IsPreemptiveEnemy

local function ForceStopHeavyLifting(inst) 
    if inst.components.inventory:IsHeavyLifting() then
        inst.components.inventory:DropItem(inst.components.inventory:Unequip(EQUIPSLOTS.BODY), true, true)
    end
end

local SKILL_RADIUS_DEFAULT = 12
local function GetPositionToClosestEnemy(inst, range)
	local x, y, z = inst.Transform:GetWorldPosition()
	local ents = TheSim:FindEntities(x, y, z, range or SKILL_RADIUS_DEFAULT, { "_combat" } ) -- See entityreplica.lua (for _combat tag usage)
	local target, tx, ty, tz

	for k, v in pairs(ents) do
		if v:HasTag("epic") and not v:HasTag("leif") then
			target = v; break
		elseif v ~= inst and v.components.combat ~= nil and v.components.combat.target == inst then
			target = v; break
		elseif IsPreemptiveEnemy(inst, v) then
			target = v; break
		end
	end

	if target ~= nil then
		tx, ty, tz = target.Transform:GetWorldPosition()
	end

	return tx, ty, tz
end

local function OnStartSkillGeneral(inst, shouldstop)
	inst:AddTag("inskill")
	inst.components.locomotor:Stop()
	inst.components.locomotor:Clear()
    inst:ClearBufferedAction()
	ForceStopHeavyLifting(inst)
	if shouldstop and inst.components.playercontroller ~= nil then
		inst.components.playercontroller:RemotePausePrediction()
		inst.components.playercontroller:Enable(false)
	end
	inst:PerformBufferedAction()
end

local function OnFinishSkillGeneral(inst)
	inst:RemoveTag("inskill")
	if inst.components.playercontroller ~= nil then	
		inst.components.playercontroller:Enable(true)
	end
end

local function nullfn()  -- AddAction's third argument type must be function. And I won't use action.fn at all.
	return true 
end

local function AddSkill(skillname, SgS, SgC)
	-- This is Ctor to make key-press-to-action.
	-- Does Anyone want to use this function, feel free to use it
	-- and don't forget to rename ModRPCHandler's namespace and copy nullfn.
	local upperskillname = skillname:upper()

	AddAction(upperskillname, skillname, nullfn)
	AddModRPCHandler("schwarzkirsche", skillname, function(inst) 
		inst:PushEvent("on"..skillname) 
	end)

	AddStategraphState("wilson", SgS) -- Client Stategraph
	AddStategraphState("wilson_client", SgC) -- Server Stategraph
	AddStategraphActionHandler("wilson", ActionHandler(ACTIONS[upperskillname], skillname))
	AddStategraphActionHandler("wilson_client", ActionHandler(ACTIONS[upperskillname], skillname))
end

local schlungetests_SgS = State { 
	name = "schlungetest",
	tags = { "busy", "doing", "skill", "pausepredict", "aoe", "nointerrupt", "nomorph"},

	onenter = function(inst)
		OnStartSkillGeneral(inst, true)
		local x, y, z = GetPositionToClosestEnemy(inst)
		if x ~= nil then inst:ForceFacePoint(x, y, z) end
		inst.sg:SetTimeout(12 * FRAMES)
		inst.AnimState:PlayAnimation("lunge_lag")
        inst.AnimState:PushAnimation("lunge_pst", false)

        inst.sg.statemem.angle = inst.Transform:GetRotation()
		inst.components.schwarzkirsche:OnStartRapier(inst, inst.sg.statemem.angle)
	end,

	timeline =
	{
		TimeEvent(4 * FRAMES, function(inst)
			inst.components.schwarzkirsche:Explode(inst)
			inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/swipe")
		end),
	},
	
	events = {
        EventHandler("animover", function(inst)
			if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle", true)
			end
		end),
    },
	
	ontimeout = function(inst)
		inst.components.schwarzkirsche:OnFinishCharge(inst)
		OnFinishSkillGeneral(inst)
	end,
	
	onexit = function(inst)
		inst.components.schwarzkirsche:OnFinishCharge(inst)
		OnFinishSkillGeneral(inst)
	end,
}
-------------- CLIENT --------------------
local schlungetests_SgC = State {
	name = "schlungetest",
	tags = { "doing", "attack", "skill" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
        inst.components.locomotor:Clear()
		inst.entity:FlattenMovementPrediction()
		inst.AnimState:PlayAnimation("whip_pre")
		inst.AnimState:PushAnimation("whip", false)
		inst:PerformPreviewBufferedAction()
		inst.sg:SetTimeout(11 * FRAMES)
	end,
	
	onupdate = function(inst)
		if inst.bufferedaction == nil then
			inst.sg:GoToState("idle", true)
		end
	end,

	ontimeout = function(inst)
		inst:ClearBufferedAction()
		inst.sg:GoToState("idle", inst.entity:FlattenMovementPrediction() and "noanim" or nil)
	end,
	
	onexit = function(inst)	
		inst.entity:SetIsPredictingMovement(true)
	end,
}
AddSkill("schlungetest", schlungetests_SgS, schlungetests_SgC)
-------------------- JUMP/RUN ----------------------
local schruntests_SgS = State { 
	name = "schruntest",
	tags = { "busy", "doing", "skill", "pausepredict", "nomorph" },

	onenter = function(inst)
		OnStartSkillGeneral(inst, true)
		inst.sg:SetTimeout(13 * FRAMES)
        inst.AnimState:PlayAnimation("jumpout")

		inst.components.schwarzkirsche:OnStartIgniaRun(inst)
	end,

	timeline =
	{
		TimeEvent(9 * FRAMES, function(inst) --점프무적
			inst.components.health:SetInvincible(false)
		end),
		TimeEvent(13 * FRAMES, function(inst)
			inst.SoundEmitter:PlaySound("dontstarve/movement/bodyfall_dirt")
		end),
		
	},
	
	events = {
        EventHandler("animover", function(inst)
			if inst.AnimState:AnimDone() then
				inst.sg:GoToState("idle", true)
			end
		end),
    },
	
	ontimeout = function(inst)
		inst.components.schwarzkirsche:OnFinishCharge(inst)
		OnFinishSkillGeneral(inst)
	end,
	
	onexit = function(inst)
		inst.components.schwarzkirsche:OnFinishCharge(inst)
		OnFinishSkillGeneral(inst)
	end,
}
-------------- CLIENT --------------------
local schruntests_SgC = State {
	name = "schruntest",
	tags = { "doing", "skill" },

	onenter = function(inst)
		inst.components.locomotor:Stop()
        inst.components.locomotor:Clear()
		inst.entity:FlattenMovementPrediction()
		inst.AnimState:PlayAnimation("jumpout")

		inst:PerformPreviewBufferedAction()
		inst.sg:SetTimeout(11 * FRAMES)
	end,
	
	onupdate = function(inst)
		if inst.bufferedaction == nil then
			inst.sg:GoToState("idle", true)
		end
	end,

	ontimeout = function(inst)
		inst:ClearBufferedAction()
		inst.sg:GoToState("idle", inst.entity:FlattenMovementPrediction() and "noanim" or nil)
	end,
	
	onexit = function(inst)	
		inst.entity:SetIsPredictingMovement(true)
	end,
}
AddSkill("schruntest", schruntests_SgS, schruntests_SgC)

]]--

----------------------[[ KEY MOD ]]-------------------------------
GLOBAL.TUNING.SCHWARZKIRSCHE = {}
GLOBAL.TUNING.SCHWARZKIRSCHE.KEY_1 = GetModConfigData("schwarzkirsche_current_level") or 122 -- [Z]
GLOBAL.TUNING.SCHWARZKIRSCHE.KEY_2 = GetModConfigData("schwarzkirsche_current_status") or 120 -- [X]
GLOBAL.TUNING.SCHWARZKIRSCHE.KEY_3 = GetModConfigData("schwarzkirsche_charge_warlock") or 99 -- [C]
GLOBAL.TUNING.SCHWARZKIRSCHE.KEY_4 = GetModConfigData("schwarzkirsche_reveal_theTreasure") or 114 -- [R]
GLOBAL.TUNING.SCHWARZKIRSCHE.KEY_5 = GetModConfigData("schwarzkirsche_book_skill") or 118 -- [V]
GLOBAL.TUNING.SCHWARZKIRSCHE.KEY_6 = GetModConfigData("schwarzkirsche_piko_skill") or 112 -- [P]

-- The default responses of examining the character
STRINGS.CHARACTERS.GENERIC.DESCRIBE.SCHWARZKIRSCHE = 
{
	GENERIC = "Hello, Schwarzkirsche.",
	ATTACKER = "Schwarzkirsche looks evil.",
	MURDERER = "The Killers.",
	REVIVER = "Schwarzkirsche, friend of ghost.",
	GHOST = "Schwarzkirsche could use a heart.",
}
-- The character select screen lines
STRINGS.CHARACTER_TITLES.schwarzkirsche = "Dark Dremora : Schwarzkirsche"
STRINGS.CHARACTER_NAMES.schwarzkirsche = "Schwarzkirsche"
STRINGS.CHARACTER_DESCRIPTIONS.schwarzkirsche = "*Unknown Ability\n*Blessed with Shield\n*I'm Full - I'm Stronger."
STRINGS.CHARACTER_QUOTES.schwarzkirsche = "\"Hey!\""
-- Custom speech strings
STRINGS.CHARACTERS.SCHWARZKIRSCHE = require "speech_schwarzkirsche"
-- The character's name as appears in-game 
STRINGS.NAMES.SCHWARZKIRSCHE = "Schwarzkirsche"
-- Add mod character to mod character list. 
-- Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("schwarzkirsche", "RANDOM") --- Heh Lol --- UNKNOWN