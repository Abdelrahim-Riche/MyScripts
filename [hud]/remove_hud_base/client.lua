Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0) -- Exécuter chaque frame

        -- Désactiver l'affichage de la vie, de l'armure et de l'argent
        for i = 1, 22 do
            HideHudComponentThisFrame(1)  -- Weapon Icon
            HideHudComponentThisFrame(2)  -- Cash
            HideHudComponentThisFrame(3)  -- Vehicle Name
            HideHudComponentThisFrame(4)  -- Street Name
            HideHudComponentThisFrame(6)  -- Vehicle Speed
            HideHudComponentThisFrame(7)  -- Health
            HideHudComponentThisFrame(8)  -- Armor
            HideHudComponentThisFrame(9)  -- Ammo
            HideHudComponentThisFrame(13) -- Cash (again, possibly)
            HideHudComponentThisFrame(19) -- Vehicle Engine
        end
    end
end)
