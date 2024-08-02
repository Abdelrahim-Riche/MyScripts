local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end

    -- Réception des coordonnées depuis le serveur
    RegisterNetEvent('esx:teleport')
    AddEventHandler('esx:teleport', function(x, y, z, heading)
        Citizen.Wait(500) -- Attendre un peu pour s'assurer que le joueur est complètement chargé
        local playerPed = PlayerPedId()
        SetEntityCoords(playerPed, x, y, z, false, false, false, true)
        SetEntityHeading(playerPed, heading)
    end)
end)
