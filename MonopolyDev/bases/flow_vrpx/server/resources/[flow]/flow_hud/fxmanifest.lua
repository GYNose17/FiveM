fx_version 'adamant' 
game "gta5"

shared_script { '@vrp/lib/utils.lua', "lib/*.lua", "config.lua" }
client_script { '@vrp/lib/utils.lua', 'client.lua', }
server_script { '@vrp/lib/utils.lua', 'server.lua', }

ui_page "ui/index.html"
files { 'ui/*', 'ui/images/*' }