// ignore_for_file: avoid_print

/*
Cenário: Você está desenvolvendo um sistema de pedidos de comida online. Os clientes
podem personalizar seus pedidos com diversos ingredientes e opções.
Tarefa: Implemente o padrão Construtor para criar pedidos de comida, permitindo que os
clientes adicionem ingredientes, escolham o tamanho, o tipo de massa (se aplicável), etc., de
forma flexível e incremental.

Dica: Crie uma classe PedidoBuilder com métodos para adicionar cada tipo de ingrediente,
escolher o tamanho, etc. O método construir() deve retornar o objeto Pedido completo.
*/

// Para rodar, acessa a pasta lib no terminal e execute: dart run ex_02.dart

void main() {

  Order order = OrderBuilder()
    .chooseSize(Size.large)
    .chooseDoughType(DoughType.thin)
    .addIngredient("Queijo")
    .addIngredient("Tomate")
    .addIngredient("Pepperoni")
    .build();

  print(order);
}

class Order {
  final Size size;
  final DoughType doughType;
  final List<String> ingredients;

  Order._builder(OrderBuilder builder) : size = builder._size!, doughType = builder._doughType!, ingredients = builder._ingredients;

  @override
  String toString() {
    return 'Order: Size: $size, Dough Type: $doughType, Ingredients: ${ingredients.join(", ")}';
  }
}

enum Size { small, medium, large }
enum DoughType { thin, thick, wholeGrain }

// Builder class to create the order
class OrderBuilder {
  Size? _size;
  DoughType? _doughType;
  final List<String> _ingredients = [];

  // Method to choose the size of the order
  OrderBuilder chooseSize(Size size) {
    _size = size;
    return this;
  }

  // Method to choose the type of dough
  OrderBuilder chooseDoughType(DoughType doughType) {
    _doughType = doughType;
    return this;
  }

  // Method to add ingredients
  OrderBuilder addIngredient(String ingredient) {
    _ingredients.add(ingredient);
    return this;
  }

  // Method to build the order
  Order build() {
    if (_size == null) {
      throw Exception('Order size was not selected');
    }
    if (_doughType == null) {
      throw Exception('Dough type was not selected');
    }
    return Order._builder(this);
  }
}




