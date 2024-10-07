import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { Tasks } from "./Task.entity"; // Import Tasks
import { ReTasks } from "./Retasks.entity"; // Import ReTasks
import { AddPriceDetails } from "./AddPriceDetails.entity"; // Import AddPriceDetails

@Entity({ name: "addPrices" })
export class AddPrices {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "int", nullable: false })
  taskId!: number;

  @Column({ type: "int", nullable: true })
  reTaskId!: number; // Nullable

  @Column({ type: "int", nullable: false })
  addPriceDetailId!: number;

  @Column({ type: "int", nullable: false })
  quantity!: number;

  @Column({ type: "money", nullable: false })
  price!: number;
  
  @ManyToOne(() => Tasks)
  @JoinColumn({ name: "taskId" })
  task!: Tasks; // Many-to-one relationship with Tasks

  @ManyToOne(() => ReTasks)
  @JoinColumn({ name: "reTaskId" })
  reTask!: ReTasks; // Many-to-one relationship with ReTasks

  @ManyToOne(() => AddPriceDetails)
  @JoinColumn({ name: "addPriceDetailId" })
  addPriceDetail!: AddPriceDetails; // Many-to-one relationship with AddPriceDetails

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
