
--[[
I Just use this Lua as Experiment

]]


--[[ schbloom
if inst.components.schexplevel.current >= 0 and inst.components.schexplevel.current < 375 then
	inst.components.health.maxhealth = math.ceil (100)
	inst.components.sanity.max = math.ceil (100)	
			elseif inst.components.schexplevel.current >= 375 and inst.components.schexplevel.current < 750 then
	inst.components.health.maxhealth = math.ceil (110)
	inst.components.sanity.max = math.ceil (105)	
			elseif inst.components.schexplevel.current >= 750 and inst.components.schexplevel.current < 1125 then
	inst.components.health.maxhealth = math.ceil (120)
	inst.components.sanity.max = math.ceil (110)	
			elseif inst.components.schexplevel.current >= 1125 and inst.components.schexplevel.current < 1500 then
	inst.components.health.maxhealth = math.ceil (130)
	inst.components.sanity.max = math.ceil (115)	
			elseif inst.components.schexplevel.current >= 1500 and inst.components.schexplevel.current < 1875 then
	inst.components.health.maxhealth = math.ceil (140)
	inst.components.sanity.max = math.ceil (120)	
			elseif inst.components.schexplevel.current >= 1875 and inst.components.schexplevel.current < 2250 then
	inst.components.health.maxhealth = math.ceil (150)
	inst.components.sanity.max = math.ceil (120)	
			elseif inst.components.schexplevel.current >= 2250 and inst.components.schexplevel.current < 2625 then
	inst.components.health.maxhealth = math.ceil (160)
	inst.components.sanity.max = math.ceil (125)
			elseif inst.components.schexplevel.current >= 2625 and inst.components.schexplevel.current < 3000 then
	inst.components.health.maxhealth = math.ceil (170)
	inst.components.sanity.max = math.ceil (130)
			elseif inst.components.schexplevel.current >= 3000 and inst.components.schexplevel.current < 3375 then
	inst.components.health.maxhealth = math.ceil (180)
	inst.components.sanity.max = math.ceil (135)
			elseif inst.components.schexplevel.current >= 3375 and inst.components.schexplevel.current < 3750 then
	inst.components.health.maxhealth = math.ceil (190)
	inst.components.sanity.max = math.ceil (140)
			elseif inst.components.schexplevel.current >= 3750 and inst.components.schexplevel.current < 4125 then
	inst.components.health.maxhealth = math.ceil (200)
	inst.components.sanity.max = math.ceil (145)
			elseif inst.components.schexplevel.current >= 4125 and inst.components.schexplevel.current < 4500 then
	inst.components.health.maxhealth = math.ceil (210)
	inst.components.sanity.max = math.ceil (150)
			elseif inst.components.schexplevel.current >= 4500 and inst.components.schexplevel.current < 4875 then
	inst.components.health.maxhealth = math.ceil (220)
	inst.components.sanity.max = math.ceil (155)
			elseif inst.components.schexplevel.current >= 4875 and inst.components.schexplevel.current < 5250 then
	inst.components.health.maxhealth = math.ceil (230)
	inst.components.sanity.max = math.ceil (160)
			elseif inst.components.schexplevel.current >= 5250 and inst.components.schexplevel.current < 5625 then
	inst.components.health.maxhealth = math.ceil (240)
	inst.components.sanity.max = math.ceil (165)
			elseif inst.components.schexplevel.current >= 5625 and inst.components.schexplevel.current < 6000 then
	inst.components.health.maxhealth = math.ceil (250)
	inst.components.sanity.max = math.ceil (175)
			elseif inst.components.schexplevel.current >= 6000 and inst.components.schexplevel.current < 6375 then
	inst.components.health.maxhealth = math.ceil (260)
	inst.components.sanity.max = math.ceil (180)
			elseif inst.components.schexplevel.current >= 6375 and inst.components.schexplevel.current < 6750 then
	inst.components.health.maxhealth = math.ceil (270)
	inst.components.sanity.max = math.ceil (185)
			elseif inst.components.schexplevel.current >= 6750 and inst.components.schexplevel.current < 7125 then
	inst.components.health.maxhealth = math.ceil (280)
	inst.components.sanity.max = math.ceil (190)
			elseif inst.components.schexplevel.current >= 7125 and inst.components.schexplevel.current < 7500 then
	inst.components.health.maxhealth = math.ceil (290)
	inst.components.sanity.max = math.ceil (195)
			elseif inst.components.schexplevel.current >= 7500 and inst.components.schexplevel.current < 7875 then
	inst.components.health.maxhealth = math.ceil (300)
	inst.components.sanity.max = math.ceil (200)
			elseif inst.components.schexplevel.current >= 7875 and inst.components.schexplevel.current < 8250 then
	inst.components.health.maxhealth = math.ceil (310)
	inst.components.sanity.max = math.ceil (205)
			elseif inst.components.schexplevel.current >= 8250 and inst.components.schexplevel.current < 8625 then
	inst.components.health.maxhealth = math.ceil (320)
	inst.components.sanity.max = math.ceil (210)
			elseif inst.components.schexplevel.current >= 8625 and inst.components.schexplevel.current < 9000 then
	inst.components.health.maxhealth = math.ceil (330)
	inst.components.sanity.max = math.ceil (215)
			elseif inst.components.schexplevel.current >= 9000 and inst.components.schexplevel.current < 9375 then
	inst.components.health.maxhealth = math.ceil (340)
	inst.components.sanity.max = math.ceil (220)
			elseif inst.components.schexplevel.current >= 9375 and inst.components.schexplevel.current < 9750 then
	inst.components.health.maxhealth = math.ceil (350)
	inst.components.sanity.max = math.ceil (225)
			elseif inst.components.schexplevel.current >= 9750 and inst.components.schexplevel.current < 10125 then
	inst.components.health.maxhealth = math.ceil (360)
	inst.components.sanity.max = math.ceil (230)
			elseif inst.components.schexplevel.current >= 10125 and inst.components.schexplevel.current < 10500 then
	inst.components.health.maxhealth = math.ceil (370)
	inst.components.sanity.max = math.ceil (235)
			elseif inst.components.schexplevel.current >= 10500 and inst.components.schexplevel.current < 10875 then
	inst.components.health.maxhealth = math.ceil (380)
	inst.components.sanity.max = math.ceil (240)
			elseif inst.components.schexplevel.current >= 10875 and inst.components.schexplevel.current < 11250 then
	inst.components.health.maxhealth = math.ceil (390)
	inst.components.sanity.max = math.ceil (245)
			elseif inst.components.schexplevel.current >= 11250 and inst.components.schexplevel.current < 11625 then
	inst.components.health.maxhealth = math.ceil (400)
	inst.components.sanity.max = math.ceil (250)
			elseif inst.components.schexplevel.current >= 11625 and inst.components.schexplevel.current < 12000 then
	inst.components.health.maxhealth = math.ceil (410)
	inst.components.sanity.max = math.ceil (255)
			elseif inst.components.schexplevel.current >= 12000 and inst.components.schexplevel.current < 12375 then
	inst.components.health.maxhealth = math.ceil (420)
	inst.components.sanity.max = math.ceil (260)
			elseif inst.components.schexplevel.current >= 12375 and inst.components.schexplevel.current < 12750 then
	inst.components.health.maxhealth = math.ceil (430)
	inst.components.sanity.max = math.ceil (265)
			elseif inst.components.schexplevel.current >= 12750 and inst.components.schexplevel.current < 13125 then
	inst.components.health.maxhealth = math.ceil (440)
	inst.components.sanity.max = math.ceil (270)
			elseif inst.components.schexplevel.current >= 13125 and inst.components.schexplevel.current < 13500 then
	inst.components.health.maxhealth = math.ceil (450)
	inst.components.sanity.max = math.ceil (275)
			elseif inst.components.schexplevel.current >= 13500 and inst.components.schexplevel.current < 13875 then
	inst.components.health.maxhealth = math.ceil (460)
	inst.components.sanity.max = math.ceil (280)
			elseif inst.components.schexplevel.current >= 13875 and inst.components.schexplevel.current < 14250 then
	inst.components.health.maxhealth = math.ceil (470)
	inst.components.sanity.max = math.ceil (285)
			elseif inst.components.schexplevel.current >= 14250 and inst.components.schexplevel.current < 14625 then
	inst.components.health.maxhealth = math.ceil (480)
	inst.components.sanity.max = math.ceil (290)
			elseif inst.components.schexplevel.current >= 14625 and inst.components.schexplevel.current < 15000 then
	inst.components.health.maxhealth = math.ceil (490)
	inst.components.sanity.max = math.ceil (295)
			elseif inst.components.schexplevel.current >= 15000 and inst.components.schexplevel.current < 15375 then
	inst.components.health.maxhealth = math.ceil (500)
	inst.components.sanity.max = math.ceil (300)
			elseif inst.components.schexplevel.current >= 15375 and inst.components.schexplevel.current < 15750 then
	inst.components.health.maxhealth = math.ceil (510)
	inst.components.sanity.max = math.ceil (305)
			elseif inst.components.schexplevel.current >= 15750 and inst.components.schexplevel.current < 16125 then
	inst.components.health.maxhealth = math.ceil (520)
	inst.components.sanity.max = math.ceil (310)
			elseif inst.components.schexplevel.current >= 16125 and inst.components.schexplevel.current < 16500 then
	inst.components.health.maxhealth = math.ceil (530)
	inst.components.sanity.max = math.ceil (315)
			elseif inst.components.schexplevel.current >= 16500 and inst.components.schexplevel.current < 16875 then
	inst.components.health.maxhealth = math.ceil (540)
	inst.components.sanity.max = math.ceil (320)
			elseif inst.components.schexplevel.current >= 16875 and inst.components.schexplevel.current < 17250 then
	inst.components.health.maxhealth = math.ceil (550)
	inst.components.sanity.max = math.ceil (325)
			elseif inst.components.schexplevel.current >= 17250 and inst.components.schexplevel.current < 17625 then
	inst.components.health.maxhealth = math.ceil (560)
	inst.components.sanity.max = math.ceil (330)
			elseif inst.components.schexplevel.current >= 17625 and inst.components.schexplevel.current < 18000 then
	inst.components.health.maxhealth = math.ceil (570)
	inst.components.sanity.max = math.ceil (335)
			elseif inst.components.schexplevel.current >= 18000 and inst.components.schexplevel.current < 18375 then
	inst.components.health.maxhealth = math.ceil (580)
	inst.components.sanity.max = math.ceil (340)
			elseif inst.components.schexplevel.current >= 18375 and inst.components.schexplevel.current < 18750 then
	inst.components.health.maxhealth = math.ceil (590)
	inst.components.sanity.max = math.ceil (345)
			elseif inst.components.schexplevel.current >= 18750 and inst.components.schexplevel.current < 19125 then
	inst.components.health.maxhealth = math.ceil (600)
	inst.components.sanity.max = math.ceil (350)
			elseif inst.components.schexplevel.current >= 19125 and inst.components.schexplevel.current < 19500 then
	inst.components.health.maxhealth = math.ceil (610)
	inst.components.sanity.max = math.ceil (355)
			elseif inst.components.schexplevel.current >= 19500 and inst.components.schexplevel.current < 19875 then
	inst.components.health.maxhealth = math.ceil (620)
	inst.components.sanity.max = math.ceil (360)
			elseif inst.components.schexplevel.current >= 19875 and inst.components.schexplevel.current < 20250 then
	inst.components.health.maxhealth = math.ceil (630)
	inst.components.sanity.max = math.ceil (365)
			elseif inst.components.schexplevel.current >= 20250 and inst.components.schexplevel.current < 20625 then
	inst.components.health.maxhealth = math.ceil (640)
	inst.components.sanity.max = math.ceil (370)
			elseif inst.components.schexplevel.current >= 20625 and inst.components.schexplevel.current < 21000 then
	inst.components.health.maxhealth = math.ceil (650)
	inst.components.sanity.max = math.ceil (375)
			elseif inst.components.schexplevel.current >= 21000 and inst.components.schexplevel.current < 21375 then
	inst.components.health.maxhealth = math.ceil (660)
	inst.components.sanity.max = math.ceil (380)
			elseif inst.components.schexplevel.current >= 21375 and inst.components.schexplevel.current < 21750 then
	inst.components.health.maxhealth = math.ceil (670)
	inst.components.sanity.max = math.ceil (385)
			elseif inst.components.schexplevel.current >= 21750 and inst.components.schexplevel.current < 22125 then
	inst.components.health.maxhealth = math.ceil (680)
	inst.components.sanity.max = math.ceil (390)
			elseif inst.components.schexplevel.current >= 22125 and inst.components.schexplevel.current < 22500 then
	inst.components.health.maxhealth = math.ceil (690)
	inst.components.sanity.max = math.ceil (395)
			elseif inst.components.schexplevel.current >= 22500 and inst.components.schexplevel.current < 22875 then
	inst.components.health.maxhealth = math.ceil (700)
	inst.components.sanity.max = math.ceil (400)
			elseif inst.components.schexplevel.current >= 22875 and inst.components.schexplevel.current < 23250 then
	inst.components.health.maxhealth = math.ceil (710)
	inst.components.sanity.max = math.ceil (405)
			elseif inst.components.schexplevel.current >= 23250 and inst.components.schexplevel.current < 23625 then
	inst.components.health.maxhealth = math.ceil (720)
	inst.components.sanity.max = math.ceil (410)
			elseif inst.components.schexplevel.current >= 23625 and inst.components.schexplevel.current < 24000 then
	inst.components.health.maxhealth = math.ceil (730)
	inst.components.sanity.max = math.ceil (415)
			elseif inst.components.schexplevel.current >= 24000 and inst.components.schexplevel.current < 24375 then
	inst.components.health.maxhealth = math.ceil (740)
	inst.components.sanity.max = math.ceil (420)
			elseif inst.components.schexplevel.current >= 24375 and inst.components.schexplevel.current < 24750 then
	inst.components.health.maxhealth = math.ceil (750)
	inst.components.sanity.max = math.ceil (425)
			elseif inst.components.schexplevel.current >= 24750 and inst.components.schexplevel.current < 25125 then
	inst.components.health.maxhealth = math.ceil (760)
	inst.components.sanity.max = math.ceil (430)
			elseif inst.components.schexplevel.current >= 25125 and inst.components.schexplevel.current < 25500 then
	inst.components.health.maxhealth = math.ceil (770)
	inst.components.sanity.max = math.ceil (435)
			elseif inst.components.schexplevel.current >= 25500 and inst.components.schexplevel.current < 25875 then
	inst.components.health.maxhealth = math.ceil (780)
	inst.components.sanity.max = math.ceil (440)
			elseif inst.components.schexplevel.current >= 25875 and inst.components.schexplevel.current < 26250 then
	inst.components.health.maxhealth = math.ceil (790)
	inst.components.sanity.max = math.ceil (445)
			elseif inst.components.schexplevel.current >= 26250 and inst.components.schexplevel.current < 26625 then
	inst.components.health.maxhealth = math.ceil (800)
	inst.components.sanity.max = math.ceil (450)
			elseif inst.components.schexplevel.current >= 26625 and inst.components.schexplevel.current < 27000 then
	inst.components.health.maxhealth = math.ceil (810)
	inst.components.sanity.max = math.ceil (455)
			elseif inst.components.schexplevel.current >= 27000 and inst.components.schexplevel.current < 27375 then
	inst.components.health.maxhealth = math.ceil (820)
	inst.components.sanity.max = math.ceil (460)
			elseif inst.components.schexplevel.current >= 27375 and inst.components.schexplevel.current < 27750 then
	inst.components.health.maxhealth = math.ceil (830)
	inst.components.sanity.max = math.ceil (465)
			elseif inst.components.schexplevel.current >= 27750 and inst.components.schexplevel.current < 28125 then
	inst.components.health.maxhealth = math.ceil (840)
	inst.components.sanity.max = math.ceil (470)
			elseif inst.components.schexplevel.current >= 28125 and inst.components.schexplevel.current < 28500 then
	inst.components.health.maxhealth = math.ceil (850)
	inst.components.sanity.max = math.ceil (475)
			elseif inst.components.schexplevel.current >= 28500 and inst.components.schexplevel.current < 28875 then
	inst.components.health.maxhealth = math.ceil (860)
	inst.components.sanity.max = math.ceil (480)
			elseif inst.components.schexplevel.current >= 28875 and inst.components.schexplevel.current < 29250 then
	inst.components.health.maxhealth = math.ceil (870)
	inst.components.sanity.max = math.ceil (485)
			elseif inst.components.schexplevel.current >= 29250 and inst.components.schexplevel.current < 30000 then
	inst.components.health.maxhealth = math.ceil (880)
	inst.components.sanity.max = math.ceil (490)
			elseif inst.components.schexplevel.current >= 30000 and inst.components.schexplevel.current < 30375 then
	inst.components.health.maxhealth = math.ceil (890)
	inst.components.sanity.max = math.ceil (495)
			elseif inst.components.schexplevel.current >= 30375 then
	inst.components.health.maxhealth = math.ceil (900)
	inst.components.sanity.max = math.ceil (500)
			end
			]]--
			
			
			-- Status display for Schwarzkirsche Components
--[[
inst:DoTaskInTime( 0, function() 
	local controls = inst.HUD.controls
	local SchBadgeStatusDisplay = require "widgets/schbadgestatusdisplay"
		controls.SchBadge = controls:AddChild(SchBadgeStatusDisplay(inst))
		controls.SchBadge:SetPosition(0, 0, 0)
end)	
]]--

--[[
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
]]
--[[
sch treasure - dig up
old method
--------------------- Done to test but not can't Give Stack
		---------- Alive/Other (Non Stackable) : Slot 1 [Fresh 1 Non Fresh 1]
	local item1 = {	"canary",
					"robin",
					"robin_winter",
					"crow",
					"rabbit",
					"horn",	
					"goldenaxe",	
					"goldenpickaxe",	
					"goldenshovel",	
					"umbrella",	
					"trunkvest_winter",	
					"trunkvest_summer",	
					}
	local randomitem1 = item1[math.random(#item1)]
	local randomitemloot1 = SpawnPrefab(randomitem1)

		---------- Alive (Stackable) : Slot 2 [Fresh 2]
	local item2 = {	"bee", 
					"killerbee",
					"eel",
					"butterfly",
					"mosquito",
					"fish",	}

	local randomitem2 = item2[math.random(#item2)]
	local randomitemloot2 = SpawnPrefab(randomitem2, 2)
			
		---------- Stackable : Slot 3 [Fresh 3]
	local item3 = {	"bird_egg",
					"froglegs",
					"ice",
					"acorn",
					"cutlichen",
					"foliage",
					"succulent_picked",
					"goatmilk",
					"red_cap",
					"blue_cap",
					"green_cap",
					"lightbulb",
					"petals_evil",	}
	local randomitem3 = item3[math.random(#item3)]
	local randomitemloot3 = SpawnPrefab(randomitem3, 4)
			
		---------- Stackable : Slot 4 [Fresh 4] : Foods
	local item4 = {	"spoiled_food",
					"wetgoop",
					"powcake",
					"monsterlasagna",
					"yotp_food3",
					"yotp_food1",
					"meatballs",
					"honeyham",
					"taffy",
					"unagi",
					"honey",
					"wormlight",	}
	local randomitem4 = item4[math.random(#item4)]
	local randomitemloot4 = SpawnPrefab(randomitem4, 3)
		
		---------- Stackable : Slot 5 [Non Fresh 4] : Common
	local item5 = {	"twigs",
					"rocks",
					"cutgrass",
					"cutreeds",
					"flint",
					"log",
					"nitre",
					"marble",
					"goldnugget",	}
	local randomitem5 = item5[math.random(#item5)]
	local randomitemloot5 = SpawnPrefab(randomitem5, 10)
			
		---------- Stackable : Slot 6 [Non Fresh 4] : Hunt
	local item6 = {	"pigskin",
					"tentaclespots",
					"stinger",
					"feather_crow",
					"feather_robin",
					"feather_robin_winter",
					"feather_canary",
					"silk",
					"beefalowool",
					"manrabbit_tail",
					"coontail",	
					"nightmarefuel",	}
	local randomitem6 = item6[math.random(#item6)]
	local randomitemloot6 = SpawnPrefab(randomitem6, 5)
			
		---------- Stackable : Slot 7 [Non Fresh 4] : Revinable + Other
	local item7 = {	"rope",
					"cutstone",
					"boards",
					"papyrus",	
					"waxpaper",	
					"marblebean",	
					---
					"charcoal",
					"ash",
					"boneshard",
					"honeycomb",
					"furtuft",
					"glommerfuel",
					"bandage",
					"healingsalve",
					--"glommerwings",
					}
	local randomitem7 = item7[math.random(#item7)]
	local randomitemloot7 = SpawnPrefab(randomitem7, 10)
	
			---------- Stackable : Slot 8 [Fresh & Non Fresh 4] : Rare + Gems
	local item8 = {	"moonrocknugget",
					"beardhair",
					"slurper_pelt",
					"slurtleslime",
					"steelwool",
					"lightninggoathorn",
					"gears",
					"thulecite",
					"thulecite_pieces",
					"mandrake",
					"wall_ruins_item",
					"shroom_skin",
					"livinglog",
					---
					"royal_jelly",	
					---
					"redgem",
					"bluegem",
					"greengem",
					"purplegem",
					"yellowgem",
					"orangegem",
					"opalpreciousgem",}
	local randomitem8 = item8[math.random(#item8)]
	local randomitemloot8 = SpawnPrefab(randomitem8, 3)

			----------Non Stackable : Slot 8 [Fresh & Non Fresh 4] : Rare/Armor/Weapon
	local item9 = {	"dragonflychest_blueprint",
					"dragonflyfurnace_blueprint",
					"red_mushroomhat_blueprint",
					"green_mushroomhat_blueprint",
					"blue_mushroomhat_blueprint",
					"mushroom_light2_blueprint",
					"sleepbomb_blueprint",
					"bundlewrap_blueprint",
					"townportal_blueprint",
					"rabbithouse_blueprint",
					"deserthat_blueprint",	
					---
					"spear_wathgrithr", 
					"wathgrithrhat", 
					"spear", 
					"nightstick", 
					"armorgrass", 
					"armorwood", 
					"armormarble", 
					"footballhat", 
					"boomerang", 
					"beemine", 
					"trap_teeth", 
					"staff_tornado", 
					"armordragonfly", 
					"armorruins", 
					"ruinshat", 
					"ruins_bat", 
					"eyeturret_item", 
					---
					"panflute",
					"onemanband",
					"armor_sanity",
					"batbat",
					"nightsword",
					"armorslurper",
					---
					"amulet",
					"blueamulet",
					"purpleamulet",
					"firestaff",
					"icestaff",
					"telestaff",
					"orangeamulet",
					"yellowamulet",
					"greenamulet",
					"orangestaff",
					"yellowstaff",
					"greenstaff",
					"opalstaff",
					"multitool_axe_pickaxe",
					--- My Book
					"book_birds",
					"book_gardening",
					"book_sleep",
					"book_brimstone",
					"book_tentacles", }
	local randomitem9 = item9[math.random(#item9)]
	local randomitemloot9 = SpawnPrefab(randomitem9)
	
treasure_chest.components.container:GiveItem(randomitemloot1)
treasure_chest.components.container:GiveItem(randomitemloot2)
treasure_chest.components.container:GiveItem(randomitemloot3)
treasure_chest.components.container:GiveItem(randomitemloot4)
treasure_chest.components.container:GiveItem(randomitemloot5)
treasure_chest.components.container:GiveItem(randomitemloot6)
treasure_chest.components.container:GiveItem(randomitemloot7)
treasure_chest.components.container:GiveItem(randomitemloot8)
treasure_chest.components.container:GiveItem(randomitemloot9)
]]


--[[

inst.sg:GoToState("parry_hit")
inst.sg:GoToState("parry_knockback")
inst.sg:GoToState("fertilize") 
inst.sg:GoToState("hit_darkness")

]]

 













































































