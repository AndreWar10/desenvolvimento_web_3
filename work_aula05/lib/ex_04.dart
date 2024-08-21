// ignore_for_file: avoid_print

/*
Cenário: Você está desenvolvendo um editor de gráficos vetoriais. Os usuários podem criar
diferentes formas geométricas (retângulos, círculos, triângulos, etc.) e personalizá-las com
cores, tamanhos e outros atributos.
Tarefa: Implemente o padrão Protótipo para permitir que os usuários criem novas formas
geométricas clonando formas existentes e modificando seus atributos.

Dica: Crie um objeto protótipo para cada tipo de forma (ex: retanguloPrototipo,
circuloPrototipo, etc.). Utilize Object.create() para clonar o protótipo e personalize as cópias
conforme necessário.
*/

// Para rodar, acessa a pasta lib no terminal e execute: dart run ex_04.dart

void main() {
  // Protótipos
  Shape rectanglePrototype = Rectangle(color: 'vermelho', width: 10, height: 20);
  Shape circlePrototype = Circle(color: 'azul', radius: 15);
  Shape trianglePrototype = Triangle(color: 'verde', base: 8, height: 12);

  // Clonando e personalizando as formas
  Shape rectangleClone = rectanglePrototype.clone();
  rectangleClone.color = 'amarelo';
  
  Shape circleClone = circlePrototype.clone();
  circleClone.size = 20;

  Shape triangleClone = trianglePrototype.clone();
  triangleClone.color = 'roxo';
  
  rectangleClone.draw();  // Desenha um retângulo amarelo
  circleClone.draw();     // Desenha um círculo azul com tamanho alterado
  triangleClone.draw();   // Desenha um triângulo roxo
}


abstract class Shape {
  String color;
  double size;

  Shape({required this.color, required this.size});

  Shape clone();
  
  void draw();
}

class Rectangle extends Shape {
  double width;
  double height;

  Rectangle({required super.color, required this.width, required this.height})  : super(size: width * height);

  @override
  Shape clone() {
    return Rectangle(color: color, width: width, height: height);
  }

  @override
  void draw() {
    print('Desenhando um retângulo $color de largura $width e altura $height...');
  }
}

class Circle extends Shape {
  double radius;

  Circle({required super.color, required this.radius})  : super(size: 3.14 * radius * radius);

  @override
  Shape clone() {
    return Circle(color: color, radius: radius);
  }

  @override
  void draw() {
    print('Desenhando um circulo $color com radio de $radius...');
  }
}

class Triangle extends Shape {
  double base;
  double height;

  Triangle({required super.color, required this.base, required this.height})  : super(size: 0.5 * base * height);

  @override
  Shape clone() {
    return Triangle(color: color, base: base, height: height);
  }

  @override
  void draw() {
    print('Desenhando um triângulo $color de base $base e altura $height...');
  }
}





