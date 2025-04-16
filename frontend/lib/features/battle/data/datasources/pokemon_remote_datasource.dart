import '../../../../core/exceptions/general_exception.dart';
import '../models/pokemon_model.dart';
import '../models/battle_result_model.dart';
import 'package:frontend/core/services/index.dart';

abstract class PokemonRemoteDataSource {
  Future<List<PokemonModel>> getAllPokemons();
  Future<BattleResultModel> battle(String playerPokemonId);
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  final ApiService _apiService;

  PokemonRemoteDataSourceImpl(this._apiService);

  @override
  Future<List<PokemonModel>> getAllPokemons() async {
    try {
      final response = await _apiService.get('/pokemon');

      return (response as List).map((json) => PokemonModel.fromJson(json as Map<String, dynamic>)).toList();
    } on GeneralException {
      rethrow;
    } catch (e, stackTrace) {
      LoggerService.logError(
        e,
        stackTrace: stackTrace,
        message: 'Error getting Pokémon list',
        name: 'PokemonRemoteDataSource',
      );
      throw const GeneralException(
        message: 'Error getting Pokémon list',
      );
    }
  }

  @override
  Future<BattleResultModel> battle(String playerPokemonId) async {
    try {
      final response = await _apiService.post('/battle', data: {
        'playerPokemonId': playerPokemonId,
      });

      return BattleResultModel.fromJson(response as Map<String, dynamic>);
    } on GeneralException {
      rethrow;
    } catch (e, stackTrace) {
      LoggerService.logError(
        e,
        stackTrace: stackTrace,
        message: 'Error in the battle',
        name: 'PokemonRemoteDataSource',
      );
      throw const GeneralException(
        message: 'Error in the battle',
      );
    }
  }
}
