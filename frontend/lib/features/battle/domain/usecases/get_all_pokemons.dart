import '../entities/pokemon.dart';
import '../repositories/pokemon_repository.dart';

class GetAllPokemons {
  final PokemonRepository repository;

  GetAllPokemons(this.repository);

  Future<List<Pokemon>> call() {
    return repository.getAllPokemons();
  }
} 