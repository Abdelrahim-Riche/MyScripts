on('playerConnecting', (name, setKickReason, deferrals) => {
  console.log(`${name} se connecte au serveur.`);
});

on('playerSpawned', (player) => {
  console.log(`Le joueur ${player.name} est apparu.`);
});

// Importer les scripts de gestion des événements
require('./event/spawn.js');