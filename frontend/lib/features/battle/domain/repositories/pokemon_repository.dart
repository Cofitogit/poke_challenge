import '../entities/pokemon.dart';
import '../entities/battle_result.dart';

abstract class PokemonRepository {
  Future<List<Pokemon>> getAllPokemons();
  Future<BattleResult> battle(String playerPokemonId);
} 