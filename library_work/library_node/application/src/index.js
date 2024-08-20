const readline = require('readline');
const MessageService = require('./utils/messageService');
const AuthService = require('./auth/authService');
const { setInterface, closeInterface } = require('./utils/readlineInterface');
const { registerBook } = require('./interfaces/BookInterface');
const { registerAuthor } = require('./interfaces/AuthorInterface');
const { registerUser } = require('./interfaces/UserInterface');
const { registerLending } = require('./interfaces/LendingInterface');

const readlineI = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

setInterface(readlineI);

let currentUser = null;

async function showMenu() {
    const messageService = new MessageService();

    messageService.input("\n" + currentUser.name + ", escolha uma opção:");
    messageService.input("1. Cadastrar Livro");
    messageService.input("2. Cadastrar Autor");
    messageService.input("3. Cadastrar Usuário");
    messageService.input("4. Emprestar Livro");
    messageService.input("9. Sair\n");

    readlineI.question("Digite o número da opção desejada: ", async (option) => {
        switch (option) {
            case '1':
                await registerBook();
                showMenu();
                break;
            case '2':
                await registerAuthor();
                showMenu();
                break;
            case '3':
                await registerUser();
                showMenu();
                break;
            case '4':
                await registerLending();
                showMenu();
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

async function login() {
    const authService = new AuthService();
    const messageService = new MessageService();

    readlineI.question("Nome de usuário: ", async (username) => {
        readlineI.question("Senha: ", async (password) => {
            const authResult = await authService.authenticate(username, password);

            if (!authResult.exists) {
                messageService.error("Usuário não existe. Acesso negado.");
                showInitialMenu();
            } else if (authResult.authenticated) {
                currentUser = authResult.user; // Armazenar o usuário logado
                messageService.success("Login bem-sucedido!");
                showMenu();
            } else {
                messageService.error("Senha incorreta. Tente novamente.");
                login();
            }
        });
    });
}

async function registerAccount() {

    await registerUser();

}

async function showInitialMenu() {
    const messageService = new MessageService();

    messageService.input("\nEscolha uma opção:");
    messageService.input("1. Fazer Login");
    messageService.input("9. Sair\n");

    readlineI.question("Digite o número da opção desejada: ", async (option) => {
        switch (option) {
            case '1':
                await login();
                break;
            case '9':
                await closeInterface();
                messageService.end();
                break;
            default:
                messageService.error("Opção inválida, tente novamente.");
                showInitialMenu();
                break;
        }
    });
}

showInitialMenu();

module.exports = {
    showMenu
};
