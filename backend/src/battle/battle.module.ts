import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { BattleController } from './controllers/battle.controller';
import { BattleService } from './services/battle.service';
import { Battle } from './entities/battle.entity';
import { PokemonModule } from '../pokemon/pokemon.module';

@Module({
  imports: [TypeOrmModule.forFeature([Battle]), PokemonModule],
  controllers: [BattleController],
  providers: [BattleService],
  exports: [BattleService],
})
export class BattleModule {}
