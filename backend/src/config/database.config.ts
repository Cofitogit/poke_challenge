import { registerAs } from '@nestjs/config';
import { DataSourceOptions } from 'typeorm';
import { join } from 'path';

/**
 * Configuración centralizada para la base de datos SQLite
 */
export const databaseConfig = registerAs(
  'database',
  (): DataSourceOptions => ({
    type: 'sqlite',
    database: process.env.DATABASE_PATH || 'pokemon.db',
    entities: [join(__dirname, '../**/*.entity{.ts,.js}')],
    migrations: [join(__dirname, '../migrations/*{.ts,.js}')],
    synchronize: process.env.NODE_ENV !== 'production',
    migrationsRun: true,
    logging: process.env.NODE_ENV !== 'production',
  }),
);
