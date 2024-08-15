const db = require('../config/firebase');
const MessageService = require('../utils/messageService');

class AuthorService {
  static async addAuthor(author) {
    const messageService = new MessageService();
    try {
      messageService.loading();
      const docRef = db.collection('authors').doc();
      await docRef.set(author.toJson());
      messageService.success('Autor cadastrado com sucesso!');
    } catch (error) {
      messageService.error('Erro ao cadastrar autor:', error);
    }
  }
}

module.exports = AuthorService;
