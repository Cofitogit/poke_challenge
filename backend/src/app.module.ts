import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { PokemonModule } from './pokemon/pokemon.module';
import { BattleModule } from './battle/battle.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'sqlite',
      database: 'pokemon.db',
      entities: [__dirname + '/**/*.entity{.ts,.js}'],
      synchronize: true, //! remove when finished
    }),
    PokemonModule,
    BattleModule,
  ],
})
export class AppModule {}
