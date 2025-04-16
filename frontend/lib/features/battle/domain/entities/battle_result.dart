import 'pokemon.dart';

class BattleResult {
  final Pokemon playerPokemon;
  final Pokemon computerPokemon;
  final Pokemon winner;
  final int turns;
  final List<BattleLog> battleLog;

  const BattleResult({
    required this.playerPokemon,
    required this.computerPokemon,
    required this.winner,
    required this.turns,
    required this.battleLog,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is BattleResult &&
      other.winner == winner &&
      other.battleLog.length == battleLog.length;
  }

  @override
  int get hashCode => winner.hashCode ^ battleLog.hashCode;
}

class BattleLog {
  final int turn;
  final String action;
  final String result;

  const BattleLog({
    required this.turn,
    required this.action,
    required this.result,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is BattleLog &&
      other.turn == turn &&
      other.action == action &&
      other.result == result;
  }

  @override
  int get hashCode => 
      turn.hashCode ^ 
      action.hashCode ^ 
      result.hashCode;
} 