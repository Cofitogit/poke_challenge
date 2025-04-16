import { DataSource } from 'typeorm';
import { Pokemon } from '../pokemon/entities/pokemon.entity';
import * as fs from 'fs';
import * as path from 'path';

interface PokemonData {
  pokemon: Pokemon[];
}

async function seed() {
  const dataSource = new DataSource({
    type: 'sqlite',
    database: 'pokemon.db',
    entities: [Pokemon],
    synchronize: true,
  });

  await dataSource.initialize();

  const pokemonRepository = dataSource.getRepository(Pokemon);

  // Read the JSON file
  const jsonPath = path.join(__dirname, '../../../challenge/pokemon.json');
  const jsonData = JSON.parse(fs.readFileSync(jsonPath, 'utf8')) as PokemonData;

  // Clear existing data
  await pokemonRepository.clear();

  // Insert new data
  for (const pokemon of jsonData.pokemon) {
    await pokemonRepository.save(pokemon);
  }

  console.log('Database seeded successfully!');
  await dataSource.destroy();
}

seed().catch((error) => {
  console.error('Error seeding database:', error);
  process.exit(1);
});
