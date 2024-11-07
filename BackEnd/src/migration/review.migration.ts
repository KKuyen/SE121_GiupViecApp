import {
  MigrationInterface,
  QueryRunner,
  Table,
  TableForeignKey,
} from "typeorm";

export class ReviewsMigration1698324600528 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "reviews",
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
            name: "taskTypeId",
            type: "int",
            isNullable: false,
          },
          {
            name: "taskerId",
            type: "int",
            isNullable: false,
          },
          {
            name: "userId",
            type: "int",
            isNullable: false,
          },

          {
            name: "userAvatar",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "userName",
            type: "varchar",
            isNullable: true,
          },

          {
            name: "star",
            type: "float",
            isNullable: false,
          },
          {
            name: "content",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "image1",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "image2",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "image3",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "image4",
            type: "varchar",
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
    //   "reviews",
    //   new TableForeignKey({
    //     columnNames: ["taskId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "tasks",
    //     onDelete: "CASCADE",
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "reviews",
    //   new TableForeignKey({
    //     columnNames: ["taskerId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE",
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("reviews");
    const foreignKeys = table!.foreignKeys;

    await queryRunner.dropForeignKey(
      "reviews",
      foreignKeys.find((fk) => fk.columnNames.indexOf("taskId") !== -1)!
    );
    await queryRunner.dropForeignKey(
      "reviews",
      foreignKeys.find((fk) => fk.columnNames.indexOf("taskerId") !== -1)!
    );

    await queryRunner.dropTable("reviews");
  }
}
