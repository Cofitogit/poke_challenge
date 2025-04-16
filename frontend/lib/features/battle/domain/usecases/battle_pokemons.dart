import '../entities/battle_result.dart';
import '../repositories/pokemon_repository.dart';

class BattlePokemons {
  final PokemonRepository repository;

  BattlePokemons(this.repository);

  Future<BattleResult> call(String playerPokemonId) {
    return repository.battle(playerPokemonId);
  }
} 