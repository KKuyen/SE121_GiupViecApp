import {
  MigrationInterface,
  QueryRunner,
  Table,
  TableForeignKey,
} from "typeorm";

export class UsersMigration1698321500515 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "users",
        columns: [
          {
            name: "id",
            type: "int",
            isPrimary: true,
            isGenerated: true,
            generationStrategy: "increment",
          },
          {
            name: "email",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "name",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "phoneNumber",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "password",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "role",
            type: "varchar",
            default: `'R1'`, // default to R1=user
          },
          {
            name: "avatar",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "birthday",
            type: "timestamp",
            isNullable: true,
          },
          {
            name: "Rpoints",
            type: "int",
            default: 0,
          },
          {
            name: "taskerInfo",
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
    //   "users",
    //   new TableForeignKey({
    //     columnNames: ["taskerInfo"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "taskerInfo",
    //     onDelete: "SET NULL",
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("users");
    const foreignKey = table!.foreignKeys.find(
      (fk) => fk.columnNames.indexOf("taskerInfo") !== -1
    );
    await queryRunner.dropForeignKey("users", foreignKey!);
    await queryRunner.dropTable("users");
  }
}
