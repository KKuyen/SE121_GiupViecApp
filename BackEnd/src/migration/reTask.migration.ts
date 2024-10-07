import { MigrationInterface, QueryRunner, Table, TableForeignKey } from "typeorm";

export class ReTasksMigration1698324600526 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "reTasks",
        columns: [
          {
            name: "id",
            type: "int",
            isPrimary: true,
            isGenerated: true,
            generationStrategy: "increment",
          },
          {
            name: "userId",
            type: "int",
            isNullable: false,
          },
          {
            name: "taskTypeId",
            type: "int",
            isNullable: false,
          },
          {
            name: "time",
            type: "timestamp",
            isNullable: false,
          },
          {
            name: "locationId",
            type: "int",
            isNullable: false,
          },
          {
            name: "note",
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

    // await queryRunner.createForeignKey(
    //   "reTasks",
    //   new TableForeignKey({
    //     columnNames: ["userId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE",
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "reTasks",
    //   new TableForeignKey({
    //     columnNames: ["taskTypeId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "taskTypes",
    //     onDelete: "CASCADE",
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "reTasks",
    //   new TableForeignKey({
    //     columnNames: ["locationId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "locations",
    //     onDelete: "CASCADE",
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("reTasks");
    const foreignKeys = table!.foreignKeys;

    await queryRunner.dropForeignKey("reTasks", foreignKeys.find(fk => fk.columnNames.indexOf("userId") !== -1)!);
    await queryRunner.dropForeignKey("reTasks", foreignKeys.find(fk => fk.columnNames.indexOf("taskTypeId") !== -1)!);
    await queryRunner.dropForeignKey("reTasks", foreignKeys.find(fk => fk.columnNames.indexOf("locationId") !== -1)!);
    
    await queryRunner.dropTable("reTasks");
  }
}
