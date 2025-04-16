import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ValidationPipe } from '@nestjs/common';
import { getCorsConfig } from './config/cors.config';
import { DataSource } from 'typeorm';

/**
 * Main function to start the application
 */
async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Enable DTO validation
  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
    }),
  );

  app.enableCors(getCorsConfig(process.env.NODE_ENV));
  const port = process.env.PORT ?? 3000;

  // Ensure migrations are executed when the application starts
  const dataSource = app.get(DataSource);
  try {
    const pendingMigrations = await dataSource.showMigrations();
    if (pendingMigrations) {
      console.log('[MIGRATION] Pending migrations, executing...');
      await dataSource.runMigrations();
      console.log('[MIGRATION] Migrations executed correctly');
    } else {
      console.log('[MIGRATION] No pending migrations');
    }
  } catch (error) {
    console.error('[MIGRATION] Error executing migrations:', error);
  }

  await app.listen(port);
  console.log(`[SERVER] Server is running on port ${port}`);
}
void bootstrap();
