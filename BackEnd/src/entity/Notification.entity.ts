import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";

@Entity({ name: "notifications" })
export class Notifications {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "int", nullable: true })
  userId!: number; // 0 to send to all users

  @Column({ type: "varchar", nullable: false })
  header!: string;

  @Column({ type: "varchar", nullable: true })
  content!: string;

  @Column({ type: "varchar", nullable: true })
  image!: string; // Optional

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
