import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'api_service.dart';
import '../../features/battle/data/datasources/pokemon_remote_datasource.dart';
import '../../features/battle/data/repositories/pokemon_repository_impl.dart';
import '../../features/battle/domain/repositories/pokemon_repository.dart';
import '../../features/battle/domain/usecases/battle_pokemons.dart';
import '../../features/battle/domain/usecases/get_all_pokemons.dart';
import '../../features/battle/presentation/providers/battle_provider.dart';
import '../../features/battle/presentation/providers/pokemon_provider.dart';

/// Service to manage application dependencies.
/// Implements dependency injection pattern.
class DependenciesService {
  /// Single instance of the service (Singleton)
  static final DependenciesService _instance = DependenciesService._internal();

  /// Factory constructor that returns the single instance
  factory DependenciesService() => _instance;

  /// Private constructor to implement Singleton pattern
  DependenciesService._internal();

  /// Creates and returns all providers needed for the application
  List<SingleChildWidget> createProviders() {
    // Services
    final apiService = ApiService();
    
    // Data sources
    final pokemonDataSource = PokemonRemoteDataSourceImpl(apiService);
    
    // Repositories
    final PokemonRepository pokemonRepository = PokemonRepositoryImpl(pokemonDataSource);
    
    // Use cases
    final getAllPokemons = GetAllPokemons(pokemonRepository);
    final battlePokemons = BattlePokemons(pokemonRepository);

    return [
      ChangeNotifierProvider<PokemonProvider>(
        create: (_) => PokemonProvider(
          getAllPokemons: getAllPokemons,
        ),
      ),
      ChangeNotifierProvider<BattleProvider>(
        create: (_) => BattleProvider(
          battlePokemons: battlePokemons,
        ),
      ),
    ];
  }
} 