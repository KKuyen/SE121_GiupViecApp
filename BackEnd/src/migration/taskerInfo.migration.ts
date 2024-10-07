import { MigrationInterface, QueryRunner, Table } from "typeorm";

export class TaskerInfoMigration1698321400516 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "taskerInfo",
        columns: [
          {
            name: "id",
            type: "int",
            isPrimary: true,
            isGenerated: true,
            generationStrategy: "increment",
          },
          {
            name: "totalStar",
            type: "float",
            default: 0,
          },
          {
            name: "totalReviews",
            type: "int",
            default: 0,
          },
          {
            name: "introduction",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "taskList",
            type: "varchar",
            isNullable: true,
          },{
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
    await queryRunner.dropTable("taskerInfo");
  }
}
