Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100) -- Update every 100ms

        local playerPed = PlayerPedId()
        local inVehicle = IsPedInAnyVehicle(playerPed, false)
        
        if inVehicle then
            local vehicle = GetVehiclePedIsIn(playerPed, false)
            local speed = GetEntitySpeed(vehicle) * 3.6 -- Convert from m/s to km/h

            -- Send speed to NUI
            SendNUIMessage({
                action = 'updateSpeed',
                speed = speed
            })

            -- Show the HUD
            SendNUIMessage({
                action = 'showHUD'
            })
            
            -- Affiche uniquement la mini-map
            DisplayRadar(true)
        else
            -- Hide the HUD if the player is not in a vehicle
            SendNUIMessage({
                action = 'hideHUD'
            })
                
                -- Masquer la mini-map lorsque le joueur n'est pas dans un véhicule
            DisplayRadar(false)
        end
    end
end)