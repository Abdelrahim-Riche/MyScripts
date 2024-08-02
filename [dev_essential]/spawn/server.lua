local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Sauvegarder la position du joueur lorsqu'il se déconnecte
AddEventHandler('esx:playerDropped', function(reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        local identifier = xPlayer.getIdentifier()
        local playerPed = GetPlayerPed(source)
        local pos = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)
        local position = json.encode({x = pos.x, y = pos.y, z = pos.z, heading = heading})

        -- Sauvegarder la position dans la base de données
        exports.oxmysql:execute('UPDATE users SET position = ? WHERE identifier = ?', {position, identifier})
    end
end)

-- Charger la position du joueur lorsqu'il se connecte
AddEventHandler('esx:playerLoaded', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local identifier = xPlayer.getIdentifier()

    -- Charger la position depuis la base de données
    exports.oxmysql:fetch('SELECT position FROM users WHERE identifier = ?', {identifier}, function(result)
        if result[1] and result[1].position then
            local position = json.decode(result[1].position)
            -- Envoyer les coordonnées au client pour téléporter le joueur
            TriggerClientEvent('esx:teleport', playerId, position.x, position.y, position.z, position.heading)
        else
            -- Utiliser les coordonnées par défaut si aucune position n'est trouvée
            local defaultPos = Config.DefaultSpawnLocation
            TriggerClientEvent('esx:teleport', playerId, defaultPos.x, defaultPos.y, defaultPos.z, defaultPos.heading)

            -- Insérer la position par défaut dans la base de données pour le joueur
            local defaultPosition = json.encode({x = defaultPos.x, y = defaultPos.y, z = defaultPos.z, heading = defaultPos.heading})
            exports.oxmysql:execute('UPDATE users SET position = ? WHERE identifier = ?', {defaultPosition, identifier})
        end
    end)
end)
