const readline = require('readline');
const BookService = require('./services/BookService');
const { validarInteiroPositivo, validarNome } = require('./utils/inputValidator');
const BookModel = require('./models/BookModel');

// Configura o readline para capturar entradas do usuário
const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

// Função para solicitar e validar entradas
const solicitarEntrada = (pergunta, validacao) => {
  return new Promise((resolve) => {
    const solicitar = () => {
      rl.question(pergunta, (resposta) => {
        if (validacao(resposta)) {
          resolve(resposta);
        } else {
          console.log('Entrada inválida. Por favor, tente novamente.');
          solicitar();
        }
      });
    };

    solicitar();
  });
};

// Função para capturar dados e salvar no Firestore
const cadastrarLivro = async () => {
  try {
    const author = await solicitarEntrada('Autor: ', (valor) => validarNome(valor));
    const isbn = await solicitarEntrada('ISBN: ', (valor) => validarInteiroPositivo(valor));
    const title = await solicitarEntrada('Título: ', (valor) => validarNome(valor));
    const year = await solicitarEntrada('Ano: ', (valor) => validarInteiroPositivo(valor));

    const book = new BookModel(author, isbn, title, year);
    await BookService.addBook(book);
  } catch (error) {
    console.error('Erro ao cadastrar livro:', error);
  } finally {
    rl.close();
  }
};

module.exports = cadastrarLivro;
