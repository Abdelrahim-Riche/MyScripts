-- Variable pour stocker l'objet ESX
local ESX = nil

-- Attente que l'objet ESX soit disponible
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

-- Mise à jour des données du joueur
RegisterNetEvent('myResource:updatePlayerData')
AddEventHandler('myResource:updatePlayerData', function(data)
    local playerId = source
    -- Vous pouvez stocker les données du joueur ici ou les utiliser comme nécessaire
    TriggerClientEvent('myResource:sendPlayerData', playerId, data)
end)

-- Exemple d'événement pour activer ou désactiver l'UI
RegisterCommand('toggleUI', function(source, args, rawCommand)
    local playerId = source
    local visible = args[1] == 'show'
    TriggerClientEvent('myResource:showUI', playerId, visible)
end, false)
