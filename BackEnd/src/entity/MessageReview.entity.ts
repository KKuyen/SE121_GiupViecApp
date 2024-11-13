import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne, UpdateDateColumn, JoinColumn } from "typeorm";
import { User } from "./User.entity";

@Entity()
export class MessageReview {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  lastMessage!: string;
    
  @Column()
  lastMessageTime!: string;

  @Column()
  sourceId!: number;

  @Column()
  targetId!: number;

  @ManyToOne(() => User)
  @JoinColumn({ name: "targetId" })
  target!: User;

  @ManyToOne(() => User)
  @JoinColumn({ name: "sourceId" })
  source!: User;

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
