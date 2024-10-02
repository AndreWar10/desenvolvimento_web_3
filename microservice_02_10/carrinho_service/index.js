const express = require('express');
const app = express();
const port = 3002; 
const cors = require('cors'); //foi necessario devido a erro

app.use(express.static(__dirname));
app.use(express.json());
app.use(cors()); //foi necessario devido a erro

let carrinho = []; // //como sempre, nosso vetor representando o BD


//rota get
app.get('/carrinho', (req, res) => {
    res.json(carrinho);
});


//rota post
app.post('/carrinho', (req, res) => {
    const item = req.body;
    carrinho.push(item);
    res.status(201).json(item);
});

app.get('/carrinholimpar', (req, res) => {
    carrinho = [];
    res.sendStatus(204); 
});

//rota delete
app.delete('/carrinho/:index', (req, res) => {
    const index = parseInt(req.params.index);
    if (index >= 0 && index < carrinho.length) {
        carrinho.splice(index, 1);
        res.sendStatus(204); 
    } else {
        res.status(404).json({ error: 'Item não encontrado no carrinho' });
    }
});


//exibe porta que esta rodando
app.listen(port, () => {
    console.log(`Serviço de Carrinho rodando em http://localhost:${port}`);
});