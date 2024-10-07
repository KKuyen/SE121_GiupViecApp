import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { User } from "./User.entity"; // Import the User entity

@Entity({ name: "loveTaskers" })
export class LoveTaskers {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "int", nullable: false })
  userId!: number;

  @Column({ type: "int", nullable: false })
  taskerId!: number;

  @ManyToOne(() => User)
  @JoinColumn({ name: "userId" })
  user!: User; // Relationship with User

  @ManyToOne(() => User)
  @JoinColumn({ name: "taskerId" })
  tasker!: User; // Relationship with Tasker (also a User)

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
