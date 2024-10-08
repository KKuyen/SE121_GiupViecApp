import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,
  CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { User } from "./User.entity"; // Import User entity
import { Vouchers } from "./Voucher.entity"; // Import Vouchers entity

@Entity({ name: "myVouchers" })
export class MyVouchers {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "int", nullable: false })
  voucherId!: number; // Note: corrected typo "vourcherid"

  @Column({ type: "int", nullable: false })
  userId!: number;

  @Column({ type: "bool", nullable: false })
  isUsed!: boolean;
  @ManyToOne(() => Vouchers)
  @JoinColumn({ name: "voucherId" })
  voucher!: Vouchers; // Many-to-one relationship with Vouchers

  @ManyToOne(() => User)
  @JoinColumn({ name: "userId" })
  user!: User; // Many-to-one relationship with Users

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
