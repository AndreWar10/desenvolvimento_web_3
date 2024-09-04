const express = require('express');

const app = express();
const port = 3001;

app.use(express.json());
app.use(express.static(__dirname));

let listaDeCompras = [];
let carrinho = [];

// Rota para obter a lista de compras
app.get('/itens', (req, res) => {
    res.json(listaDeCompras);
});

// Rota para obter o carrinho
app.get('/itensCart', (req, res) => {
    res.json(carrinho);
});

// Adiciona um item à lista de compras
app.post('/itens', (req, res) => {
    const novoItem = req.body;
    listaDeCompras.push(novoItem);
    res.status(201).json(novoItem);
});

// Adiciona um item ao carrinho
app.post('/itensCart', (req, res) => {
    const novoItem = req.body;
    carrinho.push(novoItem);
    res.status(201).json(novoItem);
});

// Remove um item da lista de compras com validação de índice
app.delete('/itens/:index', (req, res) => {
    const index = parseInt(req.params.index);
    
    if (index >= 0 && index < listaDeCompras.length) {
        listaDeCompras.splice(index, 1);
        res.status(200).json({ message: 'Item removido da lista de compras' });
    } else {
        res.status(404).json({ error: 'Índice inválido' });
    }
});

// Remove um item do carrinho com validação de índice
app.delete('/itensCart/:index', (req, res) => {
    const index = parseInt(req.params.index);
    
    if (index >= 0 && index < carrinho.length) {
        carrinho.splice(index, 1);
        res.status(200).json({ message: 'Item removido do carrinho' });
    } else {
        res.status(404).json({ error: 'Índice inválido' });
    }
});

app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
});
