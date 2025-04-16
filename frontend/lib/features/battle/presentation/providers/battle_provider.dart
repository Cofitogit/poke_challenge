import 'package:flutter/material.dart';
import '../../domain/entities/battle_result.dart';
import '../../domain/entities/pokemon.dart';
import '../../domain/usecases/battle_pokemons.dart';

enum BattleState { initial, battling, completed, error }

class BattleProvider extends ChangeNotifier {
  final BattlePokemons _battlePokemons;

  BattleState _state = BattleState.initial;
  BattleResult? _battleResult;
  String _errorMessage = '';

  Pokemon? _selectedPokemon;
  Pokemon? _opponentPokemon;

  BattleProvider({
    required BattlePokemons battlePokemons,
  }) : _battlePokemons = battlePokemons;

  BattleState get state => _state;
  BattleResult? get battleResult => _battleResult;
  String get errorMessage => _errorMessage;

  Pokemon? get selectedPokemon => _selectedPokemon;
  Pokemon? get opponentPokemon => _opponentPokemon;

  void selectPokemon(Pokemon pokemon) {
    _selectedPokemon = pokemon;
    notifyListeners();
  }

  void selectOpponent(Pokemon pokemon) {
    _opponentPokemon = pokemon;
    notifyListeners();
  }

  Future<void> startBattle() async {
    if (_selectedPokemon == null) {
      _state = BattleState.error;
      _errorMessage = 'Debe seleccionar ambos Pokémon';
      notifyListeners();
      return;
    }

    _state = BattleState.battling;
    notifyListeners();

    try {
      _battleResult = await _battlePokemons(
        _selectedPokemon!.id,
      );
      _state = BattleState.completed;
      _opponentPokemon = _battleResult?.computerPokemon;
    } catch (e) {
      _state = BattleState.error;
      _errorMessage = e.toString();
    }

    notifyListeners();
  }

  void reset() {
    _state = BattleState.initial;
    _battleResult = null;
    _errorMessage = '';
    _selectedPokemon = null;
    _opponentPokemon = null;
    notifyListeners();
  }
}
