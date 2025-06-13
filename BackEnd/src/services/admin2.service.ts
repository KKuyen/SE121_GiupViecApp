// import { UserSettings } from "./../entity/UserSetting.entity";
import { User } from "../entity/User.entity";
import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
import * as dotenv from "dotenv";
import { Vouchers } from "../entity/Voucher.entity";
import { Tasks } from "../entity/Task.entity";
import { Location } from "../entity/Location.entity";
import { Reviews } from "../entity/Review.entity";


require("dotenv").config();

dotenv.config();
export class AdminService {
  static getAllUsers = async () => {
    return new Promise(async (resolve, reject) => {
      try {
        const userRepository = AppDataSource.getRepository(User);
        const users = await userRepository.find({
          select: ["id", "name", "email", "role", "phoneNumber","avatar","birthday","Rpoints","taskerInfoId"], // Exclude password field
        });
        resolve({
          errCode: 0,
          errMessage: "OK",
          users: users,
        });
      } catch (e) {
        reject(e);
      }
    });
  };
  static getAUser = async (id: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const userRepository = AppDataSource.getRepository(User);
        const user = await userRepository.findOne({
          where: { id },
          select: ["id", "name", "email", "role", "phoneNumber", "avatar", "birthday", "Rpoints", "taskerInfoId", "createdAt"], // Exclude password field
         });

        if (user) {
          const locationRepository = AppDataSource.getRepository(Location);
          const reviewRepository = AppDataSource.getRepository(Reviews);

          const location = await locationRepository.find({ where: { userId: user.id } });
          const reviews = await reviewRepository
          .createQueryBuilder("review")
          .leftJoinAndSelect("review.task", "task")
          .leftJoinAndSelect("review.taskType", "taskType")
          .where("review.userId = :id", { id })
          .select([
            "review.id",
            "review.taskId",
            "review.taskerId",
            "review.star",
            "review.content",
            "review.userId",
            "review.userName",
            "review.userAvatar",
            "review.image1",
            "review.image2",
            "review.image3",
            "review.image4",
            "review.createdAt",
            "review.updatedAt",
            "task.id",
            "task.time",
            "task.note",
            "taskType.id",
            "taskType.name",
            "taskType.avatar",
          ])
          .getMany();
          location.forEach((l) => {
            const province = l.province;
            const district = l.district;
            const detailAddress = l.detailAddress;
            l.map= `${detailAddress}, ${district}, ${province}`;
          });
          

          resolve({
            errCode: 0,
            errMessage: "OK",
            user: {
              ...user,
              location: location,
              reviews: reviews,
            },
          });
        } else {
          resolve({
            errCode: 1,
            errMessage: "User not found",
          });
        }
      } catch (e) {
        reject(e);
      }
    });
  };
  static editUser = async (user: User) => {
    return new Promise(async (resolve, reject) => {
      try {
        const userRepository = AppDataSource.getRepository(User);
        await userRepository.update(user.id, user);
        resolve({
          errCode: 0,
          errMessage: "OK",
        });
      } catch (e) {
        reject(e);
      }
    });
  };
  static deleteUser = async (id: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const userRepository = AppDataSource.getRepository(User);
        await userRepository.delete(id);
        resolve({
          errCode: 0,
          errMessage: "OK",
        });
      } catch (e) {
        reject(e);
      }
    });
  }
  static getAllVouchers = async () => {
    return new Promise(async (resolve, reject) => {
      try {
        const vouchersRepository = AppDataSource.getRepository(Vouchers);
        const vouchers = await vouchersRepository.find();
        resolve({
          errCode: 0,
          errMessage: "OK",
          vouchers: vouchers,
        });
        
      } catch (e) {
        reject(e);
      }
    });
  };
  static addVoucher = async (voucher: Vouchers) => {
    return new Promise(async (resolve, reject) => {
      try {
        const vouchersRepository = AppDataSource.getRepository(Vouchers);
        await vouchersRepository.insert({
          image: voucher.image,
          content: voucher.content,
          header: voucher.header,
          applyTasks: voucher.applyTasks,
          RpointCost: voucher.RpointCost,
          value: voucher.value,
          isInfinity: voucher.isInfinity,
          quantity: voucher.quantity,
          startDate: voucher.startDate,
          endDate: voucher.endDate,
        });
        resolve({
          errCode: 0,
          errMessage: "OK",
        });
      } catch (e) {
        reject(e);
      }
    });
  };
  static editVoucher = async (voucher: any) => {
    return new Promise(async (resolve, reject) => {
      try {
        const vouchersRepository = AppDataSource.getRepository(Vouchers);
        await vouchersRepository.update(voucher.id, voucher);
        resolve({
          errCode: 0,
          errMessage: "OK",
        });
      } catch (e) {
        reject(e);
      }
    });
  };
  static deleteVoucher = async (id: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const vouchersRepository = AppDataSource.getRepository(Vouchers);
        await vouchersRepository.delete(id);
        resolve({
          errCode: 0,
          errMessage: "OK",
        });
      } catch (e) {
        reject(e);
      }
    });
  };
  static getAllActivities = async () => {
    return new Promise(async (resolve, reject) => {
      try {
       const taskeRepository = AppDataSource.getRepository(Tasks);
        const tasksQuery = taskeRepository
          .createQueryBuilder("task")
          .leftJoinAndSelect("task.location", "location")
          .leftJoinAndSelect("task.user", "user")
          .leftJoinAndSelect("task.taskType", "taskType")
          .leftJoinAndSelect("task.taskerLists", "taskerLists")
          .orderBy("task.createdAt", "DESC")
          .select([
            "task.id",
            "task.userId",
            "task.taskTypeId",
            "task.time",
            "task.locationId",
            "task.note",
            "task.isReTaskChildren",
            "task.taskStatus",
            "task.createdAt",
            "task.updatedAt",
            "task.price",
            "task.approvedAt",
            "task.cancelAt",
            "task.finishedAt",
            "task.cancelReason",
            "task.numberOfTasker",
            "task.isPaid",
            "user.id",
            "user.name",
            "user.email",
            "user.phoneNumber",
            "user.role",
            "user.avatar",
            "user.birthday",
            "user.Rpoints",
            "location.id",
            "location.country",
            "location.province",
            "location.district",
            "location.ownerName",
            "location.ownerPhoneNumber",
            "location.detailAddress",
            "location.map",
            "taskType.id",
            "taskType.name",
            "taskType.avatar",
            "taskerLists.id",
            "taskerLists.status",
          ]);
 
         

        let tasks = await tasksQuery.getMany();
        resolve({
          errCode: 0,
          errMessage: "OK",
          activities: tasks,
        });
      } catch (e) {
        reject(e);
      }
    });
  };

}
