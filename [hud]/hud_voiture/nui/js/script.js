window.addEventListener('message', function(event) {
    if (event.data.action === 'updateSpeed') {
        let speed = event.data.speed;
        document.getElementById('speed').innerText = Math.round(speed);
        updateProgress(speed);
    } else if (event.data.action === 'hideHUD') {
        document.getElementById('hud').style.display = 'none';
    } else if (event.data.action === 'showHUD') {
        document.getElementById('hud').style.display = 'block';
    }
});

function updateProgress(speed) {
    const maxSpeed = 300; // Set the max speed for the progress bar
    let progressCircle = document.querySelector('circle.progress');
    let offset = 283 - (speed / maxSpeed) * 283;
    progressCircle.style.strokeDashoffset = offset;
}

console.log('Abdelrmb\'s Car HUD ensured successfuly');