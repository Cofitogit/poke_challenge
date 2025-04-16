# Pokemon Battle Challenge

This is a Pokemon battle application where each Pokemon has different stats such as attack, defense, HP, and speed. The goal is to make them battle against each other following specific battle rules.

## Battle Rules

- The Pokemon with the highest speed attacks first. If speeds are equal, the Pokemon with the highest attack goes first.
- Damage is calculated by subtracting defense from attack (attack - defense). If attack is less than or equal to defense, damage is 1.
- Damage is subtracted from HP.
- Pokemon fight in turns, with all turns calculated in the same request.
- The winner is the Pokemon that reduces the opponent's HP to zero.

## Backend Requirements

- Implement database migrations to populate a table with Pokemon data
- Create an endpoint to list all Pokemon
- Implement a battle endpoint
- Store battle results in a separate table

## Frontend Requirements

- Implement UI/UX to list and select Pokemon
- Create Pokemon cards displaying stats
- Automatically and randomly select an opponent when starting a battle
- Show battle results
- Implement basic responsiveness
- Connect with the backend

## Technology Stack

### Backend
- NestJS
- TypeORM
- SQLite

### Frontend
- Flutter
- Provider
- Material Design

## Project Structure

- `backend/`: NestJS server with Typeorm and SQLite
- `frontend/`: Flutter application

## Migrations

```bash
# create
npm run migration:create --name=NameMigration

# update
npm run migration:generate --name=NameMigration

# run pending migrations
npm run migration:run

# revert last migration
npm run migration:revert
```

### Current migrations

- **CreatePokemonTable**: Creates the initial Pokemon table structure
- **SeedPokemon**: Loads initial Pokemon data from JSON file
