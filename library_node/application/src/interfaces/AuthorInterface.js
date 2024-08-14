const AuthorService = require('../services/AuthorService');
const AuthorModel = require('../models/AuthorModel');
const { requestResponse } = require('../utils/readlineInterface');
const { validateName } = require('../utils/inputValidator');
const { closeInterface } = require('../utils/readlineInterface');
const MessageService = require('../utils/messageService');

const registerAuthor = async () => {
  const messageService = new MessageService();
  try {
    const name = await requestResponse('Nome do autor(a): ', (value) => validateName(value));
    const nationality = await requestResponse('Nacionalidade: ', (value) => validateName(value));

    const author = new AuthorModel(name, nationality);
    await AuthorService.addAuthor(author);
    
  } catch (error) {
    messageService.error('Erro ao cadastrar autor:', error);
  } finally {
    // closeInterface();
  }
};

module.exports = {
  registerAuthor
};
