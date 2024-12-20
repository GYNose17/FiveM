fx_version "bodacious"
game "gta5"
lua54 "yes"

-- ui_page "web/index.html"

shared_scripts {
	"@vrp/lib/Utils.lua",
	"vrp.lua",
	"shared/*"
}

client_scripts {
	"@vrp/config/Global.lua",
	"@PolyZone/client.lua",
	"@vrp/config/Native.lua",
	"client/*"
}

server_scripts {
	"@vrp/config/Global.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Item.lua",
	"server/*"
}

-- files {
-- 	"web/*",
-- 	"web/**/*"
-- }