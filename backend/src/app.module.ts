import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { PokemonModule } from './pokemon/pokemon.module';
import { BattleModule } from './battle/battle.module';
import { ProxyModule } from './proxy/proxy.module';
import { databaseConfig } from './config/database.config';
import { join } from 'path';

@Module({
  imports: [
    // for environment variables
    ConfigModule.forRoot({
      isGlobal: true,
      load: [databaseConfig],
    }),
    TypeOrmModule.forRoot({
      type: 'sqlite',
      database: process.env.DATABASE_PATH || 'pokemon.db',
      entities: [join(__dirname, '**', '*.entity{.ts,.js}')],
      migrations: [join(__dirname, 'migrations', '*{.ts,.js}')],
      synchronize: process.env.NODE_ENV !== 'production',
      migrationsRun: true,
    }),
    PokemonModule,
    BattleModule,
    ProxyModule,
  ],
})
export class AppModule {}
