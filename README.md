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
- **CreateBattleTable**: Creates the Battle table structure

### Steps to run the Project

#### Backend Setup
```bash
# Navigate to the backend directory
cd backend

# Install all required dependencies
npm install

# Copy the environment configuration file
# This file contains database settings and other configurations
cp .env.example .env

# Start the development server with hot-reload enabled
# This will compile the TypeScript code and run migrations automatically
npm run start:dev
```

#### Frontend Setup
```bash
# Open a new terminal window/tab

# Navigate to the frontend directory
cd frontend

# Install all Flutter dependencies
flutter pub get

# Run the application in a Chrome browser
flutter run -d chrome
```

#### Verifying the Setup
- Backend should be running on http://localhost:3000
- Frontend should open automatically in your Chrome browser
- If you encounter any issues with the database, ensure migrations have run successfully


### Versions Used
- Node.js: v18.x
- Flutter: v3.27.4


#### Using FVM (Flutter Version Management)
If you're using FVM to manage Flutter versions, follow these steps instead:

```bash
cd frontend
# Install the specific Flutter version required for this project
fvm install 3.27.4

# Set this version as the one to use for this project
fvm use 3.27.4

# Get dependencies using FVM
fvm flutter pub get

# Run the application with FVM
fvm flutter run -d chrome
```

This ensures you're using the correct Flutter version for this project regardless of your global Flutter installation.

#### Using NVM (Node Version Management)
If you're using NVM to manage Node.js versions, follow these steps instead:

```bash
# Navigate to the backend directory
cd backend

# Install the specific Node.js version required for this project
nvm install 18.20.4

# Set this version as the one to use for this project
nvm use 18.20.4

# Install dependencies using npm
npm install

# Start the development server
npm run start:dev
```

This ensures you're using the correct Node.js version for this project, which prevents compatibility issues with dependencies.

