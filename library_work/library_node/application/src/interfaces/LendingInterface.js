const LendingService = require('../services/LendingService');
const LendingModel = require('../models/LendingModel');
const UserService = require('../services/UserService');
const { requestResponse } = require('../utils/readlineInterface');
const { validateNameUser, validateNameBook } = require('../utils/inputValidator');
const MessageService = require('../utils/messageService');
const BookService = require('../services/BookService');

const registerLending = async () => {
  const messageService = new MessageService();
  try {

    const users = await UserService.getAllUsers();

    console.log('USUÁRIOS: ');
    for (let index = 0; index < users.length; index++) {
      const element = users[index];
      console.log(element.name);
    }

    const nameSelected = await requestResponse('Insira o nome do cliente ', (value) => validateNameUser(value, users));
    const id = users.findIndex(user => user.name === nameSelected);

    const books = await BookService.getAllBooks();

    console.log('LIVROS CADASTRADOS: ');
    for (let index = 0; index < books.length; index++) {
      const element = books[index];
      console.log(element.title);
    }

    const bookSelected = await requestResponse('Insira o nome do livro ', (value) => validateNameBook(value, books));

    const dataAtual = new Date();
    const dataFormatada = dataAtual.toISOString().split('T')[0];

    const Lending = new LendingModel(id, nameSelected, bookSelected, dataFormatada, 'PENDENTE');
    await LendingService.addLending(Lending);
    
  } catch (error) {
    messageService.error('Erro ao realizar emprestimo:', error);
  } 
};

module.exports = {
  registerLending
};
