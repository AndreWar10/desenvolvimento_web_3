const readline = require('readline');
const MessageService = require('./utils/messageService');
const { setInterface, closeInterface } = require('./utils/readlineInterface');
const AuthService = require('./auth/authService');
const { registerBook } = require('./interfaces/BookInterface');
const { registerAuthor } = require('./interfaces/AuthorInterface');
const { registerUser } = require('./interfaces/UserInterface');

const readlineI = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

setInterface(readlineI);

// Variável global para armazenar o usuário logado
let currentUser = null;

async function showMenu() {
    const messageService = new MessageService();

    messageService.input("\n"+ currentUser.name + ", escolha uma opção:");
    messageService.input("1. Cadastrar Livro");
    messageService.input("2. Cadastrar Autor");
    messageService.input("3. Cadastrar Usuário");
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
    const authService = new AuthService();
    const messageService = new MessageService();

    readlineI.question("Nome de usuário: ", async (username) => {
        const userDoc = await authService.getUser(username);
        if (userDoc.exists) {
            messageService.error("Usuário já existe. Tente outro nome.");
            registerAccount(); // Solicita novamente se o usuário já existir
        } else {
            readlineI.question("Senha: ", async (password) => {
                await authService.createUser(username, password);
                messageService.success("Conta criada com sucesso!");
                login(); // Após criar a conta, redireciona para o login
            });
        }
    });
}

function showInitialMenu() {
    const messageService = new MessageService();

    messageService.input("\nEscolha uma opção:");
    messageService.input("1. Fazer Login");
    messageService.input("2. Criar Conta");
    messageService.input("9. Sair\n");

    readlineI.question("Digite o número da opção desejada: ", (option) => {
        switch (option) {
            case '1':
                login();
                break;
            case '2':
                registerAccount();
                break;
            case '9':
                closeInterface();
                messageService.end();
                break;
            default:
                messageService.error("Opção inválida, tente novamente.");
                showInitialMenu();
                break;
        }
    });
}

// Inicializa o menu inicial
showInitialMenu();

module.exports = {
    showMenu
  };
