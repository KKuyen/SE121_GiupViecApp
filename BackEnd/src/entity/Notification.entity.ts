import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
} from "typeorm";

@Entity({ name: "notifications" })
export class Notifications {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "int", nullable: false })
  userId!: number; // 0 to send to all users

  @Column({ type: "varchar", nullable: false })
  header!: string;

  @Column({ type: "varchar", nullable: false })
  content!: string;

  @Column({ type: "varchar", nullable: true })
  image!: string; // Optional
}
