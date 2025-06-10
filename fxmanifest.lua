fx_version 'adamant'

game 'gta5'

lua54 'yes'

shared_script {
	'@ox_lib/init.lua'
} 


server_scripts {
	'config.lua',
	'server/*.lua'
}

client_scripts {
	'config.lua',
	'client/*.lua',
}

