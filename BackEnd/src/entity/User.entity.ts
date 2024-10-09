import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { TaskerInfo } from "./TaskerInfo.entity";

@Entity({ name: "users" })
export class User {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: true })
  email!: string;

  @Column({ type: "varchar", nullable: false })
  name!: string;

  @Column({ type: "varchar", nullable: false })
  phoneNumber!: string;

  @Column({ type: "varchar", nullable: false })
  password!: string;

  @Column({ type: "varchar", default: "R1" })
  role!: string; // R1=user/R2=tasker

  @Column({ type: "varchar", nullable: true })
  avatar!: string;

  @Column({ type: "timestamp", nullable: true })
  birthday!: Date;

  @Column({ type: "int", default: 0 })
  Rpoints!: number; // For R1
  @Column({ type: "int", nullable: true })
  taskerInfoId!: number; // Foreign key column

  @ManyToOne(() => TaskerInfo, (taskerInfo) => taskerInfo.users)
  @JoinColumn({ name: "taskerInfoId" })
  taskerInfo!: TaskerInfo; // For R2

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
