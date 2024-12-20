 

shared_script "@vrp/lib/lib.lua" --Para remover esta pendencia de todos scripts, execute no console o comando "uninstall"

games {'gta5'}

fx_version 'cerulean'

version '2.6.0'

client_scripts {
  'client.lua',
  'BoxZone.lua',
  'EntityZone.lua',
  'CircleZone.lua',
  'ComboZone.lua',
  'creation/client/*.lua'
}

server_scripts {
  'creation/server/*.lua',
  'server.lua'
}
                            