import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { User } from "./User.entity"; // Import User entity
import { TaskTypes } from "./TaskTypes.entity"; // Import TaskTypes
import { Location } from "./Location.entity"; // Import Locations

@Entity({ name: "reTasks" })
export class ReTasks {
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

  @ManyToOne(() => User)
  @JoinColumn({ name: "userId" })
  user!: User; // Many-to-one relationship with User

  @ManyToOne(() => TaskTypes)
  @JoinColumn({ name: "taskTypeId" })
  taskType!: TaskTypes; // Many-to-one relationship with TaskTypes

  @ManyToOne(() => Location)
  @JoinColumn({ name: "locationId" })
  location!: Location; // Many-to-one relationship with Locations

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
