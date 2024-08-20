const db = require('../config/firebase');
const MessageService = require('../utils/messageService');
const UserModel = require('../models/UserModel'); // Certifique-se de importar a classe UserModel

class UserService {
  static async addUser(user) {
    const messageService = new MessageService();
    try {
      messageService.loading();

      // Verifica se o argumento é uma instância de UserModel e possui o método toJson
      if (user instanceof UserModel && typeof user.toJson === 'function') {
        // Gera uma referência para um novo documento
        const docRef = db.collection('users').doc();

        // Atualiza o usuário com o ID do documento gerado
        user.id = docRef.id;

        // Salva o usuário no Firestore com o ID atualizado
        await docRef.set(user.toJson());

        messageService.success('Usuário cadastrado com sucesso!');
      } else {
        throw new Error('O argumento não é uma instância válida de UserModel.');
      }
    } catch (error) {
      messageService.error('Erro ao cadastrar usuário:', error.message);
    }
  }

  static async getAllUsers() {
    const messageService = new MessageService();
    try {
      messageService.loading();
      // Referência para a coleção de usuários
      const userCollection = db.collection('users');

      // Busca todos os documentos na coleção
      const userQuerySnapshot = await userCollection.get();

      // Verifica se a coleção contém documentos
      if (userQuerySnapshot.empty) {
        return []; // Retorna uma lista vazia se não houver documentos
      }

      // Mapeia os documentos para extrair seus dados
      const users = userQuerySnapshot.docs.map(doc => ({
        id: doc.id, // Inclui o ID do documento
        ...doc.data() // Inclui os dados do documento
      }));

      return users; // Retorna a lista de usuários
    } catch (error) {
      console.error('Erro ao buscar usuários:', error);
      throw new Error('Erro ao buscar usuários');
    }
  }

}

module.exports = UserService;
