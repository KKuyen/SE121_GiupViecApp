import { MigrationInterface, QueryRunner, Table, TableForeignKey } from "typeorm";

export class LoveTaskersMigration1698322600519 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "loveTaskers",
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
    //   "loveTaskers",
    //   new TableForeignKey({
    //     columnNames: ["userId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE", // When a user is deleted, related entries in loveTaskers are deleted
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "loveTaskers",
    //   new TableForeignKey({
    //     columnNames: ["taskerId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE", // When a tasker is deleted, related entries in loveTaskers are deleted
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("loveTaskers");
    const foreignKeyUser = table!.foreignKeys.find(fk => fk.columnNames.indexOf("userId") !== -1);
    const foreignKeyTasker = table!.foreignKeys.find(fk => fk.columnNames.indexOf("taskerId") !== -1);

    await queryRunner.dropForeignKey("loveTaskers", foreignKeyUser!);
    await queryRunner.dropForeignKey("loveTaskers", foreignKeyTasker!);
    await queryRunner.dropTable("loveTaskers");
  }
}
