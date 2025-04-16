import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { PokemonModule } from './pokemon/pokemon.module';
import { BattleModule } from './battle/battle.module';
import { ProxyModule } from './proxy/proxy.module';

@Module({
  imports: [
    // for environment variables
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    TypeOrmModule.forRoot({
      type: 'sqlite',
      database: 'pokemon.db',
      entities: [__dirname + '/**/*.entity{.ts,.js}'],
      synchronize: true, //! remove when finished
    }),
    PokemonModule,
    BattleModule,
    ProxyModule,
  ],
})
export class AppModule {}
