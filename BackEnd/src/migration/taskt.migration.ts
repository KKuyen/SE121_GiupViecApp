import {
  MigrationInterface,
  QueryRunner,
  Table,
  TableForeignKey,
} from "typeorm";

export class TasksMigration1698324600524 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "tasks",
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
          },
          {
            name: "isReTaskChildren",
            type: "int",
            isNullable: true,
          },
          {
            name: "taskStatus",
            type: "varchar",
            isNullable: false,
          },

          {
            name: "approvedAt",
            type: "timestamp",
            isNullable: true,
          },
          {
            name: "cancelAt",
            type: "timestamp",
            isNullable: true,
          },
          {
            name: "cancelReason",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "finishedAt",
            type: "timestamp",
            isNullable: true,
          },
          {
            name: "numberOfTasker",
            type: "int",
            isNullable: true,
          },
          {
            name: "voucherId",
            type: "int",
            isNullable: true,
          },
          {
            name: "price",
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

    // await queryRunner.createForeignKey(
    //   "tasks",
    //   new TableForeignKey({
    //     columnNames: ["userId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE",
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "tasks",
    //   new TableForeignKey({
    //     columnNames: ["taskTypeId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "taskTypes",
    //     onDelete: "CASCADE",
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "tasks",
    //   new TableForeignKey({
    //     columnNames: ["locationId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "locations",
    //     onDelete: "CASCADE",
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "tasks",
    //   new TableForeignKey({
    //     columnNames: ["isReTaskChildren"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "reTasks",
    //     onDelete: "SET NULL", // Optional: Use SET NULL if ReTask is deleted
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("tasks");
    const foreignKeys = table!.foreignKeys;

    await queryRunner.dropForeignKey(
      "tasks",
      foreignKeys.find((fk) => fk.columnNames.indexOf("userId") !== -1)!
    );
    await queryRunner.dropForeignKey(
      "tasks",
      foreignKeys.find((fk) => fk.columnNames.indexOf("taskTypeId") !== -1)!
    );
    await queryRunner.dropForeignKey(
      "tasks",
      foreignKeys.find((fk) => fk.columnNames.indexOf("locationId") !== -1)!
    );
    await queryRunner.dropForeignKey(
      "tasks",
      foreignKeys.find(
        (fk) => fk.columnNames.indexOf("isReTaskChildren") !== -1
      )!
    );

    await queryRunner.dropTable("tasks");
  }
}
