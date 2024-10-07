import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  OneToMany,CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { User } from "./User.entity";

@Entity({ name: "taskerInfo" })
export class TaskerInfo {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "float", default: 0 })
  totalStar!: number;

  @Column({ type: "int", default: 0 })
  totalReviews!: number;

  @Column({ type: "varchar", nullable: true })
  introduction!: string;

  @Column({ type: "varchar", nullable: true })
  taskList!: string; // List of tasks separated by '_'

  @OneToMany(() => User, (user) => user.taskerInfo)
  users!: User[];

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
