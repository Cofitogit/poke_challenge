import '../../domain/entities/pokemon.dart';
import '../../domain/entities/battle_result.dart';
import '../../domain/repositories/pokemon_repository.dart';
import '../datasources/pokemon_remote_datasource.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource remoteDataSource;

  PokemonRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Pokemon>> getAllPokemons() async {
    final pokemonModels = await remoteDataSource.getAllPokemons();
    return pokemonModels.map((model) => model.toDomain()).toList();
  }

  @override
  Future<BattleResult> battle(String playerPokemonId) async {
    final battleResultModel = await remoteDataSource.battle(playerPokemonId);
    return battleResultModel.toDomain();
  }
} 