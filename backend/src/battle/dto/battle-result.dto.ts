import { Pokemon } from '../../pokemon/entities/pokemon.entity';

export class BattleResultDto {
  id: string;
  playerPokemon: Pokemon;
  computerPokemon: Pokemon;
  winner: Pokemon;
  turns: number;
  battleLog: { turn: number; action: string; result: string }[];
  createdAt: Date;
}
