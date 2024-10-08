import { MigrationInterface, QueryRunner, Table, TableForeignKey } from "typeorm";

export class LocationsMigration1698321600518 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "locations",
        columns: [
          {
           name: "id",
            type: "int",
            isPrimary: true,
            isGenerated: true,
            generationStrategy: "increment",
          },
          {
            name: "ownerName",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "ownerPhoneNumber",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "country",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "province",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "district",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "detailAddress",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "map",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "userId",
            type: "int",
            isNullable: false,
          },
          {
            name: "isDefault",
            type: "boolean",
            default: false,
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
    //   "locations",
    //   new TableForeignKey({
    //     columnNames: ["userId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE", // When a user is deleted, the related locations are also deleted
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("locations");
    const foreignKey = table!.foreignKeys.find(fk => fk.columnNames.indexOf("userId") !== -1);
    await queryRunner.dropForeignKey("locations", foreignKey!);
    await queryRunner.dropTable("locations");
  }
}
