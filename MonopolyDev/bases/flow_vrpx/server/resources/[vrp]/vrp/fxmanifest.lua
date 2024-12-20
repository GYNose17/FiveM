shared_script '@likizao_ac/client/library.lua'

fx_version 'adamant'
game 'gta5'

ui_page "web-side/index.html"

server_scripts {
	"lib/utils.lua",
	"base.lua",
	"server-side/*"
}

client_scripts {
	"lib/utils.lua",
	"client-side/*"
}

files {
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/Tools.lua",
	"web-side/*",
	"loading/*",
}

loadscreen "loading/darkside.html"              