import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { User } from "./User.entity"; // Import the User entity

@Entity({ name: "userSettings" })
export class UserSettings {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "int", nullable: false })
  userId!: number;

  @Column({ type: "boolean", default: false })
  autoAcceptStatus!: boolean;

  @Column({ type: "boolean", default: false })
  loveTaskerOnly!: boolean;

  @Column({ type: "int", default: 0 })
  upperStar!: number;

  @Column({ type: "boolean", default: false })
  nightMode!: boolean;

  @ManyToOne(() => User)
  @JoinColumn({ name: "userId" })
  user!: User; // Relationship with User

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
