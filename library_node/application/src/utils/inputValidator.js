const validateNumber = (valor) => {
  const numero = parseInt(valor, 10);
  return !isNaN(numero) && numero > 0;
};

const validateName = (nome) => {
  return nome.trim() !== '';
};

module.exports = {
  validateNumber,
  validateName
};