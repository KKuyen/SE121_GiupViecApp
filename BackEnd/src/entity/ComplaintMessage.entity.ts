// filepath: d:\Projects\SE121\SE121_GiupViecApp\BackEnd\src\entity\message.entity.ts
import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
} from "typeorm";

@Entity({ name: "complaintMessages" })
export class ComplaintMessage {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  complaintId!: number;

  @Column()
  message!: string;

  @Column()
  sourceId!: number;

  @Column()
  targetId!: number;

  @CreateDateColumn()
  createdAt!: Date;
}
