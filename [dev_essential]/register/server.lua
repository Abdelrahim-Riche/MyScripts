ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Callback pour vérifier si l'utilisateur est enregistré
ESX.RegisterServerCallback('esx_register:checkRegistration', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    -- Utiliser oxmysql pour vérifier l'enregistrement
    exports.oxmysql:fetch('SELECT * FROM users WHERE identifier = ?', {identifier}, function(result)
        if result[1] then
            cb(true)  -- Utilisateur déjà enregistré
        else
            cb(false) -- Utilisateur non enregistré
        end
    end)
end)

-- Événement pour enregistrer l'utilisateur
RegisterServerEvent('esx_register:registerPlayer')
AddEventHandler('esx_register:registerPlayer', function(firstname, lastname, dateofbirth)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.getIdentifier()

    -- Utiliser oxmysql pour insérer les données
    exports.oxmysql:execute('INSERT INTO users (identifier, firstname, lastname, dateofbirth) VALUES (?, ?, ?, ?)', {identifier, firstname, lastname, dateofbirth}, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('esx:showNotification', source, 'Enregistrement réussi!')
        else
            TriggerClientEvent('esx:showNotification', source, 'Erreur lors de l\'enregistrement!')
        end
    end)
end)
