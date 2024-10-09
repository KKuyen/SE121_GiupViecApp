import {
  MigrationInterface,
  QueryRunner,
  Table,
  TableForeignKey,
} from "typeorm";

export class AddPriceDetailsMigration1698324600523
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "addPriceDetails",
        columns: [
          {
            name: "id",
            type: "int",
            isPrimary: true,
            isGenerated: true,
            generationStrategy: "increment",
          },
          {
            name: "taskTypeId",
            type: "int",
            isNullable: false,
          },
          {
            name: "name",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "stepValue",
            type: "int",
            isNullable: false,
          },
          {
            name: "unit",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "stepPrice",
            type: "money",
            isNullable: false,
          },
          {
            name: "beginPrice",
            type: "money",
            isNullable: false,
          },
          {
            name: "beginValue",
            type: "int",
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

    // await queryRunner.createForeignKey(
    //   "addPriceDetails",
    //   new TableForeignKey({
    //     columnNames: ["taskTypeId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "taskTypes",
    //     onDelete: "CASCADE",
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("addPriceDetails");
    const foreignKey = table!.foreignKeys.find(
      (fk) => fk.columnNames.indexOf("taskTypeId") !== -1
    );
    await queryRunner.dropForeignKey("addPriceDetails", foreignKey!);
    await queryRunner.dropTable("addPriceDetails");
  }
}
