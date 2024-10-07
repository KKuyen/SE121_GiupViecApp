import { MigrationInterface, QueryRunner, Table, TableForeignKey } from "typeorm";

export class TaskerListMigration1698324600527 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "taskerList",
        columns: [
          {
            name: "id",
            type: "int",
            isPrimary: true,
            isGenerated: true,
            generationStrategy: "increment",
          },
          {
            name: "taskId",
            type: "int",
            isNullable: false,
          },
          {
            name: "taskerId",
            type: "int",
            isNullable: false,
          },
          {
            name: "reviewStar",
            type: "float",
            isNullable: true,
          },
          {
            name: "status",
            type: "varchar",
            isNullable: false,
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

    // await queryRunner.createForeignKey(
    //   "taskerList",
    //   new TableForeignKey({
    //     columnNames: ["taskId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "tasks",
    //     onDelete: "CASCADE",
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "taskerList",
    //   new TableForeignKey({
    //     columnNames: ["taskerId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE",
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("taskerList");
    const foreignKeys = table!.foreignKeys;

    await queryRunner.dropForeignKey("taskerList", foreignKeys.find(fk => fk.columnNames.indexOf("taskId") !== -1)!);
    await queryRunner.dropForeignKey("taskerList", foreignKeys.find(fk => fk.columnNames.indexOf("taskerId") !== -1)!);
    
    await queryRunner.dropTable("taskerList");
  }
}
