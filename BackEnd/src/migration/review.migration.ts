import { MigrationInterface, QueryRunner, Table, TableForeignKey } from "typeorm";

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
            name: "taskerId",
            type: "int",
            isNullable: false,
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
            isNullable: false,
          },
          {
            name: "image2",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "image3",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "image4",
            type: "varchar",
            isNullable: false,
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

    await queryRunner.dropForeignKey("reviews", foreignKeys.find(fk => fk.columnNames.indexOf("taskId") !== -1)!);
    await queryRunner.dropForeignKey("reviews", foreignKeys.find(fk => fk.columnNames.indexOf("taskerId") !== -1)!);
    
    await queryRunner.dropTable("reviews");
  }
}
