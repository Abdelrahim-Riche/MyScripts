local ESX = nil

-- Fonction pour obtenir l'objet ESX
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(500)
    end

    -- Lorsque ESX est disponible, vérifie l'enregistrement toutes les 5 secondes
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5000) -- Vérifier toutes les 5 secondes

            ESX.TriggerServerCallback('esx_register:checkRegistration', function(isRegistered)
                if not isRegistered then
                    -- Afficher l'interface utilisateur pour l'inscription
                    SetNuiFocus(true, true)
                    SendNUIMessage({action = 'showRegisterForm'})
                end
            end)
        end
    end)
end)

-- Gestion des réponses de l'interface utilisateur
RegisterNUICallback('submitRegistration', function(data, cb)
    local firstname = data.firstname
    local lastname = data.lastname
    local dateofbirth = data.dateofbirth

    if firstname and lastname and dateofbirth then
        TriggerServerEvent('esx_register:registerPlayer', firstname, lastname, dateofbirth)
        SetNuiFocus(false, false)
        cb('ok')
    else
        cb('error')
    end
end)
