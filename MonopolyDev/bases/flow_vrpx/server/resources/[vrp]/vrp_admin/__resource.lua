 
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	"@vrp/lib/utils.lua",
	"client.lua",
	"vipsystem/client/*.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server.lua"
}

ui_page "vipsystem/nui/index.html"
files { "vipsystem/nui/*" }          
                            