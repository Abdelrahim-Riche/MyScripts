ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Mettre à jour toutes les secondes

        local playerPed = PlayerPedId()
        local health = (GetEntityHealth(playerPed) - 100) / (GetEntityMaxHealth(playerPed) - 100) * 100

        local hunger, thirst = 0, 0

        -- Utiliser les fonctions fournies par basicneeds pour obtenir les valeurs de faim et de soif
        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = (status.val / 500000) * 100
        end)

        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = (status.val / 500000) * 100
        end)

        -- Attendre un moment pour assurer que les valeurs sont récupérées correctement
        Citizen.Wait(50)

        SendNUIMessage({
            action = 'updateStatus',
            health = health,
            hunger = hunger,
            thirst = thirst
        })
    end
end)
