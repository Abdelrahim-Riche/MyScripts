document.addEventListener('DOMContentLoaded', function() {
    const menu = document.getElementById('menu');
    const menuContent = document.getElementById('menu-content');

    // Stack to store previous menus
    let menuStack = [];

    function showMenu(items, title) {
        menu.style.display = 'block';
        menuContent.innerHTML = ''; // Clear previous content

        // Add "Fermer" button if we are at the main menu
        if (menuStack.length === 0) {
            const closeButton = document.createElement('div');
            closeButton.className = 'menu-item';
            closeButton.textContent = 'Fermer';
            closeButton.addEventListener('click', () => {
                fetch(`https://${GetParentResourceName()}/menuAction`, {
                    method: 'POST',
                    body: JSON.stringify({ action: 'close' })
                });
            });
            menuContent.appendChild(closeButton);
        } else {
            // Add "Retour" button if we are in a sub-menu
            const backButton = document.createElement('div');
            backButton.className = 'menu-item';
            backButton.textContent = 'Retour';
            backButton.addEventListener('click', goBack);
            menuContent.appendChild(backButton);
        }

        // Add menu items
        if (Array.isArray(items) && items.length > 0) {
            items.forEach(item => {
                const div = document.createElement('div');
                div.className = 'menu-item';
                div.textContent = item.label;
                div.dataset.value = item.value; // Store value in data attribute
                div.addEventListener('click', () => {
                    const value = div.dataset.value;
                    console.log('Item clicked:', value);
                    fetch(`https://${GetParentResourceName()}/menuAction`, {
                        method: 'POST',
                        body: JSON.stringify({ action: value })
                    }).then(response => response.json())
                      .then(data => console.log('Response from Lua:', data))
                      .catch(error => console.error('Error:', error));
                });
                menuContent.appendChild(div);
            });
        } else {
            console.error('Items is not defined, is not an array, or is empty.');
        }
    }

    function goBack() {
        if (menuStack.length > 0) {
            const previousMenu = menuStack.pop();
            showMenu(previousMenu.items, previousMenu.title);
        }
    }

    window.addEventListener('message', function(event) {
        if (event.data.action === 'showMenu') {
            menuStack = []; // Clear the stack when showing the main menu
            showMenu(event.data.items, event.data.title);
        } else if (event.data.action === 'showSubMenu') {
            // Save the current menu to the stack
            const currentMenuItems = [];
            document.querySelectorAll('.menu-item').forEach(item => {
                if (item.textContent !== 'Retour' && item.textContent !== 'Fermer') {
                    currentMenuItems.push({ label: item.textContent, value: item.dataset.value });
                }
            });
            menuStack.push({
                items: currentMenuItems,
                title: document.querySelector('#menu-content').dataset.title || 'Menu'
            });
            showMenu(event.data.items, event.data.title);
        } else if (event.data.action === 'hideMenu') {
            menu.style.display = 'none';
        }
    });
});
