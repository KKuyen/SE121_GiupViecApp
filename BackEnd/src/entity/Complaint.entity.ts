import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
} from "typeorm";

@Entity({ name: "complaints" })
export class Complaint {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column()
  taskId!: number;

  @Column()
  type!: string;

  @Column()
  status!: string;
  @Column()
  description!: string;

  @Column()
  customerId!: number;

  @Column()
  taskerId!: number;
  @CreateDateColumn()
  createdAt!: Date;
}
