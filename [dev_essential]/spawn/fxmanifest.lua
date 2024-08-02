fx_version 'cerulean'
game 'gta5'

-- Dépendances
dependency 'es_extended'
dependency 'oxmysql'

-- Scripts serveur
server_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'server.lua'
}

-- Scripts client
client_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'client.lua'
}

-- Description du script
author 'Abdelrmb'
description 'Gestion des coordonnées de spawn des joueurs'
version '1.0.0'
