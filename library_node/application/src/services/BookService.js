const db = require('../config/firebase');

class BookService {
  static async addBook(book) {
    try {
      const docRef = db.collection('books').doc(); // Gera um ID automático
      await docRef.set(book.toPlainObject()); // Usa o método toPlainObject
      console.log('Livro cadastrado com sucesso!');
    } catch (error) {
      console.error('Erro ao cadastrar livro:', error);
    }
  }
}

module.exports = BookService;
