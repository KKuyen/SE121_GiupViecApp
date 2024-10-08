import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  OneToMany,CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { AddPriceDetails } from "./AddPriceDetails.entity"; // Import AddPriceDetails
import { Tasks } from "./Task.entity"; // Import Tasks

@Entity({ name: "taskTypes" })
export class TaskTypes {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: false })
  name!: string;

  @Column({ type: "varchar", nullable: true })
  avatar!: string;

  @Column({ type: "varchar", nullable: true })
  description!: string;

  @Column({ type: "varchar", nullable: true })
  image!: string; // Optional

  @Column({ type: "money", nullable: false })
  originalPrice!: number; // Using money type for prices

  @Column({ type: "int", nullable: true })
  value!: number; 

  @OneToMany(() => AddPriceDetails, (addPriceDetails) => addPriceDetails.taskType)
  addPriceDetails!: AddPriceDetails[]; // One-to-many relationship with AddPriceDetails

  @OneToMany(() => Tasks, (task) => task.taskType)
  task!: Tasks[];

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;

}
