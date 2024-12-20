fx_version "bodacious"
game "gta5"
lua54 "yes"

version "2.6.0"

dependencies {
	"/server:5104"
}

server_script "server/server.js"

provide "mysql-async"