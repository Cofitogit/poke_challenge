import '../../domain/entities/pokemon.dart';

class PokemonModel {
  final String id;
  final String name;
  final String image;
  final int hp;
  final int attack;
  final int defense;
  final int speed;

  const PokemonModel({
    required this.id,
    required this.name,
    required this.image,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    return PokemonModel(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['imageUrl'] as String,
      hp: json['hp'] as int,
      attack: json['attack'] as int,
      defense: json['defense'] as int,
      speed: json['speed'] as int,
    );
  }

  Pokemon toDomain() {
    return Pokemon(
      id: id,
      name: name,
      image: image,
      hp: hp,
      attack: attack,
      defense: defense,
      speed: speed,
    );
  }
}
