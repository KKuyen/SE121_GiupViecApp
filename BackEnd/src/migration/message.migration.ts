import { MigrationInterface, QueryRunner } from "typeorm";
export class CreateMessageTable1634567890123 implements MigrationInterface {
    name = 'CreateMessageTable1634567890123'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            CREATE TABLE "message" (
                "id" SERIAL NOT NULL,
                "content" character varying NOT NULL,
                "sourceId" integer NOT NULL,
                "targetId" integer NOT NULL,
                "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
                CONSTRAINT "PK_ba01f0a3e0123651915008bc578" PRIMARY KEY ("id")
            )
        `);

    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "message" DROP CONSTRAINT "FK_target_user"`);
        await queryRunner.query(`ALTER TABLE "message" DROP CONSTRAINT "FK_source_user"`);
        await queryRunner.query(`DROP TABLE "message"`);
    }
}