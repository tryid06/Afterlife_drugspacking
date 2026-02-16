fx_version 'cerulean'

game 'gta5'

lua54 'yes'

name 'susidrugpack'
description 'Secure and optimized drug packing system with NUI scale workflow.'
author 'susidrugpack'

shared_script {
	'config.lua',
	'@ox_lib/init.lua'
}

server_scripts {
	'server/*.lua'
}

client_scripts {
	'client/*.lua',
}

ui_page 'ui/dist/index.html'

escrow_ignore {
	'config.lua'
}

files {
    'ui/dist/index.html',
	'ui/dist/assets/*.js',
    'ui/dist/assets/*.css',
    'ui/dist/assets/*.png',
	'ui/dist/assets/*.ttf',
	'ui/images/*.png'
}
