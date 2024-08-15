const db = require('../config/firebase');
const MessageService = require('../utils/messageService');

class LendingService {
  static async addLending(lending) {
    const messageService = new MessageService();
    try {
      messageService.loading();
      const docRef = db.collection('lendings').doc();
      await docRef.set(lending.toJson());
      messageService.success('Empréstimo cadastrado com sucesso!');
    } catch (error) {
      messageService.error('Erro ao cadastrar Empréstimo:', error);
    }
  }
}

module.exports = LendingService;
