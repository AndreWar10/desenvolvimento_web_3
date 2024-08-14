const db = require('../config/firebase');
const MessageService = require('../utils/messageService');

class UserService {
  static async addUser(User) {
    const messageService = new MessageService();
    try {
      messageService.loading();
      const docRef = db.collection('users').doc();
      await docRef.set(User.toJson());
      messageService.success('Usuário cadastrado com sucesso!');
    } catch (error) {
      messageService.error('Erro ao cadastrar usuário:', error);
    }
  }
}

module.exports = UserService;
