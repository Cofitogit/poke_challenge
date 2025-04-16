class Pokemon {
  final String id;
  final String name;
  final String image;
  final int hp;
  final int attack;
  final int defense;
  final int speed;

  const Pokemon({
    required this.id,
    required this.name,
    required this.image,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.speed,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is Pokemon &&
      other.id == id &&
      other.name == name &&
      other.image == image &&
      other.hp == hp &&
      other.attack == attack &&
      other.defense == defense &&
      other.speed == speed;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ image.hashCode;
} 