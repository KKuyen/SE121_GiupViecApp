import { MigrationInterface, QueryRunner, Table } from "typeorm";

export class NotificationsMigration1698324600529 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: "notifications",
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
            isNullable: true, // 0 to send to all users
          },

          {
            name: "header",
            type: "varchar",
            isNullable: false,
          },
          {
            name: "content",
            type: "varchar",
            isNullable: true,
          },
          {
            name: "image",
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
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable("notifications");
  }
}
