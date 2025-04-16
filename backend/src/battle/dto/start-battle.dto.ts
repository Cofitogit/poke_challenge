import { IsNotEmpty, IsString } from 'class-validator';

export class StartBattleDto {
  @IsNotEmpty()
  @IsString()
  playerPokemonId: string;
}
