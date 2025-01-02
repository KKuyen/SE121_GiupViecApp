import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { Tasks } from "./Task.entity"; // Import Tasks entity
import { User } from "./User.entity"; // Import User entity

@Entity({ name: "taskerList" })
export class TaskerList {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "int", nullable: false })
  taskId!: number;

  @Column({ type: "int", nullable: false })
  taskerId!: number;

  @Column({ type: "float", nullable: true })
  reviewStar!: number; // Used to store the rating

  @Column({ type: "varchar", nullable: false })
  status!: string; // S1= pending, S2= approved, S3= cancelByTasker, S4= cancelByCustomer

  @ManyToOne(() => Tasks)
  @JoinColumn({ name: "taskId" })
  task!: Tasks; // Many-to-one relationship with Tasks

  @ManyToOne(() => User)
  @JoinColumn({ name: "taskerId" })
  tasker!: User; // Many-to-one relationship with Users

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
  length: any;
}
