const express = require('express');
const multer = require('multer');
const admin = require('firebase-admin');
const axios = require('axios');
const path = require('path');
const serviceAccount = require('../firebase-service-account.json');

const app = express();
const port = 3001;

// Inicializando Firebase
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: 'https://fatec-82988.firebaseio.com',
    storageBucket: 'gs://fatec-82988.appspot.com'
});

const FIREBASE_AUTH_URL = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBlwjpe-fa610VmJe6HwqZygVDZ9kJFATg';

const db = admin.firestore();
const productsCollection = db.collection('products');
const usersCollection = db.collection('users');
const bucket = admin.storage().bucket(); 

app.use(express.json());
app.use(express.static(__dirname));

const upload = multer({ storage: multer.memoryStorage() });

app.get('/items', async (req, res) => {
    try {
        const snapshot = await productsCollection.get();
        const shoppingList = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        res.json(shoppingList);
    } catch (error) {
        res.status(500).json({ error: 'Error fetching shopping list', details: error.message });
    }
});

// Adicionar um item ao Firestore (lista de compras)
app.post('/items', async (req, res) => {
    try {
        const newItem = req.body;
        const addedDoc = await productsCollection.add(newItem);
        res.status(200).json({ id: addedDoc.id, ...newItem });
    } catch (error) {
        res.status(500).json({ error: 'Error adding item to Firestore', details: error.message });
    }
});

// Atualizar um item no Firestore (lista de compras)
app.put('/items/:id', async (req, res) => {
    try {
        const docId = req.params.id;
        const updatedItem = req.body;
        await productsCollection.doc(docId).update(updatedItem);
        res.status(200).json({ id: docId, ...updatedItem });
    } catch (error) {
        res.status(500).json({ error: 'Error updating item in Firestore', details: error.message });
    }
});

// Remover um item do Firestore (lista de compras)
app.delete('/items/:id', async (req, res) => {
    try {
        const docId = req.params.id;
        await productsCollection.doc(docId).delete();
        res.status(200).json({ message: 'Item removed from shopping list' });
    } catch (error) {
        res.status(500).json({ error: 'Error removing item from Firestore', details: error.message });
    }
});

// Rota para obter o carrinho (ainda local)
let cart = [];

app.get('/cart', (req, res) => {
    res.json(cart);
});

// Adicionar um item ao carrinho
app.post('/cart', (req, res) => {
    const newItem = req.body;
    cart.push(newItem);
    res.status(200).json(newItem);
});

// Remover um item do carrinho com validação de índice
app.delete('/cart/:index', (req, res) => {
    const index = parseInt(req.params.index);

    if (index >= 0 && index < cart.length) {
        const removedItem = cart.splice(index, 1);
        res.status(200).json({ message: 'Item removed from cart', removedItem });
    } else {
        res.status(404).json({ error: 'Invalid index' });
    }
});

// PRODUCTS --------------------------------------------------------------------------------------------
app.post('/upload-product', upload.single('image'), async (req, res) => {
    try {
        if (!req.file) {
            console.error('No file uploaded');
            return res.status(400).json({ error: 'No file uploaded' });
        }

        // Definir nome único para o arquivo no Firebase Storage
        const fileName = `${Date.now()}_${req.file.originalname}`;
        const file = bucket.file(fileName);

        // Upload da imagem para o Firebase Storage
        const stream = file.createWriteStream({
            metadata: {
                contentType: req.file.mimetype
            }
        });

        stream.on('error', (error) => {
            console.error('Error uploading file', error);
            res.status(500).json({ error: 'Error uploading file', details: error.message });
        });

        stream.on('finish', async () => {
            try {
                // Tornar a imagem publicamente acessível
                await file.makePublic();

                // Obter a URL pública da imagem
                const imageUrl = `https://storage.googleapis.com/${bucket.name}/${fileName}`;

                // Capturar os atributos do produto enviados no corpo da requisição
                const { name, price, description } = req.body;

                if (!name || !price || !description) {
                    console.error('Missing product attributes');
                    return res.status(400).json({ error: 'Missing product attributes' });
                }

                // Salvar as informações do produto no Firestore
                const newProduct = {
                    name: name,
                    price: parseFloat(price),
                    description: description,
                    imageUrl: imageUrl,
                    createdAt: admin.firestore.FieldValue.serverTimestamp()
                };

                const docRef = await productsCollection.add(newProduct);

                res.status(200).json({ id: docRef.id, ...newProduct });
            } catch (error) {
                console.error('Error processing file after upload', error);
                res.status(500).json({ error: 'Error processing request', details: error.message });
            }
        });

        stream.end(req.file.buffer);
    } catch (error) {
        console.error('Error in /upload-product route', error);
        res.status(500).json({ error: 'Error processing request', details: error.message });
    }
});

// ---------------------- Rotas de Autenticação ----------------------

// Criar conta de usuário
app.post('/signup', async (req, res) => {
    const { email, password, displayName, levelAccess } = req.body;

    try {
        // Log para verificar se os dados estão sendo recebidos corretamente
        console.log('Recebendo dados:', { email, password, displayName, levelAccess });

        // Cria o usuário no Firebase Authentication com o SDK Admin
        const userRecord = await admin.auth().createUser({
            email: email,
            password: password,
            displayName: displayName
        });

        // Log para verificar se o usuário foi criado corretamente no Firebase Authentication
        console.log('Usuário criado no Firebase Authentication:', userRecord);

        // Salva informações adicionais no Firestore
        await usersCollection.doc(userRecord.uid).set({
            displayName,
            email,
            levelAccess, // Adiciona o nível de acesso ao documento
            createdAt: admin.firestore.FieldValue.serverTimestamp()
        });

        // Log para verificar se os dados foram salvos no Firestore
        console.log('Usuário salvo no Firestore com sucesso:', userRecord.uid);

        res.status(200).json({ uid: userRecord.uid, email: userRecord.email, displayName, levelAccess });
    } catch (error) {
        // Log do erro capturado
        console.error('Erro ao criar usuário', error);

        // Retorna o erro no response
        res.status(400).json({ error: 'Erro ao criar o usuário', detalhes: error.message });
    }
});

// Login de usuário
app.post('/login', async (req, res) => {
    const { email, password } = req.body;

    try {
        // Autenticar com Firebase usando a API REST
        const response = await axios.post(FIREBASE_AUTH_URL, {
            email: email,
            password: password,
            returnSecureToken: true
        });

        const { idToken, localId } = response.data;

        // Verificar o ID token
        const decodedToken = await admin.auth().verifyIdToken(idToken);
        const uid = decodedToken.uid;

        // Obter detalhes do usuário
        const userRecord = await admin.auth().getUser(uid);

        // Opcional: Obter informações adicionais do Firestore
        const userDoc = await usersCollection.doc(uid).get();
        const userData = userDoc.data();

        res.status(200).json({
            uid: userRecord.uid,
            email: userRecord.email,
            displayName: userRecord.displayName,
            ...userData
        });
    } catch (error) {
        console.error('Error logging in', error);
        res.status(400).json({ error: 'Error logging in', details: error.message });
    }
});



// Obter informações do usuário autenticado
app.get('/user', async (req, res) => {
    const { uid } = req.query;

    try {
        const userDoc = await usersCollection.doc(uid).get();
        if (!userDoc.exists) {
            return res.status(404).json({ error: 'User not found' });
        }

        res.status(200).json(userDoc.data());
    } catch (error) {
        res.status(500).json({ error: 'Error fetching user data', details: error.message });
    }
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
});
