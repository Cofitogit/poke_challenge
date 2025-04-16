import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { PokemonModule } from './pokemon/pokemon.module';
import { BattleModule } from './battle/battle.module';
import { ProxyModule } from './proxy/proxy.module';
import { databaseConfig } from './config/database.config';

@Module({
  imports: [
    // for environment variables
    ConfigModule.forRoot({
      isGlobal: true,
      load: [databaseConfig],
    }),
    TypeOrmModule.forRoot(databaseConfig()),
    PokemonModule,
    BattleModule,
    ProxyModule,
  ],
})
export class AppModule {}
