const validateNumber = (valor) => {
  const numero = parseInt(valor, 10);
  return !isNaN(numero) && numero > 0;
};

const validateName = (nome) => {
  return nome.trim() !== '';
};

const validateNameUser = (nameSelected, users) => {
  const index = users.findIndex(user => user.name === nameSelected);
  return index !== -1;
}; 

const validateNameBook = (bookSelected, books) => {
  const index = books.findIndex(book => book.title === bookSelected);
  return index !== -1;
};

module.exports = {
  validateNumber,
  validateName,
  validateNameUser,
  validateNameBook
};