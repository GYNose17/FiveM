shared_script "@ThnAC/native.lua"
shared_script "@ThnAC/natives.lua"
fx_version "bodacious"
game "gta5"

dependencies {
    "PolyZone"
}

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"@PolyZone/ComboZone.lua",
	"@flow_roubos/config.lua",
	"@flow_snippets/config/config.lua",
	"@flow_inventory/config-side/config.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*"
}

files {
	"web-side/*"
}