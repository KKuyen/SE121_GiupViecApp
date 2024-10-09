import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";

@Entity({ name: "vouchers" })
export class Vouchers {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: true })
  image!: string;

  @Column({ type: "varchar", nullable: false })
  content!: string;

  @Column({ type: "varchar", nullable: false })
  header!: string;

  @Column({ type: "varchar", nullable: false })
  applyTasks!: string; // ALL or specific task IDs (1_2_3_4)

  @Column({ type: "int", nullable: false })
  RpointCost!: number;

  @Column({ type: "varchar", nullable: false })
  value!: string; // e.g., 20% or -200000

  @Column({ type: "boolean", default: false })
  isInfinity!: boolean; // Is it infinite for the period?

  @Column({ type: "int", nullable: false })
  quantity!: number;

  @Column({ type: "timestamp", nullable: false })
  startDate!: Date;

  @Column({ type: "timestamp", nullable: false })
  endDate!: Date;

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
