import { MigrationInterface, QueryRunner, Table } from 'typeorm';

/**
 * Migration to create the Pokemon table
 */
export class CreatePokemonTable1695123456789 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'pokemon',
        columns: [
          {
            name: 'id',
            type: 'varchar',
            isPrimary: true,
          },
          {
            name: 'name',
            type: 'varchar',
            isNullable: false,
          },
          {
            name: 'attack',
            type: 'int',
            isNullable: false,
          },
          {
            name: 'defense',
            type: 'int',
            isNullable: false,
          },
          {
            name: 'hp',
            type: 'int',
            isNullable: false,
          },
          {
            name: 'speed',
            type: 'int',
            isNullable: false,
          },
          {
            name: 'type',
            type: 'varchar',
            isNullable: false,
          },
          {
            name: 'imageUrl',
            type: 'varchar',
            isNullable: false,
          },
        ],
        indices: [
          {
            name: 'IDX_POKEMON_NAME',
            columnNames: ['name'],
          },
        ],
      }),
      true,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('pokemon');
  }
}
