import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Battle } from '../entities/battle.entity';
import { Pokemon } from '../../pokemon/entities/pokemon.entity';
import { PokemonService } from '../../pokemon/services/pokemon.service';
import { StartBattleDto } from '../dto/start-battle.dto';
import { BattleResultDto } from '../dto/battle-result.dto';

type PokemonWithCurrentHp = Pokemon & { currentHp: number };

@Injectable()
export class BattleService {
  constructor(
    @InjectRepository(Battle)
    private readonly battleRepository: Repository<Battle>,
    private readonly pokemonService: PokemonService,
  ) {}

  async startBattle(startBattleDto: StartBattleDto): Promise<BattleResultDto> {
    const playerPokemon = await this.pokemonService.findOne(
      startBattleDto.playerPokemonId,
    );
    const allPokemon = await this.pokemonService.findAll();
    const availableComputerPokemon = allPokemon.filter(
      (p) => p.id !== playerPokemon.id,
    );

    const computerPokemon =
      availableComputerPokemon[
        Math.floor(Math.random() * availableComputerPokemon.length)
      ];

    const battleResult = this.simulateBattle(playerPokemon, computerPokemon);
    const battle = new Battle();
    battle.playerPokemonId = playerPokemon.id;
    battle.computerPokemonId = computerPokemon.id;
    battle.winnerId = battleResult.winner.id;
    battle.turns = battleResult.turns;
    battle.battleLog = battleResult.battleLog;
    const savedBattle = await this.battleRepository.save(battle);
    return {
      id: savedBattle.id,
      playerPokemon,
      computerPokemon,
      winner: battleResult.winner,
      turns: battleResult.turns,
      battleLog: battleResult.battleLog,
      createdAt: savedBattle.createdAt,
    };
  }

  async getBattleHistory(): Promise<BattleResultDto[]> {
    const battles = await this.battleRepository.find({
      relations: ['playerPokemon', 'computerPokemon', 'winner'],
      order: { createdAt: 'DESC' },
    });

    return battles.map((battle) => ({
      id: battle.id,
      playerPokemon: battle.playerPokemon,
      computerPokemon: battle.computerPokemon,
      winner: battle.winner,
      turns: battle.turns,
      battleLog: battle.battleLog,
      createdAt: battle.createdAt,
    }));
  }

  private simulateBattle(
    playerPokemon: Pokemon,
    computerPokemon: Pokemon,
  ): {
    winner: Pokemon;
    turns: number;
    battleLog: { turn: number; action: string; result: string }[];
  } {
    // Copy the Pokémon to avoid modifying the originals
    const player: PokemonWithCurrentHp = {
      ...playerPokemon,
      currentHp: playerPokemon.hp,
    };
    const computer: PokemonWithCurrentHp = {
      ...computerPokemon,
      currentHp: computerPokemon.hp,
    };
    let turn = 1;
    const battleLog: { turn: number; action: string; result: string }[] = [];
    const { firstAttacker, secondAttacker } = this.determineAttackOrder(
      player,
      computer,
    );

    while (player.currentHp > 0 && computer.currentHp > 0) {
      const firstDamage = this.calculateDamage(firstAttacker, secondAttacker);
      secondAttacker.currentHp = Math.max(
        0,
        secondAttacker.currentHp - firstDamage,
      );

      battleLog.push({
        turn,
        action: `${firstAttacker.name} attacks ${secondAttacker.name}`,
        result: `Causes ${firstDamage} damage. ${secondAttacker.name} has ${secondAttacker.currentHp} HP left`,
      });
      // Check if the second attacker can still attack
      if (secondAttacker.currentHp > 0) {
        const secondDamage = this.calculateDamage(
          secondAttacker,
          firstAttacker,
        );
        firstAttacker.currentHp = Math.max(
          0,
          firstAttacker.currentHp - secondDamage,
        );

        battleLog.push({
          turn,
          action: `${secondAttacker.name} attacks ${firstAttacker.name}`,
          result: `Causes ${secondDamage} damage. ${firstAttacker.name} has ${firstAttacker.currentHp} HP left`,
        });
      }
      turn++;
    }
    const winner = player.currentHp > 0 ? playerPokemon : computerPokemon;
    return {
      winner,
      turns: turn - 1,
      battleLog,
    };
  }

  private calculateDamage(
    attacker: Pokemon & { currentHp?: number },
    defender: Pokemon & { currentHp?: number },
  ): number {
    // If attack <= defense, damage is 1
    // Otherwise, damage is attack - defense
    const damage =
      attacker.attack <= defender.defense
        ? 1
        : attacker.attack - defender.defense;
    return damage;
  }

  private determineAttackOrder(
    player: PokemonWithCurrentHp,
    computer: PokemonWithCurrentHp,
  ): {
    firstAttacker: PokemonWithCurrentHp;
    secondAttacker: PokemonWithCurrentHp;
  } {
    // The faster pokemon attacks first
    if (player.speed !== computer.speed) {
      return player.speed > computer.speed
        ? { firstAttacker: player, secondAttacker: computer }
        : { firstAttacker: computer, secondAttacker: player };
    }

    // If there is a tie in speed, the one with higher attack goes first
    return player.attack >= computer.attack
      ? { firstAttacker: player, secondAttacker: computer }
      : { firstAttacker: computer, secondAttacker: player };
  }
}
