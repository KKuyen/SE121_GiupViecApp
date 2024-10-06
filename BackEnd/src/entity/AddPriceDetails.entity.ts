import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
} from "typeorm";
import { TaskTypes } from "./TaskTypes.entity"; // Import TaskTypes

@Entity({ name: "addPriceDetails" })
export class AddPriceDetails {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "int", nullable: false })
  taskTypeId!: number;

  @Column({ type: "varchar", nullable: false })
  name!: string;

  @Column({ type: "money", nullable: false })
  price!: number;

  @Column({ type: "int", nullable: false })
  stepValue!: number;

  @Column({ type: "varchar", nullable: false })
  unit!: string;

  @ManyToOne(() => TaskTypes, (taskType) => taskType.addPriceDetails)
  @JoinColumn({ name: "taskTypeId" })
  taskType!: TaskTypes; // Many-to-one relationship with TaskTypes
}
