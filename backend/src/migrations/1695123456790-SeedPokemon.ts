import { MigrationInterface, QueryRunner } from 'typeorm';
import * as fs from 'fs';
import * as path from 'path';

interface PokemonData {
  pokemon: Array<{
    id: string;
    name: string;
    attack: number;
    defense: number;
    hp: number;
    speed: number;
    type: string;
    imageUrl: string;
  }>;
}

interface CountResult {
  count: number;
}

/**
 * Migration to seed the Pokemon table
 */
export class SeedPokemon1695123456790 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    // Read the Pokemon JSON file
    const jsonPath = path.join(__dirname, '../../../challenge/pokemon.json');
    const jsonData = JSON.parse(
      fs.readFileSync(jsonPath, 'utf8'),
    ) as PokemonData;

    // Insert each Pokemon only if it doesn't exist
    for (const pokemon of jsonData.pokemon) {
      // Check if the Pokemon already exists
      const exists = (await queryRunner.query(
        'SELECT COUNT(*) as count FROM pokemon WHERE id = ?',
        [pokemon.id],
      )) as CountResult[];

      if (exists[0].count === 0) {
        await queryRunner.query(
          `INSERT INTO pokemon 
           (id, name, attack, defense, hp, speed, type, imageUrl) 
           VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
          [
            pokemon.id,
            pokemon.name,
            pokemon.attack,
            pokemon.defense,
            pokemon.hp,
            pokemon.speed,
            pokemon.type,
            pokemon.imageUrl,
          ],
        );
      }
    }
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    // Delete all data from the Pokemon table
    await queryRunner.query('DELETE FROM pokemon');
  }
}
