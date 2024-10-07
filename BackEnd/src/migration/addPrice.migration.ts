import { MigrationInterface, QueryRunner, Table, TableForeignKey } from "typeorm";

export class AddPricesMigration1698324600525 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "addPrices",
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
            name: "reTaskId",
            type: "int",
            isNullable: true,
          },
          {
            name: "addPriceDetailId",
            type: "int",
            isNullable: false,
          },
          {
            name: "quantity",
            type: "int",
            isNullable: false,
          },
          {
            name: "price",
            type: "money",
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
    //   "addPrices",
    //   new TableForeignKey({
    //     columnNames: ["taskId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "tasks",
    //     onDelete: "CASCADE",
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "addPrices",
    //   new TableForeignKey({
    //     columnNames: ["reTaskId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "reTasks",
    //     onDelete: "SET NULL", // Optional: Use SET NULL if ReTask is deleted
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "addPrices",
    //   new TableForeignKey({
    //     columnNames: ["addPriceDetailId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "addPriceDetails",
    //     onDelete: "CASCADE",
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("addPrices");
    const foreignKeys = table!.foreignKeys;

    await queryRunner.dropForeignKey("addPrices", foreignKeys.find(fk => fk.columnNames.indexOf("taskId") !== -1)!);
    await queryRunner.dropForeignKey("addPrices", foreignKeys.find(fk => fk.columnNames.indexOf("reTaskId") !== -1)!);
    await queryRunner.dropForeignKey("addPrices", foreignKeys.find(fk => fk.columnNames.indexOf("addPriceDetailId") !== -1)!);

    await queryRunner.dropTable("addPrices");
  }
}
