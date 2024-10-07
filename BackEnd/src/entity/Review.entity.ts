import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
} from "typeorm";
import { Tasks } from "./Task.entity"; // Import Tasks entity
import { User } from "./User.entity"; // Import User entity

@Entity({ name: "reviews" })
export class Reviews {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "int", nullable: false })
  taskId!: number;

  @Column({ type: "int", nullable: false })
  taskerId!: number;

  @Column({ type: "float", nullable: false })
  star!: number;

  @Column({ type: "varchar", nullable: false })
  content!: number;

  @Column({ type: "varchar", nullable: false })
  image1!: number;

  @Column({ type: "varchar", nullable: false })
  image2!: number;

  @Column({ type: "varchar", nullable: false })
  image3!: number;

  @Column({ type: "varchar", nullable: false })
  image4!: number;

  @ManyToOne(() => Tasks)
  @JoinColumn({ name: "taskId" })
  task!: Tasks; // Many-to-one relationship with Tasks

  @ManyToOne(() => User)
  @JoinColumn({ name: "taskerId" })
  tasker!: User; // Many-to-one relationship with Users
}
