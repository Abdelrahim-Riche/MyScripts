window.addEventListener('message', function(event) {
    if (event.data.action === 'showRegisterForm') {
        document.getElementById('registerForm').style.display = 'block';
    }
});

document.getElementById('form').addEventListener('submit', function(e) {
    e.preventDefault();
    const firstname = document.getElementById('firstname').value;
    const lastname = document.getElementById('lastname').value;
    const dateofbirth = document.getElementById('dateofbirth').value;

    fetch(`https://${GetParentResourceName()}/submitRegistration`, {
        method: 'POST',
        body: JSON.stringify({firstname: firstname, lastname: lastname, dateofbirth: dateofbirth}),
        headers: {
            'Content-Type': 'application/json'
        }
    }).then(response => response.json()).then(data => {
        if (data === 'ok') {
            document.getElementById('registerForm').style.display = 'none';
        } else {
            alert('Registration failed.');
        }
    });
});
