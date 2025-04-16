import 'package:flutter/material.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/get_all_pokemons.dart';

enum PokemonLoadState { initial, loading, loaded, error }

class PokemonProvider extends ChangeNotifier {
  final GetAllPokemons _getAllPokemons;

  PokemonLoadState _state = PokemonLoadState.initial;
  List<Pokemon> _pokemons = [];
  String _errorMessage = '';

  PokemonProvider({
    required GetAllPokemons getAllPokemons,
  }) : _getAllPokemons = getAllPokemons;

  PokemonLoadState get state => _state;
  List<Pokemon> get pokemons => _pokemons;
  String get errorMessage => _errorMessage;

  Future<void> loadPokemons() async {
    _state = PokemonLoadState.loading;
    notifyListeners();

    try {
      _pokemons = await _getAllPokemons();
      _state = PokemonLoadState.loaded;
    } catch (e) {
      _state = PokemonLoadState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }
} 