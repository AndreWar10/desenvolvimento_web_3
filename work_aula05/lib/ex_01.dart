// ignore_for_file: avoid_print

/*
Exercício 1: Fábrica Abstrata
Cenário: Imagine que você está desenvolvendo um sistema de criação de personagens para
um jogo. Os personagens podem ser de diferentes raças (humano, elfo, orc, etc.) e cada raça
tem atributos específicos (força, agilidade, inteligência, etc.).
Tarefa: Implemente uma Fábrica Abstrata para criar personagens de diferentes raças,
garantindo que cada raça tenha seus atributos básicos definidos de forma consistente.

Dica: Crie uma classe abstrata FabricaDePersonagens com um método criarPersonagem().
Implemente fábricas concretas para cada raça (ex: FabricaDeHumanos, FabricaDeElfos, etc.)
que herdam da fábrica abstrata e retornam objetos Personagem com os atributos específicos
da raça.
*/

// Para rodar, acessa a pasta lib no terminal e execute: dart run ex_01.dart

void main() {
  CharacterFactory humanFactory = HumanFactory();
  CharacterFactory elfFactory = ElfFactory();
  CharacterFactory orcFactory = OrcFactory();

  Character human = humanFactory.createCharacter();
  Character elf = elfFactory.createCharacter();
  Character orc = orcFactory.createCharacter();
  
  print(human);
  print(elf);
  print(orc);
}

class Character {
  final String race;
  final int strength;
  final int agility;
  final int intelligence;

  Character({required this.race, required this.strength, required this.agility, required this.intelligence});

  @override
  String toString() {
    return 'Race: $race, Strength: $strength, Agility: $agility, Intelligence: $intelligence';
  }
}

abstract class CharacterFactory {
  Character createCharacter();
}

class HumanFactory extends CharacterFactory {
  @override
  Character createCharacter() {
    return Character(race: 'Human', strength: 10, agility: 7, intelligence: 8);
  }
}

class ElfFactory extends CharacterFactory {
  @override
  Character createCharacter() {
    return Character(race: 'Elf', strength: 7, agility: 10, intelligence: 9);
  }
}

class OrcFactory extends CharacterFactory {
  @override
  Character createCharacter() {
    return Character(race: 'Orc', strength: 12, agility: 5, intelligence: 6);
  }
}



