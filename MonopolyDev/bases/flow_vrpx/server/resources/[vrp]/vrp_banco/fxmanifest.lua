 



 fx_version 'adamant'
game 'gta5'


dependencies {
	'vrp',
}

ui_page 'nui/index.html'

files {
	'nui/index.html',
	'nui/style.css',
	'nui/*.js',
	'nui/font/*.ttf',
	'nui/images/*.svg',
}

client_script {
	"@vrp/lib/utils.lua",
	"client.lua"
}

server_scripts{ 
	"@vrp/lib/utils.lua",
	"server.lua"
}
                            