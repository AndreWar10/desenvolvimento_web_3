const express = require('express');

const app = express();
const port = 3001;

app.use(express.json());
app.use(express.static(__dirname));

let shoppingList = [];
let cart = [];

// Route to get the shopping list
app.get('/items', (req, res) => {
    res.json(shoppingList);
});

// Route to get the cart
app.get('/cart', (req, res) => {
    res.json(cart);
});

// Add an item to the shopping list
app.post('/items', (req, res) => {
    const newItem = req.body;
    shoppingList.push(newItem);
    res.status(201).json(newItem);
});

// Add an item to the cart
app.post('/cart', (req, res) => {
    const newItem = req.body;
    cart.push(newItem);
    res.status(201).json(newItem);
});

// Remove an item from the shopping list with index validation
app.delete('/items/:index', (req, res) => {
    const index = parseInt(req.params.index);

    if (index >= 0 && index < shoppingList.length) {
        const removedItem = shoppingList.splice(index, 1);
        res.status(200).json({ message: 'Item removed from shopping list', removedItem });
    } else {
        res.status(404).json({ error: 'Invalid index' });
    }
});

// Remove an item from the cart with index validation
app.delete('/cart/:index', (req, res) => {
    const index = parseInt(req.params.index);

    if (index >= 0 && index < cart.length) {
        const removedItem = cart.splice(index, 1);
        res.status(200).json({ message: 'Item removed from cart', removedItem });
    } else {
        res.status(404).json({ error: 'Invalid index' });
    }
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
