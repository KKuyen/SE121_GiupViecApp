import { MigrationInterface, QueryRunner, Table, TableForeignKey } from "typeorm";

export class MyVouchersMigration1698324600531 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "myVouchers",
        columns: [
          {
            name: "id",
            type: "int",
            isPrimary: true,
            isGenerated: true,
            generationStrategy: "increment",
          },
          {
            name: "voucherId",
            type: "int",
            isNullable: false,
          },
          {
            name: "userId",
            type: "int",
            isNullable: false,
          },
          {
            name: "isUsed",
            type: "bool",
            isNullable: false,
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
    //   "myVouchers",
    //   new TableForeignKey({
    //     columnNames: ["voucherId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "vouchers",
    //     onDelete: "CASCADE",
    //   })
    // );

    // await queryRunner.createForeignKey(
    //   "myVouchers",
    //   new TableForeignKey({
    //     columnNames: ["userId"],
    //     referencedColumnNames: ["id"],
    //     referencedTableName: "users",
    //     onDelete: "CASCADE",
    //   })
    // );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    const table = await queryRunner.getTable("myVouchers");
    const foreignKeys = table!.foreignKeys;

    await queryRunner.dropForeignKey("myVouchers", foreignKeys.find(fk => fk.columnNames.indexOf("voucherId") !== -1)!);
    await queryRunner.dropForeignKey("myVouchers", foreignKeys.find(fk => fk.columnNames.indexOf("userId") !== -1)!);
    
    await queryRunner.dropTable("myVouchers");
  }
}
