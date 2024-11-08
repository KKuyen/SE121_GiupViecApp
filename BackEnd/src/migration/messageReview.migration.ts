import { MigrationInterface, QueryRunner } from "typeorm";

export class CreateMessageReviewTable1634567890123 implements MigrationInterface {
    name = 'CreateMessageReviewTable1634567890123'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            CREATE TABLE "message_review" (
                "id" SERIAL NOT NULL,
                "lastMessage" character varying NOT NULL,
                "lastMessageTime" character varying NOT NULL,
                "sourceId" integer NOT NULL,
                "targetId" integer NOT NULL,
                "createdAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
                "updatedAt" TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),
                CONSTRAINT "PK_d5b7e5f5e5f5e5f5e5f5e5f5e5f" PRIMARY KEY ("id")
            )
        `);

    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "message_review" DROP CONSTRAINT "FK_target_user"`);
        await queryRunner.query(`ALTER TABLE "message_review" DROP CONSTRAINT "FK_source_user"`);
        await queryRunner.query(`DROP TABLE "message_review"`);
    }
}