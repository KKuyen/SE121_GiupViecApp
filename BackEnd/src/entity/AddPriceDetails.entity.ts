import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
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
  @Column({ type: "float", nullable: false })
  value!: number;

  @Column({ type: "float", nullable: false })
  stepPrice!: number;
  @Column({ type: "float", nullable: false })
  beginPrice!: number;

  @Column({ type: "int", nullable: false })
  stepValue!: number;

  @Column({ type: "varchar", nullable: false })
  unit!: string;

  @Column({ type: "int", nullable: false })
  beginValue!: number;

  @ManyToOne(() => TaskTypes, (taskType) => taskType.addPriceDetails)
  @JoinColumn({ name: "taskTypeId" })
  taskType!: TaskTypes; // Many-to-one relationship with TaskTypes

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
