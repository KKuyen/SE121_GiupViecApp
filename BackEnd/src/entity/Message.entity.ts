import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, ManyToOne } from "typeorm";
import { User } from "./User.entity";

@Entity()
export class Message {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  content!: string;

  @ManyToOne(() => User)
  source!: User;

  @Column()
  sourceId!: number;

  @ManyToOne(() => User)
  target!: User;

  @Column()
  targetId!: number;

  @CreateDateColumn()
  createdAt!: Date;
}
