const LendingService = require('../services/LendingService');
const LendingModel = require('../models/LendingModel');
const UserService = require('../services/UserService');
const { requestResponse } = require('../utils/readlineInterface');
const { validateName } = require('../utils/inputValidator');
const MessageService = require('../utils/messageService');

const registerLending = async () => {
  const messageService = new MessageService();
  try {

    const users = await UserService.getAllUsers();
    console.log(users);

    for (let index = 0; index < users.length; index++) {
      const element = users[index];
      console.log(element);
      
    }

    const id = await requestResponse('Numero do ID do cliente ', (value) => validateName(value));
    console.log('aqsddsfsd');
    const Lending = new LendingModel(id, 'eew', 'batata', '2024', 'PENDENTE');
    console.log('aq');
    await LendingService.addLending(Lending);
    
  } catch (error) {
    messageService.error('Erro ao realizar emprestimo:', error);
  } 
};

module.exports = {
  registerLending
};
