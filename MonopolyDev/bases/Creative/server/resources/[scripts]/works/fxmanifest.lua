fx_version "bodacious"
game "gta5"
lua54 "yes"

shared_scripts {
    "shared/*",
    "@vrp/lib/Utils.lua",
    "vrp.lua",
}

client_scripts {
    "@vrp/config/Native.lua",
    "client/*"
}

server_scripts {
    "server/*"
}
