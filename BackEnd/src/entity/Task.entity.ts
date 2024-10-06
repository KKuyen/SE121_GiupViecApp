import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
} from "typeorm";
import { User } from "./User.entity"; // Import User entity
import { TaskTypes } from "./TaskTypes.entity"; // Import TaskTypes
import { Location } from "./Location.entity"; // Import Locations

@Entity({ name: "tasks" })
export class Tasks {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "int", nullable: false })
  userId!: number;

  @Column({ type: "int", nullable: false })
  taskTypeId!: number;

  @Column({ type: "timestamp", nullable: false })
  time!: Date;

  @Column({ type: "int", nullable: false })
  locationId!: number;

  @Column({ type: "varchar", nullable: true })
  note!: string;

  @Column({ type: "int", nullable: true })
  isReTaskChildren!: number; // Store ReTask ID if any

  @Column({ type: "varchar", nullable: false })
  taskStatus!: string; // TS1= Đang đợi, TS2 = Đã nhận, TS3 = Đã hoàn thành, TS4 = Đã hủy

  @Column({ type: "timestamp", nullable: false })
  createdAt!: Date; // Time service ordered

  @Column({ type: "timestamp", nullable: true })
  approvedAt!: Date;

  @Column({ type: "timestamp", nullable: true })
  cancelAt!: Date; // Can be null

  @Column({ type: "varchar", nullable: true })
  cancelReason!: string;

  @Column({ type: "timestamp", nullable: true })
  finishedAt!: Date;

  @ManyToOne(() => User)
  @JoinColumn({ name: "userId" })
  user!: User; // Many-to-one relationship with User

  @ManyToOne(() => TaskTypes)
  @JoinColumn({ name: "taskTypeId" })
  taskType!: TaskTypes; // Many-to-one relationship with TaskTypes

  @ManyToOne(() => Location)
  @JoinColumn({ name: "locationId" })
  location!: Location; // Many-to-one relationship with Locations
}