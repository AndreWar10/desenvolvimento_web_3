const axios = require('axios');

const model = {
    produtos: [],
    carrinho: [],

    obterProdutos: async () => {
        try {
            const response = await axios.get('http://localhost:3001/produtos');
            if (response.status != 200) {
                throw new Error('Erro ao obter produtos do servidor');
            }
            const data = await response.data;
            this.produtos = data;
            console.log("Produtos obtidos do servidor:", data); //testando pq não carregou
            return data;
        } catch (error) {
            console.error(error);
            alert("Erro ao obter produtos. Por favor, tente novamente.");
            return []; 
        }
    },

    obterCarrinho: async () => {
        const response = await axios.get('http://localhost:3002/carrinho');
        if (response.status != 200) {
            throw new Error('Erro ao obter o carrinho do servidor');
        }
        const data = await response.data;
        this.carrinho = data;
        return data;
    },

    adicionarAoCarrinho: async (produtoId) => {
        try {
            const productResponse = await axios.get(`http://localhost:3001/produtos/${produtoId}`);
            if (!productresponse.status == 200) {
                throw new Error('Erro ao buscar detalhes do produto');
            }
            const produto = await productresponse.data;

            const response = await axios.get(`http://localhost:3002/carrinho`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ id: produtoId, nome: produto.nome, quantidade: 1 })
            });

            if (response.status == 200) {
                this.carrinho = await this.obterCarrinho();
            } else {
                throw new Error('Erro ao adicionar item ao carrinho');
            }
        } catch (error) {
            console.error(error);
            alert("Erro ao adicionar item ao carrinho. Por favor, tente novamente.");
        }
    },

    removerDoCarrinho: async (index) => {
        try {
            const response = await axios.get(`http://localhost:3002/carrinho/${index}`, {
                method: 'DELETE'
            });

            if (response.status == 200) {
                this.carrinho = await this.obterCarrinho();
            } else {
                throw new Error('Erro ao remover item do carrinho');
            }
        } catch (error) {
            console.error(error);
            alert("Erro ao remover item do carrinho. Por favor, tente novamente.");
        }
    },

    finalizarCompra: async () => {
        if (this.carrinho.length === 0) {
            alert("Seu carrinho está vazio!");
            return;
        }

        try {
            const response = await axios.get('http://localhost:3003/pedidos', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ itens: this.carrinho })
            });

            if (response.status == 200) {
                const resultado = await response.data;
                alert(resultado.message + '\nValor total: R$ ' + resultado.valorTotal);
                this.carrinho = []; 
                view.renderizarCarrinho(this.carrinho);
            } else {
                const errorData = await response.data;
                alert(`Erro ao finalizar compra: ${errorData.error}`);
            }
        } catch (error) {
            console.error(error);
            alert("Erro ao finalizar compra. Por favor, tente novamente.");
        }
    }
};

