

 

fx_version "bodacious"
game "gta5" 

client_scripts {
   "@vrp/lib/utils.lua",
   "client-side.lua"
}

server_scripts {
   "@vrp/lib/utils.lua",
   "config.lua",
   "server-side.lua"
}

ui_page "nui/index.html"
files {
   "nui/*"
}
                            