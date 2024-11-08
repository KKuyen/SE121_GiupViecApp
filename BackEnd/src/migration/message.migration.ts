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
                "createdAt" TIMESTAMP NOT NULL DEFAULT now(),
                CONSTRAINT "PK_ba01f0a3e0123651915008bc578" PRIMARY KEY ("id")
            )
        `);
        // await queryRunner.query(`
        //     ALTER TABLE "message"
        //     ADD CONSTRAINT "FK_source_user" FOREIGN KEY ("sourceId") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION
        // `);
        // await queryRunner.query(`
        //     ALTER TABLE "message"
        //     ADD CONSTRAINT "FK_target_user" FOREIGN KEY ("targetId") REFERENCES "user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION
        // `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "message" DROP CONSTRAINT "FK_target_user"`);
        await queryRunner.query(`ALTER TABLE "message" DROP CONSTRAINT "FK_source_user"`);
        await queryRunner.query(`DROP TABLE "message"`);
    }
}