import { MigrationInterface, QueryRunner, Table, TableForeignKey } from "typeorm";

export class UserSettingsMigration1698323600521 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "userSettings",
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
            name: "autoAcceptStatus",
            type: "boolean",
            default: false,
          },
          {
            name: "loveTaskerOnly",
            type: "boolean",
            default: false,
          },
          {
            name: "upperStar",
            type: "int",
            default: 0,
          },
          {
            name: "nightMode",
            type: "boolean",
            default: false,
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
    //   "userSettings",
    //   new TableForeignKey({
    //     columnNames: ["userId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE", // When a user is deleted, the related settings are deleted
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("userSettings");
    const foreignKey = table!.foreignKeys.find(fk => fk.columnNames.indexOf("userId") !== -1);
    await queryRunner.dropForeignKey("userSettings", foreignKey!);
    await queryRunner.dropTable("userSettings");
  }
}
