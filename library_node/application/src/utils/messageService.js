class MessageService {
    constructor() {
        this.state = null;
        this.message = '';
        this.data = null;
    }

    input(message = 'Input...', data = null) {
        this.state = 'input';
        this.message = message;
        this.data = data;
        this.display();
    }

    end(message = 'Programa encerrado...', data = null) {
        this.state = 'end';
        this.message = message;
        this.data = data;
        this.display();
    }

    loading(message = 'Por favor, aguarde um momento...', data = null) {
        this.state = 'loading';
        this.message = message;
        this.data = data;
        this.display();
    }

    success(message = 'Operation successful!', data = null) {
        this.state = 'success';
        this.message = message;
        this.data = data;
        this.display();
    }

    error(message = 'An error occurred.', data = null) {
        this.state = 'error';
        this.message = message;
        this.data = data;
        this.display();
    }

    display() {
        switch (this.state) {
            case 'loading':
                console.log(`${this.message}`);
                break;
            case 'success':
                console.log(`${this.message}`);
                if (this.data) {
                    console.log('Data:', this.data);
                }
                break;
            case 'error':
                console.error(`${this.message}`);
                if (this.data) {
                    console.error('Error Details:', this.data);
                }
                break;
            case 'input':
                console.error(`${this.message}`);
                if (this.data) {
                    console.error('Data:', this.data);
                }
                break;
            case 'end':
                console.error(`${this.message}`);
                if (this.data) {
                    console.error('Data:', this.data);
                }
                break;
            default:
                console.log('Unknown state.');
        }
    }
}

module.exports = MessageService;
