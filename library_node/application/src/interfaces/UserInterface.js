const UserService = require('../services/UserService');
const UserModel = require('../models/UserModel');
const { requestResponse } = require('../utils/readlineInterface');
const { validateName } = require('../utils/inputValidator');
const { closeInterface } = require('../utils/readlineInterface');
const MessageService = require('../utils/messageService');

const registerUser = async () => {
  const messageService = new MessageService();
  try {
    const name = await requestResponse('Nome do usuário: ', (value) => validateName(value));
    const nationality = await requestResponse('E-mail: ', (value) => validateName(value));

    const User = new UserModel(name, nationality);
    await UserService.addUser(User);
    
  } catch (error) {
    messageService.error('Erro ao cadastrar usuário:', error);
  } finally {
    closeInterface();
  }
};

module.exports = {
  registerUser
};
