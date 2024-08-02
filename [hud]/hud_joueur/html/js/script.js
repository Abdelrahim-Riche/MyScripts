window.addEventListener('message', function(event) {
    if (event.data.action === 'updateStatus') {
        updateProgress('health-progress', event.data.health);
        updateProgress('hunger-progress', event.data.hunger, true);
        updateProgress('thirst-progress', event.data.thirst, true);
    }
});

function updateProgress(elementId, value, invert = false) {
    const circle = document.getElementById(elementId);
    const radius = circle.r.baseVal.value;
    const circumference = 2 * Math.PI * radius;
    let offset;

    if (invert) {
        offset = (value / 100) * circumference;
    } else {
        offset = circumference - (value / 100) * circumference;
    }

    circle.style.strokeDasharray = `${circumference} ${circumference}`;
    circle.style.strokeDashoffset = offset;
}

console.log('Abdelrmb\'s Player HUD ensured successfuly');