import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";

@Entity({ name: "paymentInformation" })
export class PaymentInformation {
  @PrimaryGeneratedColumn()
  id!: number;
  @Column({ type: "varchar", length: 255 })
  momo!: string;

  @Column({ type: "varchar", length: 255 })
  bankAccount!: string;

  @Column({ type: "varchar", length: 255 })
  bankAccountName!: string;
  @Column({ type: "varchar", length: 255 })
  subBankAccount!: string;
  @Column({ type: "varchar", length: 255 })
  subBankAccountName!: string;
  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
