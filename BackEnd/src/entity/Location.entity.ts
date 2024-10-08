import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToOne,
  JoinColumn,CreateDateColumn,
  UpdateDateColumn,
} from "typeorm";
import { User } from "./User.entity"; // Import the User entity

@Entity({ name: "locations" })
export class Location {
  @PrimaryGeneratedColumn()
  id!: number;

  @Column({ type: "varchar", nullable: true })
  ownerName!: string;

  @Column({ type: "varchar", nullable: true })
  ownerPhoneNumber!: string;

  @Column({ type: "varchar", nullable: false })
  country!: string;

  @Column({ type: "varchar", nullable: false })
  province!: string;

  @Column({ type: "varchar", nullable: false })
  district!: string;

  @Column({ type: "varchar", nullable: false })
  detailAddress!: string;

  @Column({ type: "varchar", nullable: true })
  map!: string;

  @Column({ type: "int", nullable: false })
  userId!: number;

  @Column({ type: "boolean", default: false })
  isDefault!: boolean;

  @ManyToOne(() => User)
  @JoinColumn({ name: "userId" })
  user!: User; // This will reference the User entity's id field

  @CreateDateColumn()
  createdAt!: Date;

  @UpdateDateColumn()
  updatedAt!: Date;
}
