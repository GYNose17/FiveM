fx_version "bodacious"
game "gta5"
lua54 "yes"
version "6.0.0"
creator "yes"

client_scripts {
	"config/Global.lua",
    "config/Groups.lua",
    "config/Item.lua",
    "config/Native.lua",
    "config/Rewards.lua",
    "config/Vehicle.lua",
	"lib/Utils.lua",
	"client/*"
}

server_scripts {
	"config/*",
	"lib/Utils.lua",
	"modules/vrp.lua",
	"modules/server.lua",
	"modules/prepare.lua"
}

files {
	"lib/*",
	"config/*",
	"config/**/*"
}