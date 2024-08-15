const UserService = require('../services/UserService');
const UserModel = require('../models/UserModel');
const { requestResponse } = require('../utils/readlineInterface');
const { validateName } = require('../utils/inputValidator');
const MessageService = require('../utils/messageService');

const registerUser = async () => {
  const messageService = new MessageService();
  try {
    const name = await requestResponse('Nome do usuário: ', (value) => validateName(value));
    const email = await requestResponse('E-mail: ', (value) => validateName(value));
    const password = await requestResponse('Senha: ', (value) => validateName(value));

    const User = new UserModel(name, email, password);
    await UserService.addUser(User);
    
  } catch (error) {
    messageService.error('Erro ao cadastrar usuário:', error);
  }
};

module.exports = {
  registerUser
};
