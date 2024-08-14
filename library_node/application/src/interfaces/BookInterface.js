const BookService = require('../services/BookService');
const BookModel = require('../models/BookModel');
const { requestResponse } = require('../utils/readlineInterface');
const { validateNumber, validateName } = require('../utils/inputValidator');
const { closeInterface } = require('../utils/readlineInterface');
const MessageService = require('../utils/messageService');



const registerBook = async () => {
  const messageService = new MessageService();
  try {
    const author = await requestResponse('Autor: ', (value) => validateName(value));
    const isbn = await requestResponse('ISBN: ', (value) => validateNumber(value));
    const title = await requestResponse('Título: ', (value) => validateName(value));
    const year = await requestResponse('Ano: ', (value) => validateNumber(value));

    const book = new BookModel(author, isbn, title, year);
    await BookService.addBook(book);
    
  } catch (error) {
    messageService.error('Erro ao cadastrar livro:', error);
  } finally {
    closeInterface();
  }
};

module.exports = {
  registerBook
};
