const validarInteiroPositivo = (valor) => {
    const numero = parseInt(valor, 10);
    return !isNaN(numero) && numero > 0;
  };
  
  const validarNome = (nome) => {
    return nome.trim() !== '';
  };
  
  module.exports = {
    validarInteiroPositivo,
    validarNome
  };