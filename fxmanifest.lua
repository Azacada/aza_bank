fx_version 'adamant'

game 'gta5'

shared_script '@es_extended/imports.lua'

client_scripts {
	'@es_extended/locale.lua',
	'dependencies/menu.lua',
	'marker.lua',
	'blips.lua',
	'cl_bank.lua',
	'functions.lua'
}

server_scripts {
	'@es_extended/locale.lua',
    'sv_bank.lua'
}

dependency 'es_extended'
