import {
  MigrationInterface,
  QueryRunner,
  Table,
  TableForeignKey,
} from 'typeorm';

export class CreateBattleTable1744831299802 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'battle',
        columns: [
          {
            name: 'id',
            type: 'uuid',
            isPrimary: true,
            generationStrategy: 'uuid',
            default: 'uuid_generate_v4()',
          },
          {
            name: 'playerPokemonId',
            type: 'uuid',
          },
          {
            name: 'computerPokemonId',
            type: 'uuid',
          },
          {
            name: 'winnerId',
            type: 'uuid',
          },
          {
            name: 'turns',
            type: 'int',
          },
          {
            name: 'battleLog',
            type: 'json',
          },
          {
            name: 'createdAt',
            type: 'timestamp',
            default: 'now()',
          },
        ],
      }),
    );

    // Crear foreign keys
    await queryRunner.createForeignKey(
      'battle',
      new TableForeignKey({
        columnNames: ['playerPokemonId'],
        referencedColumnNames: ['id'],
        referencedTableName: 'pokemon',
        onDelete: 'CASCADE',
      }),
    );

    await queryRunner.createForeignKey(
      'battle',
      new TableForeignKey({
        columnNames: ['computerPokemonId'],
        referencedColumnNames: ['id'],
        referencedTableName: 'pokemon',
        onDelete: 'CASCADE',
      }),
    );

    await queryRunner.createForeignKey(
      'battle',
      new TableForeignKey({
        columnNames: ['winnerId'],
        referencedColumnNames: ['id'],
        referencedTableName: 'pokemon',
        onDelete: 'CASCADE',
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable('battle');
    if (table) {
      const foreignKeys = table.foreignKeys;
      for (const foreignKey of foreignKeys) {
        await queryRunner.dropForeignKey('battle', foreignKey);
      }
    }
    await queryRunner.dropTable('battle');
  }
}
