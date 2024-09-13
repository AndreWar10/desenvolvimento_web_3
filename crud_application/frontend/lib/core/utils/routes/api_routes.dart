class ApiRoutes {
  // URL base da sua API
  static const String baseUrl = 'http://172.20.192.32/'; // Altere para a URL real do seu backend em produção

  // Rotas de autenticação
  static const String signup = '$baseUrl/signup';          // POST para criar conta de usuário
  static const String login = '$baseUrl/login';            // POST para login de usuário
  static const String getUser = '$baseUrl/user';           // GET para obter informações do usuário autenticado

  // Rotas de produtos (lista de compras)
  static const String getItems = '$baseUrl/items';         // GET para buscar todos os itens da lista de compras
  static const String addItem = '$baseUrl/items';          // POST para adicionar um item à lista de compras
  static const String updateItem = '$baseUrl/items/';      // PUT para atualizar um item na lista (append ID no final)
  static const String deleteItem = '$baseUrl/items/';      // DELETE para remover um item da lista (append ID no final)

  // Rotas do carrinho de compras
  static const String getCart = '$baseUrl/cart';           // GET para obter os itens do carrinho
  static const String addToCart = '$baseUrl/cart';         // POST para adicionar um item ao carrinho
  static const String deleteFromCart = '$baseUrl/cart/';   // DELETE para remover um item do carrinho (append índice)

  // Upload de produtos com imagem
  static const String uploadProduct = '$baseUrl/upload-product'; // POST para enviar produtos com imagens

  // Exemplo: Rota para autenticação com o Firebase via REST API (opcional, se necessário)
  static const String firebaseAuthUrl = 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBlwjpe-fa610VmJe6HwqZygVDZ9kJFATg';
}
