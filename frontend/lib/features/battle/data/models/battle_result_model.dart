import '../../domain/entities/battle_result.dart';
import 'pokemon_model.dart';

class BattleResultModel {
  final PokemonModel playerPokemon;
  final PokemonModel computerPokemon;
  final PokemonModel winner;
  final int turns;
  final List<BattleLogModel> battleLog;

  const BattleResultModel({
    required this.playerPokemon,
    required this.computerPokemon,
    required this.winner,
    required this.turns,
    required this.battleLog,
  });

  factory BattleResultModel.fromJson(Map<String, dynamic> json) {
    return BattleResultModel(
      playerPokemon: PokemonModel.fromJson(json['playerPokemon'] as Map<String, dynamic>),
      computerPokemon: PokemonModel.fromJson(json['computerPokemon'] as Map<String, dynamic>),
      winner: PokemonModel.fromJson(json['winner'] as Map<String, dynamic>),
      turns: json['turns'] as int,
      battleLog: (json['battleLog'] as List)
          .map((e) => BattleLogModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  BattleResult toDomain() {
    return BattleResult(
      winner: winner.toDomain(),
      computerPokemon: computerPokemon.toDomain(),
      playerPokemon: playerPokemon.toDomain(),
      turns: turns,
      battleLog: battleLog.map((log) => log.toDomain()).toList(),
    );
  }
}

class BattleLogModel {
  final int turn;
  final String action;
  final String result;

  const BattleLogModel({
    required this.turn,
    required this.action,
    required this.result,
  });

  factory BattleLogModel.fromJson(Map<String, dynamic> json) {
    return BattleLogModel(
      turn: json['turn'] as int,
      action: json['action'] as String,
      result: json['result'] as String,
    );
  }

  BattleLog toDomain() {
    return BattleLog(
      turn: turn,
      action: action,
      result: result,
    );
  }
} 