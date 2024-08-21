// ignore_for_file: avoid_print

/*
Cenário: Você está desenvolvendo um sistema de carrinho de compras para um e-commerce.
O carrinho deve ser acessível de qualquer parte da aplicação e deve persistir mesmo que o
usuário navegue para outras páginas.
Tarefa: Implemente o padrão Singleton para garantir que exista apenas uma instância do
carrinho de compras em toda a aplicação.

Dica: Crie uma classe CarrinhoDeCompras com um construtor que verifica se já existe uma
instância e a retorna, caso contrário, cria uma nova instância e a armazena em uma
propriedade estática.
*/

// Para rodar, acessa a pasta lib no terminal e execute: dart run ex_03.dart

void main() {

  ShoppingCart cart1 = ShoppingCart.instance;
  cart1.addItem('Notebook');
  cart1.addItem('Celular');

  ShoppingCart cart2 = ShoppingCart.instance;
  cart2.addItem('Fone de ouvidos');

  // Observe que os carrinhos terão os mesmos itens:
  print('Cart 1 Items: ${cart1.items}');
  print('Cart 2 Items: ${cart2.items}');

  // Verifique se os dois são da mesma instancia (SINGLETOWN). 
  print('Are cart1 and cart2 the same instance? ${identical(cart1, cart2)}');
}

class ShoppingCart {
  static final ShoppingCart _instance = ShoppingCart._internal();

  final List<String> _items = [];

  ShoppingCart._internal();

  factory ShoppingCart() {
    return _instance;
  }

  static ShoppingCart get instance => _instance;

  void addItem(String item) {
    _items.add(item);
    print('$item added to the cart.');
  }

  void removeItem(String item) {
    if (_items.contains(item)) {
      _items.remove(item);
      print('$item removed from the cart.');
    } else {
      print('$item is not in the cart.');
    }
  }

  // Getter to retrieve all items in the cart
  List<String> get items => List.unmodifiable(_items);
}




