name = "Schwarzkirsche"
description = "Schwarzkirsche is mixed character from other character on dst or other mods. Keep in mind if you enable multiple other from mods, this mods might broken/error or not working. Currently we are (i'm) trying to make this mod can be played on ds, sw, or even hamlet. So, be patient."
author = "Kobayashi Yashiro"
version = "1.2.9.8"

forumthread = ""

api_version = 10
priority = 0.10

client_only_mod = false
server_only_mod = true
all_clients_require_mod = true

dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
shipwrecked_compatible = false
hamlet_compatible = false

icon_atlas = "modicon.xml"
icon = "modicon.tex"

server_filter_tags = { "Schwarzkirsche", "Character" }

folder_name = folder_name or ""
if not folder_name:find("workshop-") then
    name = name.." - Mixed"
end

local Keys = {
	"A", "B", "C", "D", "E", 
	"F", "G", "H", "I", "J", 
	"K", "L", "M", "N", "O", 
	"P", "Q", "R", "S", "T", 
	"U", "V", "W", "X", "Y", 
	"Z", 
	
	"PERIOD", "SLASH", 
	"SEMICOLON", "TILDE", 
	
	"1", "2", "3", "4", "5", 
	"6", "7", "8", "9", "0", 
	
	"F1", "F2", "F3", 
	"F4", "F5", "F6", 
	"F7", "F8", "F9", 
	"F10", "F11", "F12", 
	
	"INSERT", "DELETE", 
	"HOME", "END", 
	"PAGEUP", "PAGEDOWN", 
	"MINUS", "EQUALS", 
	"BACKSPACE", "CAPSLOCK", 
	"SCROLLOCK", "BACKSLASH",
}

local KeyOptions = {}
for i = 1, #Keys do KeyOptions[i] = { description = ""..Keys[i].."", data = "KEY_"..Keys[i] } end

configuration_options = {

--[[ Next update

	{
		name = "sch_key_down",
		label = "O = JUMP / SHIFT+O = RUN DASH",
		hover = "[JUMP AND RUN DASH] Keybind",
		options = KeyOptions,
		default = "KEY_O",
	},
	
	]]
	
	{
        name = "schwarzkirsche_current_level",
        label = "Info Exp and Level",
        hover = "Button to check your current Exp and Level",
        options =
        {
            {description="TAB", data = 9},
            {description="KP_PERIOD", data = 266},
            {description="KP_DIVIDE", data = 267},
            {description="KP_MULTIPLY", data = 268},
            {description="KP_MINUS", data = 269},
            {description="KP_PLUS", data = 270},
            {description="KP_ENTER", data = 271},
            {description="KP_EQUALS", data = 272},
            {description="MINUS", data = 45},
            {description="EQUALS", data = 61},
            {description="SPACE", data = 32},
            {description="ENTER", data = 13},
            {description="ESCAPE", data = 27},
            {description="HOME", data = 278},
            {description="INSERT", data = 277},
            {description="DELETE", data = 127},
            {description="END", data   = 279},
            {description="PAUSE", data = 19},
            {description="PRINT", data = 316},
            {description="CAPSLOCK", data = 301},
            {description="SCROLLOCK", data = 302},
            {description="RSHIFT", data = 303}, -- use SHIFT instead
            {description="LSHIFT", data = 304}, -- use SHIFT instead
            {description="RCTRL", data = 305}, -- use CTRL instead
            {description="LCTRL", data = 306}, -- use CTRL instead
            {description="RALT", data = 307}, -- use ALT instead
            {description="LALT", data = 308}, -- use ALT instead
            {description="ALT", data = 400},
            {description="CTRL", data = 401},
            {description="SHIFT", data = 402},
            {description="BACKSPACE", data = 8},
            {description="PERIOD", data = 46},
            {description="SLASH", data = 47},
            {description="LEFTBRACKET", data     = 91},
            {description="BACKSLASH", data     = 92},
            {description="RIGHTBRACKET", data = 93},
            {description="TILDE", data = 96},
            {description="A", data = 97},
            {description="B", data = 98},
            {description="C", data = 99},
            {description="D", data = 100},
            {description="E", data = 101},
            {description="F", data = 102},
            {description="G", data = 103},
            {description="H", data = 104},
            {description="I", data = 105},
            {description="J", data = 106},
            {description="K", data = 107},
            {description="L", data = 108},
            {description="M", data = 109},
            {description="N", data = 110},
            {description="O", data = 111},
            {description="P", data = 112},
            {description="Q", data = 113},
            {description="R", data = 114},
            {description="S", data = 115},
            {description="T", data = 116},
            {description="U", data = 117},
            {description="V", data = 118},
            {description="W", data = 119},
            {description="X", data = 120},
            {description="Y", data = 121},
            {description="Z", data = 122},
            {description="F1", data = 282},
            {description="F2", data = 283},
            {description="F3", data = 284},
            {description="F4", data = 285},
            {description="F5", data = 286},
            {description="F6", data = 287},
            {description="F7", data = 288},
            {description="F8", data = 289},
            {description="F9", data = 290},
            {description="F10", data = 291},
            {description="F11", data = 292},
            {description="F12", data = 293},
 
            {description="UP", data = 273},
            {description="DOWN", data = 274},
            {description="RIGHT", data = 275},
            {description="LEFT", data = 276},
            {description="PAGEUP", data = 280},
            {description="PAGEDOWN", data = 281},
 
            {description="0", data = 48},
            {description="1", data = 49},
            {description="2", data = 50},
            {description="3", data = 51},
            {description="4", data = 52},
            {description="5", data = 53},
            {description="6", data = 54},
            {description="7", data = 55},
            {description="8", data = 56},
            {description="9", data = 57},
        },
        default = 122,
    },
{
        name = "schwarzkirsche_current_status",
        label = "Info Strength",
        hover = "Button to see your Current Damage Multiplier.",
        options =
        {
            {description="TAB", data = 9},
            {description="KP_PERIOD", data = 266},
            {description="KP_DIVIDE", data = 267},
            {description="KP_MULTIPLY", data = 268},
            {description="KP_MINUS", data = 269},
            {description="KP_PLUS", data = 270},
            {description="KP_ENTER", data = 271},
            {description="KP_EQUALS", data = 272},
            {description="MINUS", data = 45},
            {description="EQUALS", data = 61},
            {description="SPACE", data = 32},
            {description="ENTER", data = 13},
            {description="ESCAPE", data = 27},
            {description="HOME", data = 278},
            {description="INSERT", data = 277},
            {description="DELETE", data = 127},
            {description="END", data   = 279},
            {description="PAUSE", data = 19},
            {description="PRINT", data = 316},
            {description="CAPSLOCK", data = 301},
            {description="SCROLLOCK", data = 302},
            {description="RSHIFT", data = 303}, -- use SHIFT instead
            {description="LSHIFT", data = 304}, -- use SHIFT instead
            {description="RCTRL", data = 305}, -- use CTRL instead
            {description="LCTRL", data = 306}, -- use CTRL instead
            {description="RALT", data = 307}, -- use ALT instead
            {description="LALT", data = 308}, -- use ALT instead
            {description="ALT", data = 400},
            {description="CTRL", data = 401},
            {description="SHIFT", data = 402},
            {description="BACKSPACE", data = 8},
            {description="PERIOD", data = 46},
            {description="SLASH", data = 47},
            {description="LEFTBRACKET", data     = 91},
            {description="BACKSLASH", data     = 92},
            {description="RIGHTBRACKET", data = 93},
            {description="TILDE", data = 96},
            {description="A", data = 97},
            {description="B", data = 98},
            {description="C", data = 99},
            {description="D", data = 100},
            {description="E", data = 101},
            {description="F", data = 102},
            {description="G", data = 103},
            {description="H", data = 104},
            {description="I", data = 105},
            {description="J", data = 106},
            {description="K", data = 107},
            {description="L", data = 108},
            {description="M", data = 109},
            {description="N", data = 110},
            {description="O", data = 111},
            {description="P", data = 112},
            {description="Q", data = 113},
            {description="R", data = 114},
            {description="S", data = 115},
            {description="T", data = 116},
            {description="U", data = 117},
            {description="V", data = 118},
            {description="W", data = 119},
            {description="X", data = 120},
            {description="Y", data = 121},
            {description="Z", data = 122},
            {description="F1", data = 282},
            {description="F2", data = 283},
            {description="F3", data = 284},
            {description="F4", data = 285},
            {description="F5", data = 286},
            {description="F6", data = 287},
            {description="F7", data = 288},
            {description="F8", data = 289},
            {description="F9", data = 290},
            {description="F10", data = 291},
            {description="F11", data = 292},
            {description="F12", data = 293},
 
            {description="UP", data = 273},
            {description="DOWN", data = 274},
            {description="RIGHT", data = 275},
            {description="LEFT", data = 276},
            {description="PAGEUP", data = 280},
            {description="PAGEDOWN", data = 281},
 
            {description="0", data = 48},
            {description="1", data = 49},
            {description="2", data = 50},
            {description="3", data = 51},
            {description="4", data = 52},
            {description="5", data = 53},
            {description="6", data = 54},
            {description="7", data = 55},
            {description="8", data = 56},
            {description="9", data = 57},
        },
        default = 120,
    },
{
        name = "schwarzkirsche_charge_warlock",
        label = "Charge Magic (Warlock)",
        hover = "Button to Consume 1 Dark Soul to Charge your Warlock by 10.",
        options =
        {
            {description="TAB", data = 9},
            {description="KP_PERIOD", data = 266},
            {description="KP_DIVIDE", data = 267},
            {description="KP_MULTIPLY", data = 268},
            {description="KP_MINUS", data = 269},
            {description="KP_PLUS", data = 270},
            {description="KP_ENTER", data = 271},
            {description="KP_EQUALS", data = 272},
            {description="MINUS", data = 45},
            {description="EQUALS", data = 61},
            {description="SPACE", data = 32},
            {description="ENTER", data = 13},
            {description="ESCAPE", data = 27},
            {description="HOME", data = 278},
            {description="INSERT", data = 277},
            {description="DELETE", data = 127},
            {description="END", data   = 279},
            {description="PAUSE", data = 19},
            {description="PRINT", data = 316},
            {description="CAPSLOCK", data = 301},
            {description="SCROLLOCK", data = 302},
            {description="RSHIFT", data = 303}, -- use SHIFT instead
            {description="LSHIFT", data = 304}, -- use SHIFT instead
            {description="RCTRL", data = 305}, -- use CTRL instead
            {description="LCTRL", data = 306}, -- use CTRL instead
            {description="RALT", data = 307}, -- use ALT instead
            {description="LALT", data = 308}, -- use ALT instead
            {description="ALT", data = 400},
            {description="CTRL", data = 401},
            {description="SHIFT", data = 402},
            {description="BACKSPACE", data = 8},
            {description="PERIOD", data = 46},
            {description="SLASH", data = 47},
            {description="LEFTBRACKET", data     = 91},
            {description="BACKSLASH", data     = 92},
            {description="RIGHTBRACKET", data = 93},
            {description="TILDE", data = 96},
            {description="A", data = 97},
            {description="B", data = 98},
            {description="C", data = 99},
            {description="D", data = 100},
            {description="E", data = 101},
            {description="F", data = 102},
            {description="G", data = 103},
            {description="H", data = 104},
            {description="I", data = 105},
            {description="J", data = 106},
            {description="K", data = 107},
            {description="L", data = 108},
            {description="M", data = 109},
            {description="N", data = 110},
            {description="O", data = 111},
            {description="P", data = 112},
            {description="Q", data = 113},
            {description="R", data = 114},
            {description="S", data = 115},
            {description="T", data = 116},
            {description="U", data = 117},
            {description="V", data = 118},
            {description="W", data = 119},
            {description="X", data = 120},
            {description="Y", data = 121},
            {description="Z", data = 122},
            {description="F1", data = 282},
            {description="F2", data = 283},
            {description="F3", data = 284},
            {description="F4", data = 285},
            {description="F5", data = 286},
            {description="F6", data = 287},
            {description="F7", data = 288},
            {description="F8", data = 289},
            {description="F9", data = 290},
            {description="F10", data = 291},
            {description="F11", data = 292},
            {description="F12", data = 293},
 
            {description="UP", data = 273},
            {description="DOWN", data = 274},
            {description="RIGHT", data = 275},
            {description="LEFT", data = 276},
            {description="PAGEUP", data = 280},
            {description="PAGEDOWN", data = 281},
 
            {description="0", data = 48},
            {description="1", data = 49},
            {description="2", data = 50},
            {description="3", data = 51},
            {description="4", data = 52},
            {description="5", data = 53},
            {description="6", data = 54},
            {description="7", data = 55},
            {description="8", data = 56},
            {description="9", data = 57},
        },
        default = 99,
    },
{
        name = "schwarzkirsche_reveal_theTreasure",
        label = "Reveal the Treasure",
        hover = "Button to Reveal the Treasure when the Treasure Badge is Full",
        options =
        {
            {description="TAB", data = 9},
            {description="KP_PERIOD", data = 266},
            {description="KP_DIVIDE", data = 267},
            {description="KP_MULTIPLY", data = 268},
            {description="KP_MINUS", data = 269},
            {description="KP_PLUS", data = 270},
            {description="KP_ENTER", data = 271},
            {description="KP_EQUALS", data = 272},
            {description="MINUS", data = 45},
            {description="EQUALS", data = 61},
            {description="SPACE", data = 32},
            {description="ENTER", data = 13},
            {description="ESCAPE", data = 27},
            {description="HOME", data = 278},
            {description="INSERT", data = 277},
            {description="DELETE", data = 127},
            {description="END", data   = 279},
            {description="PAUSE", data = 19},
            {description="PRINT", data = 316},
            {description="CAPSLOCK", data = 301},
            {description="SCROLLOCK", data = 302},
            {description="RSHIFT", data = 303}, -- use SHIFT instead
            {description="LSHIFT", data = 304}, -- use SHIFT instead
            {description="RCTRL", data = 305}, -- use CTRL instead
            {description="LCTRL", data = 306}, -- use CTRL instead
            {description="RALT", data = 307}, -- use ALT instead
            {description="LALT", data = 308}, -- use ALT instead
            {description="ALT", data = 400},
            {description="CTRL", data = 401},
            {description="SHIFT", data = 402},
            {description="BACKSPACE", data = 8},
            {description="PERIOD", data = 46},
            {description="SLASH", data = 47},
            {description="LEFTBRACKET", data     = 91},
            {description="BACKSLASH", data     = 92},
            {description="RIGHTBRACKET", data = 93},
            {description="TILDE", data = 96},
            {description="A", data = 97},
            {description="B", data = 98},
            {description="C", data = 99},
            {description="D", data = 100},
            {description="E", data = 101},
            {description="F", data = 102},
            {description="G", data = 103},
            {description="H", data = 104},
            {description="I", data = 105},
            {description="J", data = 106},
            {description="K", data = 107},
            {description="L", data = 108},
            {description="M", data = 109},
            {description="N", data = 110},
            {description="O", data = 111},
            {description="P", data = 112},
            {description="Q", data = 113},
            {description="R", data = 114},
            {description="S", data = 115},
            {description="T", data = 116},
            {description="U", data = 117},
            {description="V", data = 118},
            {description="W", data = 119},
            {description="X", data = 120},
            {description="Y", data = 121},
            {description="Z", data = 122},
            {description="F1", data = 282},
            {description="F2", data = 283},
            {description="F3", data = 284},
            {description="F4", data = 285},
            {description="F5", data = 286},
            {description="F6", data = 287},
            {description="F7", data = 288},
            {description="F8", data = 289},
            {description="F9", data = 290},
            {description="F10", data = 291},
            {description="F11", data = 292},
            {description="F12", data = 293},
 
            {description="UP", data = 273},
            {description="DOWN", data = 274},
            {description="RIGHT", data = 275},
            {description="LEFT", data = 276},
            {description="PAGEUP", data = 280},
            {description="PAGEDOWN", data = 281},
 
            {description="0", data = 48},
            {description="1", data = 49},
            {description="2", data = 50},
            {description="3", data = 51},
            {description="4", data = 52},
            {description="5", data = 53},
            {description="6", data = 54},
            {description="7", data = 55},
            {description="8", data = 56},
            {description="9", data = 57},
        },
        default = 114,
    },
	{
        name = "schwarzkirsche_book_skill",
        label = "Change Book Skill : Read Book",
        hover = "Button to change book for : Lightning Skill, Calling Shadow Worker, Defense, etc. ",
        options =
        {
            {description="TAB", data = 9},
            {description="KP_PERIOD", data = 266},
            {description="KP_DIVIDE", data = 267},
            {description="KP_MULTIPLY", data = 268},
            {description="KP_MINUS", data = 269},
            {description="KP_PLUS", data = 270},
            {description="KP_ENTER", data = 271},
            {description="KP_EQUALS", data = 272},
            {description="MINUS", data = 45},
            {description="EQUALS", data = 61},
            {description="SPACE", data = 32},
            {description="ENTER", data = 13},
            {description="ESCAPE", data = 27},
            {description="HOME", data = 278},
            {description="INSERT", data = 277},
            {description="DELETE", data = 127},
            {description="END", data   = 279},
            {description="PAUSE", data = 19},
            {description="PRINT", data = 316},
            {description="CAPSLOCK", data = 301},
            {description="SCROLLOCK", data = 302},
            {description="RSHIFT", data = 303}, -- use SHIFT instead
            {description="LSHIFT", data = 304}, -- use SHIFT instead
            {description="RCTRL", data = 305}, -- use CTRL instead
            {description="LCTRL", data = 306}, -- use CTRL instead
            {description="RALT", data = 307}, -- use ALT instead
            {description="LALT", data = 308}, -- use ALT instead
            {description="ALT", data = 400},
            {description="CTRL", data = 401},
            {description="SHIFT", data = 402},
            {description="BACKSPACE", data = 8},
            {description="PERIOD", data = 46},
            {description="SLASH", data = 47},
            {description="LEFTBRACKET", data     = 91},
            {description="BACKSLASH", data     = 92},
            {description="RIGHTBRACKET", data = 93},
            {description="TILDE", data = 96},
            {description="A", data = 97},
            {description="B", data = 98},
            {description="C", data = 99},
            {description="D", data = 100},
            {description="E", data = 101},
            {description="F", data = 102},
            {description="G", data = 103},
            {description="H", data = 104},
            {description="I", data = 105},
            {description="J", data = 106},
            {description="K", data = 107},
            {description="L", data = 108},
            {description="M", data = 109},
            {description="N", data = 110},
            {description="O", data = 111},
            {description="P", data = 112},
            {description="Q", data = 113},
            {description="R", data = 114},
            {description="S", data = 115},
            {description="T", data = 116},
            {description="U", data = 117},
            {description="V", data = 118},
            {description="W", data = 119},
            {description="X", data = 120},
            {description="Y", data = 121},
            {description="Z", data = 122},
            {description="F1", data = 282},
            {description="F2", data = 283},
            {description="F3", data = 284},
            {description="F4", data = 285},
            {description="F5", data = 286},
            {description="F6", data = 287},
            {description="F7", data = 288},
            {description="F8", data = 289},
            {description="F9", data = 290},
            {description="F10", data = 291},
            {description="F11", data = 292},
            {description="F12", data = 293},
 
            {description="UP", data = 273},
            {description="DOWN", data = 274},
            {description="RIGHT", data = 275},
            {description="LEFT", data = 276},
            {description="PAGEUP", data = 280},
            {description="PAGEDOWN", data = 281},
 
            {description="0", data = 48},
            {description="1", data = 49},
            {description="2", data = 50},
            {description="3", data = 51},
            {description="4", data = 52},
            {description="5", data = 53},
            {description="6", data = 54},
            {description="7", data = 55},
            {description="8", data = 56},
            {description="9", data = 57},
        },
        default = 118,
    },
	{
        name = "schwarzkirsche_piko_skill",
        label = "Piko Command",
        hover = "Button to command your farmer piko to to gather, collecting, item.",
        options =
        {
            {description="TAB", data = 9},
            {description="KP_PERIOD", data = 266},
            {description="KP_DIVIDE", data = 267},
            {description="KP_MULTIPLY", data = 268},
            {description="KP_MINUS", data = 269},
            {description="KP_PLUS", data = 270},
            {description="KP_ENTER", data = 271},
            {description="KP_EQUALS", data = 272},
            {description="MINUS", data = 45},
            {description="EQUALS", data = 61},
            {description="SPACE", data = 32},
            {description="ENTER", data = 13},
            {description="ESCAPE", data = 27},
            {description="HOME", data = 278},
            {description="INSERT", data = 277},
            {description="DELETE", data = 127},
            {description="END", data   = 279},
            {description="PAUSE", data = 19},
            {description="PRINT", data = 316},
            {description="CAPSLOCK", data = 301},
            {description="SCROLLOCK", data = 302},
            {description="RSHIFT", data = 303}, -- use SHIFT instead
            {description="LSHIFT", data = 304}, -- use SHIFT instead
            {description="RCTRL", data = 305}, -- use CTRL instead
            {description="LCTRL", data = 306}, -- use CTRL instead
            {description="RALT", data = 307}, -- use ALT instead
            {description="LALT", data = 308}, -- use ALT instead
            {description="ALT", data = 400},
            {description="CTRL", data = 401},
            {description="SHIFT", data = 402},
            {description="BACKSPACE", data = 8},
            {description="PERIOD", data = 46},
            {description="SLASH", data = 47},
            {description="LEFTBRACKET", data     = 91},
            {description="BACKSLASH", data     = 92},
            {description="RIGHTBRACKET", data = 93},
            {description="TILDE", data = 96},
            {description="A", data = 97},
            {description="B", data = 98},
            {description="C", data = 99},
            {description="D", data = 100},
            {description="E", data = 101},
            {description="F", data = 102},
            {description="G", data = 103},
            {description="H", data = 104},
            {description="I", data = 105},
            {description="J", data = 106},
            {description="K", data = 107},
            {description="L", data = 108},
            {description="M", data = 109},
            {description="N", data = 110},
            {description="O", data = 111},
            {description="P", data = 112},
            {description="Q", data = 113},
            {description="R", data = 114},
            {description="S", data = 115},
            {description="T", data = 116},
            {description="U", data = 117},
            {description="V", data = 118},
            {description="W", data = 119},
            {description="X", data = 120},
            {description="Y", data = 121},
            {description="Z", data = 122},
            {description="F1", data = 282},
            {description="F2", data = 283},
            {description="F3", data = 284},
            {description="F4", data = 285},
            {description="F5", data = 286},
            {description="F6", data = 287},
            {description="F7", data = 288},
            {description="F8", data = 289},
            {description="F9", data = 290},
            {description="F10", data = 291},
            {description="F11", data = 292},
            {description="F12", data = 293},
 
            {description="UP", data = 273},
            {description="DOWN", data = 274},
            {description="RIGHT", data = 275},
            {description="LEFT", data = 276},
            {description="PAGEUP", data = 280},
            {description="PAGEDOWN", data = 281},
 
            {description="0", data = 48},
            {description="1", data = 49},
            {description="2", data = 50},
            {description="3", data = 51},
            {description="4", data = 52},
            {description="5", data = 53},
            {description="6", data = 54},
            {description="7", data = 55},
            {description="8", data = 56},
            {description="9", data = 57},
        },
        default = 112,
    },















}