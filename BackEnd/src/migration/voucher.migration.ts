import { MigrationInterface, QueryRunner, Table } from "typeorm";

export class VouchersMigration1698324600530 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "vouchers",
        columns: [
          {
            name: "id",
            type: "int",
            isPrimary: true,
            isGenerated: true,
            generationStrategy: "increment",
          },
          {
            name: "image",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "content",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "header",
            type: "varchar",
            isNullable: false,
          },

          {
            name: "applyTasks",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "RpointCost",
            type: "int",
            isNullable: false,
          },
          {
            name: "value",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "isInfinity",
            type: "boolean",
            default: false,
          },
          {
            name: "quantity",
            type: "int",
            isNullable: false,
          },
          {
            name: "startDate",
            type: "timestamp",
            isNullable: false,
          },
          {
            name: "endDate",
            type: "timestamp",
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
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable("vouchers");
  }
}
