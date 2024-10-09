import { MigrationInterface, QueryRunner, Table } from "typeorm";

export class TaskTypesMigration1698324600522 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "taskTypes",
        columns: [
          {
            name: "id",
            type: "int",
            isPrimary: true,
            isGenerated: true,
            generationStrategy: "increment",
          },
          {
            name: "name",
            type: "varchar",
            isNullable: false,
          },

          {
            name: "avatar",
            type: "varchar",
            isNullable: true,
          },

          {
            name: "description",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "image",
            type: "varchar",
            isNullable: true,
          },

          {
            name: "originalPrice",
            type: "money",
            isNullable: false,
          },
          {
            name: "value",
            type: "int",
            isNullable: true,
          },
          {
            name: "createdAt",
            type: "timestamp",
            default: `now()`,
          },
          {
            name: "updatedAt",
            type: "timestamp",
            default: `now()`,
          },
        ],
      }),
      true
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable("taskTypes");
  }
}
