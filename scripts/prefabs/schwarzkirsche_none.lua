local assets =
{
	Asset( "ANIM", "anim/schwarzkirsche.zip" ),
	Asset( "ANIM", "anim/ghost_schwarzkirsche_build.zip" ),
}

local skins =
{
	normal_skin = "schwarzkirsche",
	ghost_skin = "ghost_schwarzkirsche_build",
}

return CreatePrefabSkin("schwarzkirsche_none",
{
	base_prefab = "schwarzkirsche",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"SCHWARZKIRSCHE", "CHARACTER", "BASE"},
	build_name = "schwarzkirsche",
	rarity = "Common",
})