import { DataSource } from 'typeorm';
import * as dotenv from 'dotenv';
import { join } from 'path';

// Cargar variables de entorno
dotenv.config({ path: '.env' });

// Configuración para usar con TypeORM CLI
export default new DataSource({
  type: 'sqlite',
  database: process.env.DATABASE_PATH || 'pokemon.db',
  entities: [join(__dirname, '../**/*.entity{.ts,.js}')],
  migrations: [join(__dirname, '../migrations/*{.ts,.js}')],
  synchronize: false,
  migrationsRun: false,
  logging: true,
});
