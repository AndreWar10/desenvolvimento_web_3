const fetchItems = async (endpoint) => {
    try {
        const response = await fetch(endpoint);
        if (!response.ok) throw new Error('Failed to fetch items');
        return await response.json();
    } catch (error) {
        console.error(error);
        return [];
    }
};

const postItem = async (endpoint, itemData) => {
    try {
        const response = await fetch(endpoint, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(itemData),
        });
        if (!response.ok) throw new Error('Failed to post item');
        return await response.json();
    } catch (error) {
        console.error(error);
    }
};

const deleteItem = async (endpoint) => {
    try {
        const response = await fetch(endpoint, { method: 'DELETE' });
        if (!response.ok) throw new Error('Failed to delete item');
    } catch (error) {
        console.error(error);
    }
};

const updateVisibility = (listElement, titleElement) => {
    titleElement.style.display = listElement.children.length === 0 ? 'none' : 'block';
};

const renderList = (listElement, titleElement, items, itemActions) => {
    listElement.innerHTML = items.map((item, index) => `
        <li>
            ${item.name}
            <button onclick="handleRemoveItem(${index}, '${itemActions.remove}')">Remove</button>
            <button onclick="handleAddToCart('${item.name}', ${index}, '${itemActions.addToCart}')">Move to Cart</button>
        </li>
    `).join('');
    updateVisibility(listElement, titleElement);
};

const renderCart = (cartElement, titleElement, items, cartActions) => {
    cartElement.innerHTML = items.map((item, index) => `
        <li>
            ${item.name}
            <button onclick="handleRemoveItem(${index}, '${cartActions.removeFromCart}')">Remove from Cart</button>
        </li>
    `).join('');
    updateVisibility(cartElement, titleElement);
};

const handleAddToCart = async (itemName, index, removeItemEndpoint) => {
    await deleteItem(`${removeItemEndpoint}/${index}`);
    await postItem('/cart', { name: itemName, purchased: false });
    
    await renderShoppingList();
    await renderShoppingCart();
};


const handleRemoveItem = async (index, removeItemEndpoint) => {
    await deleteItem(`${removeItemEndpoint}/${index}`);
    
    if (removeItemEndpoint === '/items') {
        await renderShoppingList();
    } else if (removeItemEndpoint === '/cart') {
        await renderShoppingCart();
    }
};


const renderShoppingList = async () => {
    const items = await fetchItems('/items');
    renderList(document.getElementById('shoppingList'), document.getElementById('itemsTitle'), items, {
        remove: '/items',
        addToCart: '/items',
    });
};

const renderShoppingCart = async () => {
    const cartItems = await fetchItems('/cart');
    renderCart(document.getElementById('cartList'), document.getElementById('cartTitle'), cartItems, {
        removeFromCart: '/cart',
    });
};

document.getElementById('addItemBtn').addEventListener('click', async () => {
    const newItemInput = document.getElementById('newItemInput');
    const newItemName = newItemInput.value.trim();

    if (newItemName) {
        await postItem('/items', { name: newItemName, purchased: false });
        renderShoppingList();
        newItemInput.value = '';
    }
});

window.onload = async () => {
    await renderShoppingList();
    await renderShoppingCart();
};
