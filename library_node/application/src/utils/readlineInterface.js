// Recebe a interface readline criada no index.js
let readlineI;

const setInterface = (readlineInterface) => {
  readlineI = readlineInterface;
}; 

const closeInterface = () => {
    readlineI.close();
  };

// Função para solicitar e validar entradas
const requestResponse = (question, validation) => {
  return new Promise((resolve) => {
    const request = () => {
      readlineI.question(question, (response) => {
        if (validation(response)) {
          resolve(response);
        } else {
          console.log('Entrada inválida. Por favor, tente novamente.');
          request();
        }
      });
    };

    request();
  });
};

module.exports = {
    requestResponse,
    setInterface,
    closeInterface,
  };