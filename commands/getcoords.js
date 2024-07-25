// Commande pour obtenir les coordonnées actuelles
RegisterCommand('getcoords', () => {
    const playerPed = PlayerPedId();
    const [x, y, z] = GetEntityCoords(playerPed, true);
    console.log(`Current coordinates: X: ${x}, Y: ${y}, Z: ${z}`);
}, false);
