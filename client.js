// Écouter l'événement de réapparition du joueur
on('playerSpawned', () => {
    emitNet('spawnPlayer');
});

// Importer les scripts de gestion des commandes
require('./commands/getcoords.js');