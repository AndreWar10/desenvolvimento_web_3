const readline = require('readline');
const MessageService = require('./utils/messageService');
const { setInterface, closeInterface } = require('./utils/readlineInterface');
const { registerBook } = require('./interfaces/BookInterface');
const { registerAuthor } = require('./interfaces/AuthorInterface');
const { registerUser } = require('./interfaces/UserInterface');

const readlineI = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Change the interface to use in the functions in AppInterface.js
setInterface(readlineI);

function showMenu() {
    const messageService = new MessageService();

    messageService.input("\nEscolha uma opção:");
    messageService.input("1. Cadastrar Livro");
    messageService.input("2. Cadastrar Autor");
    messageService.input("3. Cadastrar Usuário");
    messageService.input("9. Sair\n");

    readlineI.question("Digite o número da opção desejada: ", (option) => {
        switch (option) {
            case '1':
                registerBook();
                break;
            case '2':
                registerAuthor();
                break;
            case '3':
                registerUser();
                break;
            case '9':
                closeInterface();
                messageService.end();
                break;
            default:
                messageService.error("Opção inválida, tente novamente.");
                showMenu();
                break;
        }
    });
}

showMenu();
