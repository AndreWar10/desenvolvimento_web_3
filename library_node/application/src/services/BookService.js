const db = require('../config/firebase');
const MessageService = require('../utils/messageService');

class BookService {
  static async addBook(book) {
    const messageService = new MessageService();
    try {
      messageService.loading();
      const docRef = db.collection('books').doc();
      await docRef.set(book.toJson());
      messageService.success('Livro cadastrado com sucesso!');
    } catch (error) {
      messageService.error('Erro ao cadastrar livro:', error);
    }
  }
}

module.exports = BookService;
