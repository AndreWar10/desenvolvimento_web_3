const LendingService = require('../services/LendingService');
const LendingModel = require('../models/LendingModel');
const { requestResponse } = require('../utils/readlineInterface');
const { validateName } = require('../utils/inputValidator');
const { closeInterface } = require('../utils/readlineInterface');
const MessageService = require('../utils/messageService');

const registerLending = async () => {
  const messageService = new MessageService();
  try {
    const name = await requestResponse('Nome do autor(a): ', (value) => validateName(value));
    const nationality = await requestResponse('Nacionalidade: ', (value) => validateName(value));

    const Lending = new LendingModel(name, nationality);
    await LendingService.addLending(Lending);
    
  } catch (error) {
    messageService.error('Erro ao cadastrar autor:', error);
  } finally {
    closeInterface();
  }
};

module.exports = {
  registerLending
};
