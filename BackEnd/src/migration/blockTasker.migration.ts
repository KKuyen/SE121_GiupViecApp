import { MigrationInterface, QueryRunner, Table, TableForeignKey } from "typeorm";

export class BlockTaskersMigration1698322600520 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "blockTaskers",
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
            name: "taskerId",
            type: "int",
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
    //   "blockTaskers",
    //   new TableForeignKey({
    //     columnNames: ["userId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE", // When a user is deleted, related entries in blockTaskers are deleted
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "blockTaskers",
    //   new TableForeignKey({
    //     columnNames: ["taskerId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE", // When a tasker is deleted, related entries in blockTaskers are deleted
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("blockTaskers");
    const foreignKeyUser = table!.foreignKeys.find(fk => fk.columnNames.indexOf("userId") !== -1);
    const foreignKeyTasker = table!.foreignKeys.find(fk => fk.columnNames.indexOf("taskerId") !== -1);

    await queryRunner.dropForeignKey("blockTaskers", foreignKeyUser!);
    await queryRunner.dropForeignKey("blockTaskers", foreignKeyTasker!);
    await queryRunner.dropTable("blockTaskers");
  }
}
