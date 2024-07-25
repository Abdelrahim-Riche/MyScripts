// Événement de gestion de l'apparition du joueur
on('onClientGameTypeStart', () => {
    emit('spawnPlayer');
});

// Définir un événement côté client pour la réapparition du joueur
onNet('spawnPlayer', () => {
    const player = source; // obtenir l'identifiant du joueur
    const spawnCoords = [425.1, -806.3, 29.5]; // coordonnées du point d'apparition

    // Définir la position de spawn
    SetEntityCoords(GetPlayerPed(player), ...spawnCoords, false, false, false, true);
    console.log(`Le joueur ${player} a spawn aux coordonné : ${spawnCoords}`);
});
