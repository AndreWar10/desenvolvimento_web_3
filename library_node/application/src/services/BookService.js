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

  static async getAllBooks() {
    try {
      // Referência para a coleção de usuários
      const booksCollection = db.collection('books');

      // Busca todos os documentos na coleção
      const booksQuerySnapshot = await booksCollection.get();

      // Verifica se a coleção contém documentos
      if (booksQuerySnapshot.empty) {
        return []; // Retorna uma lista vazia se não houver documentos
      }

      // Mapeia os documentos para extrair seus dados
      const books = booksQuerySnapshot.docs.map(doc => ({
        id: doc.id, // Inclui o ID do documento
        ...doc.data() // Inclui os dados do documento
      }));

      return books; // Retorna a lista de usuários
    } catch (error) {
      console.error('Erro ao buscar livros:', error);
      throw new Error('Erro ao buscar livros');
    }
  }

}

module.exports = BookService;
