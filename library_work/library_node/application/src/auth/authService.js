const db = require('../config/firebase');


class AuthService {
    constructor() {
        // Construtor pode estar vazio ou conter inicializações necessárias
    }

    // Método para autenticar o usuário
    async authenticate(username, password) {
        const userCollection = db.collection('users');
    
        // Busca documentos onde o campo "username" é igual ao valor fornecido
        const userQuerySnapshot = await userCollection.where('name', '==', username).get();

        if (userQuerySnapshot.empty) {
            // Se nenhum documento foi encontrado, o usuário não existe
            return { exists: false, authenticated: false };
        }

        // Assume que usernames são únicos, então pegamos o primeiro documento encontrado
        const userDoc = userQuerySnapshot.docs[0];
        const user = userDoc.data();

        // Verifica se a senha está correta diretamente
        const isPasswordCorrect = (password === user.password);

        if (isPasswordCorrect) {
        // Autenticação bem-sucedida
        return { exists: true, authenticated: true, user };
        } else {
        // Senha incorreta
        return { exists: true, authenticated: false };
        }
    }

    async getUser(username) {
        const userCollection = db.collection('users');
    
        // Busca documentos onde o campo "username" é igual ao valor fornecido
        const userQuerySnapshot = await userCollection.where('name', '==', username).get();

        return userQuerySnapshot.isNotEmpty;
    }


}

module.exports = AuthService;
