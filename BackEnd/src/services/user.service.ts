// import { UserSettings } from "./../entity/UserSetting.entity";
import { User } from "../entity/User.entity";
import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
import bcrypt from "bcryptjs";
const salt = bcrypt.genSaltSync(10);
import { createJWT, verifyJWT } from "../middleware/JWTAction";
import { Tasks } from "../entity/Task.entity";
import { AddPrices } from "../entity/AddPrices.entity";
import { Vouchers } from "../entity/Voucher.entity";
import { MoreThan } from "typeorm";
import { MyVouchers } from "../entity/MyVoucher.entity";
import { TaskTypes } from "../entity/TaskTypes.entity";
import { AddPriceDetails } from "../entity/AddPriceDetails.entity";
import { TaskerList } from "../entity/TaskerList.entity";
import { LoveTaskers } from "../entity/LoveTasker.entity";
import { BlockTaskers } from "../entity/BlockTasket.entity";
import { Reviews } from "../entity/Review.entity";
import { TaskerInfo } from "../entity/TaskerInfo.entity";
import { UserSettings } from "../entity/UserSetting.entity";
import { parse } from "path";
import { getStorage, ref, uploadBytesResumable } from "firebase/storage";
import { signInWithEmailAndPassword } from "firebase/auth";
import { auth } from "../config/firebase.config";
import upload from "../middleware/multer"; // Ensure you have your multer setup here
import * as dotenv from "dotenv";

import twilio from "twilio";
import { Notifications } from "../entity/Notification.entity";

require("dotenv").config();
const client = twilio(
  process.env.TWILIO_ACCOUNT_SID,
  process.env.TWILIO_AUTH_TOKEN
);
dotenv.config();
export class UserService {
  static checkUserPhone = async (phoneNumber: string) => {
    return new Promise<boolean>(async (resolve, reject) => {
      try {
        const userRepository = AppDataSource.getRepository(User);
        const user = await userRepository.findOne({
          where: { phoneNumber: phoneNumber },
        });
        if (user) resolve(true);
        else resolve(false);
      } catch (e) {
        reject(e);
      }
    });
  };
  static hashUserPassword = (password: string) => {
    return new Promise<string>(async (resolve, reject) => {
      try {
        let hashPassword = await bcrypt.hashSync(password, salt);
        resolve(hashPassword);
      } catch (error) {
        reject(error);
      }
    });
  };
  static createUser = async (user: User) => {
    return new Promise(async (resolve, reject) => {
      try {
        let userData: any = {};
        if (await UserService.checkUserPhone(user.phoneNumber)) {
          userData.errCode = 1;
          userData.errMessage = "Số điện thoại đã tồn tại!";
          userData.access_token = "";
          userData.user = {};
          resolve(userData);
        } else {
          const userRepository = AppDataSource.getRepository(User);
          user.password = await UserService.hashUserPassword(user.password);
          await userRepository.save(user);
          const userSettingRepository =
            AppDataSource.getRepository(UserSettings);
          let userSetting = new UserSettings();
          userSetting.userId = user.id;
          userSetting.autoAcceptStatus = false;
          userSetting.loveTaskerOnly = false;
          userSetting.upperStar = 0;
          userSetting.nightMode = false;
          await userSettingRepository.save(userSetting);
          userData.errCode = 0;
          userData.errMessage = "OK";
          let payload = {
            userId: user.id,
            phoneNumber: user.phoneNumber,
            role: user.role,
            expiresIn: process.env.JWT_EXPIRES_IN,
          };
          userData.access_token = await createJWT(payload);

          userData.user = user;
          resolve(userData);
        }
      } catch (error) {
        reject(error);
      }
    });
  };
  static loginUser = async (phoneNumber: string, password: string) => {
    return new Promise(async (resolve, reject) => {
      try {
        let userData: any = {};
        userData.access_token = "";
        let checkUserPhone = await UserService.checkUserPhone(phoneNumber);
        if (checkUserPhone) {
          let userRepository = AppDataSource.getRepository(User);
          let user = await userRepository.findOne({
            select: [
              "id",
              "name",
              "email",
              "password",
              "phoneNumber",
              "role",
              "avatar",
              "taskerInfo",
              "birthday",
              "Rpoints",
            ],
            where: { phoneNumber: phoneNumber },
          });
          if (user) {
            if (bcrypt.compareSync(password, user.password)) {
              userData.errCode = 0;
              userData.errMessage = "OK";
              userData.user = user;
              delete userData.user.password;
              let payload = {
                userId: user.id,
                phoneNumber: user.phoneNumber,
                role: user.role,
                expiresIn: process.env.JWT_EXPIRES_IN,
              };
              userData.access_token = await createJWT(payload);
            } else {
              userData.errCode = 3;
              userData.errMessage =
                "Mật khẩu không chính xác. Vui lòng thử lại!";
            }
          } else {
            userData.errCode = 2;
            userData.errMessage =
              "Số điện thoại không tồn tại trong hệ thống. Vui lòng thử lại!";
          }
        } else {
          userData.errCode = 2;
          userData.errMessage =
            "Số điện thoại không tồn tại trong hệ thống. Vui lòng thử lại!";
        }
        resolve(userData);
      } catch (error) {
        reject(error);
      }
    });
  };
  static convertToShortPhoneNumber(phoneNumber: string): string {
    if (phoneNumber.startsWith("+84")) {
      return "0" + phoneNumber.slice(3);
    }

    return phoneNumber; // Return the original if it doesn't start with +84
  }
  static convertToFullPhoneNumber(phoneNumber: string): string {
    if (phoneNumber.startsWith("0")) {
      return "+84" + phoneNumber.slice(1);
    }
    return phoneNumber; // Return the original if it doesn't start with '0'
  }
  static sendOTP = async (phoneNumber: string, otp: string) => {
    return new Promise(async (resolve, reject) => {
      try {
        let shortPhoneNumber =
          UserService.convertToShortPhoneNumber(phoneNumber);
        let checkUserPhone = await UserService.checkUserPhone(shortPhoneNumber);
        if (checkUserPhone) {
          await client.messages.create({
            body: `OTP của bạn là: ${otp}`,
            from: process.env.TWILIO_PHONE_NUMBER!,
            to: this.convertToFullPhoneNumber(phoneNumber),
          });
          resolve({ errCode: 0, message: "Ok" });
        }
        resolve({
          errCode: 1,
          message: "Số điện thoại không tồn tại trong hệ thống",
        });
      } catch (error) {
        reject(error);
      }
    });
  };
  static verifyOtp = async (userOtp: string, actualOtp: string) => {
    return new Promise(async (resolve, reject) => {
      try {
        if (userOtp === actualOtp) {
          resolve({ errCode: 0, message: "Ok" });
        } else {
          resolve({ errCode: 1, message: "OTP không hợp lệ!" });
        }
      } catch (error) {
        reject(error);
      }
    });
  };
  static forgetPassword = async (newPassword: string, phoneNumber: string) => {
    return new Promise(async (resolve, reject) => {
      try {
        let userRepository = AppDataSource.getRepository(User);
        let user = await userRepository.findOne({
          where: { phoneNumber: phoneNumber },
        });
        if (user) {
          user.password = await UserService.hashUserPassword(newPassword);
          await userRepository.save(user);
          resolve({ errCode: 0, message: "Ok" });
        } else {
          resolve({ errCode: 1, message: "Không tìm thấy người dùng" });
        }
      } catch (error) {
        reject(error);
      }
    });
  };
  static changePassword = async (
    userId: number,
    oldPassword: string,
    newPassword: string
  ) => {
    return new Promise(async (resolve, reject) => {
      try {
        let userRepository = AppDataSource.getRepository(User);
        let user = await userRepository.findOne({
          where: { id: userId },
        });
        if (user) {
          if (bcrypt.compareSync(oldPassword, user.password)) {
            user.password = await UserService.hashUserPassword(newPassword);
            await userRepository.save(user);
            resolve({ errCode: 0, message: "Ok" });
          } else {
            resolve({ errCode: 1, message: "Mật khẩu cũ không chính xác!" });
          }
        } else {
          resolve({ errCode: 1, message: "Không tìm thấy người dùng" });
        }
      } catch (error) {
        reject(error);
      }
    });
  };
  static async createTask(
    userId: number,
    taskTypeId: number,
    time: Date,
    addPriceDetail: any,
    locationId: number,
    note: string,
    voucherId: number,
    myVoucherId: number
  ) {
    let pricedetail = "";
    const taskTypeRepository = AppDataSource.getRepository(TaskTypes);
    const taskType = await taskTypeRepository.findOne({
      where: { id: taskTypeId },
    });

    if (!taskType) {
      return { errCode: 1, message: "Không tìm thấy dịch vụ" };
    }

    let sum = taskType.value;
    let totalPrice = taskType.originalPrice;
    console.log(sum);
    console.log("totalPrice:" + totalPrice);

    // Create task
    const taskRepository = AppDataSource.getRepository(Tasks);
    const newTask = taskRepository.create({
      userId,
      taskTypeId,
      time,
      locationId,
      note,

      taskStatus: "TS1", // Set default value for taskStatus
      numberOfTasker: 0,
      voucherId,
    });

    await taskRepository.save(newTask);

    const addPriceRepository = AppDataSource.getRepository(AddPrices);
    const addPriceRecords = await Promise.all(
      addPriceDetail.map(async (detail: any) => {
        const repo = AppDataSource.getRepository(AddPriceDetails);
        const addPriceDetail = await repo.findOne({
          where: { id: detail.addPriceDetailId },
        });

        if (!addPriceDetail) {
          throw new Error(
            `AddPriceDetail with id ${detail.addPriceDetailId} not found`
          );
        }

        sum =
          parseFloat(sum.toString()) +
          parseFloat(addPriceDetail.value.toString()) *
            parseFloat(detail.quantity.toString());
        totalPrice += addPriceDetail.stepPrice * (detail.quantity - 1);
        pricedetail +=
          "/" +
          (
            (parseFloat(detail.quantity.toString()) - 1) *
              addPriceDetail.stepValue +
            addPriceDetail.beginValue
          ).toString() +
          " " +
          addPriceDetail.unit.toString();

        console.log("sum:" + sum);
        console.log("totalPrice:" + totalPrice);
        console.log("pricedetail:" + pricedetail);
        //+ rpoint

        const userRepository = AppDataSource.getRepository(User);
        const user = await userRepository.findOne({ where: { id: userId } });
        if (user) {
          user.Rpoints += 5;
          await userRepository.save(user);
        }

        return addPriceRepository.create({
          taskId: newTask.id,
          addPriceDetailId: detail.addPriceDetailId,
          quantity: detail.quantity,
          price: 0,
        });
      })
    );

    await addPriceRepository.save(addPriceRecords);
    // tinh tien voucher
    if (voucherId !== undefined) {
      const voucherRepository = AppDataSource.getRepository(Vouchers);
      const voucher = await voucherRepository.findOne({
        where: { id: voucherId },
      });
      if (voucher) {
        if (voucher.applyTasks === "ALL") {
          if (voucher.value.includes("%")) {
            const discount = parseFloat(voucher.value.replace("%", ""));
            totalPrice = (totalPrice * (100 - discount)) / 100;
          } else {
            const giamgia = parseFloat(voucher.value.replace("đ", ""));
            console.log("giảm giá nè");
            console.log(giamgia);

            totalPrice =
              totalPrice - parseFloat(voucher.value.replace("đ", ""));
          }
        } else {
          const taskIds = voucher.applyTasks.split("_");
          if (taskIds.includes(taskType.id.toString())) {
            if (voucher.value.includes("%")) {
              const discount = parseFloat(voucher.value.replace("%", ""));
              totalPrice = (totalPrice * (100 - discount)) / 100;
            } else {
              const giamgia = parseFloat(voucher.value.replace("đ", ""));
              console.log("giảm giá nè");
              console.log(giamgia);

              totalPrice -= parseFloat(voucher.value.replace("đ", ""));
            }
          }
        }
        const myVoucherRepository = AppDataSource.getRepository(MyVouchers);
        const myVoucher = await myVoucherRepository.findOne({
          where: { id: myVoucherId, isUsed: false },
        });
        if (myVoucher) {
          console.log("vào đây rồi ");
          console.log(myVoucher.id);
          myVoucher.isUsed = true;
          await myVoucherRepository.save(myVoucher);
        }
      }
    }
    console.log("totalPricevoucher:" + totalPrice);

    sum = Math.ceil(sum);

    newTask.numberOfTasker = sum;
    newTask.price = totalPrice.toString() + " đ" + pricedetail;

    await taskRepository.save(newTask);

    return {
      errCode: 0,
      message: "Task created successfully",
    };
  }
  static async editTask(
    taskId: number,
    time?: Date,
    addPriceDetail?: {
      addPriceDetailId: number;
      quantity: number;
      price: number;
    }[],
    locationId?: number,
    note?: string,
    taskStatus?: string
  ) {
    const taskRepository = AppDataSource.getRepository(Tasks);
    const task = await taskRepository.findOneBy({ id: taskId });

    if (!task) {
      throw new Error("Task not found");
    }
    const taskTypeRepository = AppDataSource.getRepository(TaskTypes);
    const taskType = await taskTypeRepository.findOne({
      where: { id: task.taskTypeId },
    });

    if (!taskType) {
      throw new Error("Task type not found");
    }
    let sum = taskType.value;

    await taskRepository.save(task);
    if (addPriceDetail !== undefined) {
      const addPriceRepository = AppDataSource.getRepository(AddPrices);
      await addPriceRepository.delete({ taskId: taskId });
      if (Array.isArray(addPriceDetail)) {
        const addPriceRepository = AppDataSource.getRepository(AddPrices);
        const addPriceRecords = await Promise.all(
          addPriceDetail.map(async (detail) => {
            const repo = AppDataSource.getRepository(AddPriceDetails);
            const addPriceDetail = await repo.findOne({
              where: { id: detail.addPriceDetailId },
            });
            if (addPriceDetail) {
              sum =
                parseFloat(sum.toString()) +
                parseFloat(addPriceDetail.value.toString()) *
                  parseFloat(detail.quantity.toString());
              console.log(sum);
            }
            if (task.isReTaskChildren === 0) {
              return addPriceRepository.create({
                taskId: task.id,
                addPriceDetailId: detail.addPriceDetailId,
                quantity: detail.quantity,
                price: detail.price,
              });
            } else {
              return addPriceRepository.create({
                reTaskId: task.id,
                addPriceDetailId: detail.addPriceDetailId,
                quantity: detail.quantity,
                price: detail.price,
              });
            }
          })
        );

        await addPriceRepository.save(addPriceRecords);
        sum = Math.ceil(sum);
      }
    }
    task.numberOfTasker = sum;
    await taskRepository.save(task);

    if (time !== undefined) {
      task.time = time;
    }

    if (locationId !== undefined) {
      task.locationId = locationId;
    }

    if (note !== undefined) {
      task.note = note;
    }

    if (taskStatus !== undefined) {
      task.taskStatus = taskStatus;
    }
    await taskRepository.save(task);

    return {
      errCode: 0,
      message: "Task updated successfully",
    };
  }
  static async getAllTasks(userId: number) {
    const taskRepository = AppDataSource.getRepository(Tasks);

    const tasks = await taskRepository
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
      ])
      .where("task.userId = :userId", { userId })
      .getMany();

    return {
      errCode: 0,
      errMessage: "OK",
      tasklist: tasks,
    };
  }
  static async getAllVoucher() {
    const voucherRepository = AppDataSource.getRepository(Vouchers);
    const currentDate = new Date();
    const vouchers = await voucherRepository.find({
      where: {
        endDate: MoreThan(currentDate),
        quantity: MoreThan(0),
      },
    });

    return {
      errCode: 0,
      errMessage: "OK",
      voucherList: vouchers,
    };
  }

  static async getMyVoucher(userId: number) {
    const voucherRepository = AppDataSource.getRepository(Vouchers);
    const currentDate = new Date();
    const myVoucherRepository = AppDataSource.getRepository(MyVouchers);
    const myVouchers = await myVoucherRepository.find({
      where: { userId: userId },
    });

    const vouchers = [];
    for (const myVoucher of myVouchers) {
      const voucher = await voucherRepository.findOne({
        where: {
          id: myVoucher.voucherId,
          endDate: MoreThan(currentDate),
        },
      });
      if (voucher) {
        vouchers.push(voucher);
      }
    }

    return {
      errCode: 0,
      errMessage: "OK",
      voucherList: vouchers,
    };
  }
  static async getAllTaskType() {
    const taskTypeRepository = AppDataSource.getRepository(TaskTypes);
    const taskTypes = await taskTypeRepository.find();
    return {
      errCode: 0,
      errMessage: "OK",
      taskTypeList: taskTypes,
    };
  }
  static async getATaskType(taskTypeId: number) {
    const taskTypeRepository = AppDataSource.getRepository(TaskTypes);

    const taskType = await taskTypeRepository
      .createQueryBuilder("taskType")
      .leftJoinAndSelect("taskType.addPriceDetails", "addPriceDetails")
      .where("taskType.id = :taskTypeId", { taskTypeId })
      .getOne();

    return {
      errCode: 0,
      errMessage: "OK",
      taskType: taskType,
    };
  }
  static async getSetting(userId: number) {
    const userSettingRepository = AppDataSource.getRepository(UserSettings);

    const userSetting = await userSettingRepository.findOne({
      where: { userId: userId },
    });

    return {
      errCode: 0,
      errMessage: "OK",
      setting: userSetting,
    };
  }
  static async getTaskerList(taskId: number) {
    const taskerListRepository = AppDataSource.getRepository(TaskerList);

    const taskerList = await taskerListRepository
      .createQueryBuilder("taskerList")
      .leftJoinAndSelect("taskerList.tasker", "user")
      .where("taskerList.taskId = :taskId", { taskId })
      .select([
        "taskerList.id",
        "taskerList.taskId",
        "taskerList.taskerId",
        "taskerList.status",
        "taskerList.createdAt",
        "taskerList.updatedAt",
        "taskerList.reviewStar",
        "user.id",
        "user.name",
        "user.email",
        "user.phoneNumber",
        "user.role",
        "user.avatar",
        "user.birthday",
        "user.avatar",
      ])
      .getMany();

    return {
      errCode: 0,
      errMessage: "OK",
      taskerList: taskerList,
    };
  }
  static async addNewLoveTasker(userId: number, taskerId: number) {
    const taskerListRepository = AppDataSource.getRepository(LoveTaskers);
    const taskerList = taskerListRepository.create({
      userId: userId,
      taskerId: taskerId,
    });

    await taskerListRepository.save(taskerList);

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async addNewBlockTasker(userId: number, taskerId: number) {
    const taskerListRepository = AppDataSource.getRepository(BlockTaskers);
    const taskerList = taskerListRepository.create({
      userId: userId,
      taskerId: taskerId,
    });

    await taskerListRepository.save(taskerList);

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async getLoveTaskerList(userId: number) {
    const taskerListRepository = AppDataSource.getRepository(LoveTaskers);
    const loveList = await taskerListRepository
      .createQueryBuilder("loveTaskers")
      .leftJoinAndSelect("loveTaskers.tasker", "user")
      .where("loveTaskers.userId = :userId", { userId })
      .select([
        "loveTaskers.id",
        "loveTaskers.userId",
        "loveTaskers.taskerId",
        "user.id",
        "user.name",
        "user.email",
        "user.phoneNumber",
        "user.role",
        "user.avatar",
        "user.birthday",
      ])
      .getMany();
    return {
      errCode: 0,
      errMessage: "OK",
      loveList: loveList,
    };
  }
  static async getBlockTaskerList(userId: number) {
    const taskerListRepository = AppDataSource.getRepository(BlockTaskers);
    const blockList = await taskerListRepository
      .createQueryBuilder("blockTaskers")
      .leftJoinAndSelect("blockTaskers.tasker", "user")
      .where("blockTaskers.userId = :userId", { userId })
      .select([
        "blockTaskers.id",
        "blockTaskers.userId",
        "blockTaskers.taskerId",
        "user.id",
        "user.name",
        "user.email",
        "user.phoneNumber",
        "user.role",
        "user.avatar",
        "user.birthday",
      ])
      .getMany();

    return {
      errCode: 0,
      errMessage: "OK",
      blockList: blockList,
    };
  }
  static async deleteLoveTasker(userId: number, taskerId: number) {
    const taskerListRepository = AppDataSource.getRepository(LoveTaskers);
    await taskerListRepository.delete({ userId: userId, taskerId: taskerId });

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async deleteBlockTasker(userId: number, taskerId: number) {
    const taskerListRepository = AppDataSource.getRepository(BlockTaskers);
    await taskerListRepository.delete({ userId: userId, taskerId: taskerId });

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async review(
    taskId: number,
    taskerId: number,
    star: number,
    content: string,

    userId: number,

    imageArray: any,
    taskTypeId: number
  ) {
    const reviewRepository = AppDataSource.getRepository(Reviews);
    const userRepository = AppDataSource.getRepository(User);
    const user = await userRepository.findOne({ where: { id: userId } });

    const review = reviewRepository.create({
      taskId: taskId,
      taskerId: taskerId,
      star: star,
      content: content,
      userId: userId,
      userName: user?.name,
      userAvatar: user?.avatar,
      taskTypeId: taskTypeId,
    });
    if (imageArray.length > 0) review.image1 = imageArray[0];
    if (imageArray.length > 1) review.image2 = imageArray[1];
    if (imageArray.length > 2) review.image3 = imageArray[2];
    if (imageArray.length > 3) review.image4 = imageArray[3];

    await reviewRepository.save(review);
    const taskerListRepository = AppDataSource.getRepository(TaskerList);
    const taskerList = await taskerListRepository.findOne({
      where: { taskId: taskId, taskerId: taskerId },
    });
    if (taskerList) {
      taskerList.reviewStar = star;
      await taskerListRepository.save(taskerList);
    }

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async getATask(taskId: number) {
    const taskRepository = AppDataSource.getRepository(Tasks);
    const task = await taskRepository
      .createQueryBuilder("task")
      .leftJoinAndSelect("task.location", "location")
      .leftJoinAndSelect("task.user", "user")
      .leftJoinAndSelect("task.taskType", "taskType")
      .leftJoinAndSelect("task.taskerLists", "taskerLists")
      .where("task.id = :taskId", { taskId })
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
        "task.numberOfTasker",

        "task.approvedAt",
        "task.cancelAt",
        "task.finishedAt",
        "task.cancelReason",

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
      ])

      .getOne();

    return {
      errCode: 0,
      errMessage: "OK",
      task: task,
    };
  }
  static async getTaskerInfo(taskerId: number, userId: number) {
    const userRepository = AppDataSource.getRepository(User);
    const tasker = await userRepository.findOne({
      where: { id: taskerId },
      select: [
        "id",
        "name",
        "email",
        "phoneNumber",
        "role",
        "avatar",
        "birthday",
        "Rpoints",
        "taskerInfoId",
        "createdAt",
        "updatedAt",
      ],
    });
    const reviewRepository = AppDataSource.getRepository(Reviews);
    const reviews = await reviewRepository
      .createQueryBuilder("review")
      .leftJoinAndSelect("review.task", "task")
      .leftJoinAndSelect("review.taskType", "taskType")
      .where("review.taskerId = :taskerId", { taskerId })
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
        "taskType.image",
      ])
      .getMany();
    const loveTaskerRepository = AppDataSource.getRepository(LoveTaskers);
    const loveTasker = await loveTaskerRepository.findOne({
      where: { userId: userId, taskerId: taskerId },
    });
    const blockTaskerRepository = AppDataSource.getRepository(BlockTaskers);
    const blockTasker = await blockTaskerRepository.findOne({
      where: { userId: userId, taskerId: taskerId },
    });
    const taskerInfoRepository = AppDataSource.getRepository(TaskerInfo);
    let ti = 1;
    if (tasker) {
      ti = tasker.taskerInfoId;
    }
    console.log(ti);
    const taskerInfo = await taskerInfoRepository.findOne({
      where: { id: ti },
    });
    return {
      errCode: 0,
      errMessage: "OK",
      tasker: tasker,
      reviewList: reviews,
      loveTasker: loveTasker ? true : false,

      blockTasker: blockTasker ? true : false,
      taskerInfo: taskerInfo,
    };
  }
  static async getAllReviews(taskerId: number) {
    const reviewRepository = AppDataSource.getRepository(Reviews);
    const reviews = await reviewRepository
      .createQueryBuilder("review")
      .leftJoinAndSelect("review.task", "task")
      .leftJoinAndSelect("review.taskType", "taskType")
      .where("review.taskerId = :taskerId", { taskerId })
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

    return {
      errCode: 0,
      errMessage: "OK",
      reviewList: reviews,
    };
  }
  static async getAReviews(taskerId: number, taskId: number) {
    const reviewRepository = AppDataSource.getRepository(Reviews);
    const reviews = await reviewRepository
      .createQueryBuilder("review")
      .leftJoinAndSelect("review.task", "task")
      .leftJoinAndSelect("review.taskType", "taskType")
      .where("review.taskerId = :taskerId AND review.taskId = :taskId", {
        taskerId,
        taskId,
      })
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
        "taskType.image",
      ])
      .getOne();

    return {
      errCode: 0,
      errMessage: "OK",
      review: reviews,
    };
  }
  static async editSetting(
    userId: number,
    autoAcceptStatus: boolean,
    loveTaskerOnly: boolean,
    upperStar: number
  ) {
    const settingRepository = AppDataSource.getRepository(UserSettings);
    const setting = await settingRepository.findOne({
      where: { userId: userId },
    });
    if (setting) {
      if (autoAcceptStatus !== undefined)
        setting.autoAcceptStatus = autoAcceptStatus;
      if (loveTaskerOnly !== undefined) setting.loveTaskerOnly = loveTaskerOnly;
      if (upperStar !== undefined) setting.upperStar = upperStar;
      await settingRepository.save(setting);
    }

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async claimVoucher(userId: number, voucherId: number) {
    const voucherRepository = AppDataSource.getRepository(Vouchers);
    const voucher = await voucherRepository.findOne({
      where: { id: voucherId },
    });
    if (!voucher) {
      return {
        errCode: 1,
        errMessage: "Không tìm thấy voucher!",
      };
    }

    const myVoucherRepository = AppDataSource.getRepository(MyVouchers);
    const existingMyVoucher = await myVoucherRepository.findOne({
      where: { userId: userId, voucherId: voucherId },
    });

    if (existingMyVoucher) {
      return {
        errCode: 2,
        errMessage: "Bạn đã lưu voucher này rồi!",
      };
    }

    const userRepositoryy = AppDataSource.getRepository(User);
    const userr = await userRepositoryy.findOne({ where: { id: userId } });

    if (userr && userr.Rpoints < voucher.RpointCost) {
      return {
        errCode: 2,
        errMessage: "Bạn không đủ điểm Rpoint",
      };
    }

    const myVoucher = myVoucherRepository.create({
      userId: userId,
      voucherId: voucherId,
      isUsed: false,
    });

    await myVoucherRepository.save(myVoucher);

    voucher.quantity = voucher.quantity - 1;
    await voucherRepository.save(voucher);

    const userRepository = AppDataSource.getRepository(User);
    const user = await userRepository.findOne({ where: { id: userId } });
    if (user) {
      user.Rpoints -= voucher.RpointCost;
      await userRepository.save(user);
    }
    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async getAvailableVoucher(userId: number, taskTypeId: number) {
    const voucherRepository = AppDataSource.getRepository(Vouchers);
    const currentDate = new Date();
    const myVoucherRepository = AppDataSource.getRepository(MyVouchers);

    const myVouchers = await myVoucherRepository.find({
      where: { userId: userId, isUsed: false },
    });

    const availableVouchers = [];
    for (const myVoucher of myVouchers) {
      const voucher = await voucherRepository.findOne({
        where: {
          id: myVoucher.voucherId,
          endDate: MoreThan(currentDate),
        },
      });

      if (voucher) {
        if (
          voucher.applyTasks === "ALL" ||
          voucher.applyTasks.split("_").includes(taskTypeId.toString())
        ) {
          availableVouchers.push(voucher);
        }
      }
    }

    return {
      errCode: 0,
      errMessage: "OK",
      availableVouchers: availableVouchers,
    };
  }

  static async uploadImage(file: any, quantity: string) {
    const firebaseUser = process.env.FIREBASE_USER;
    const firebaseAuth = process.env.FIREBASE_AUTH;

    if (!firebaseUser || !firebaseAuth) {
      throw new Error(
        "FIREBASE_USER and FIREBASE_AUTH must be set in the environment variables"
      );
    }
    const storageFB = getStorage();
    await signInWithEmailAndPassword(auth, firebaseUser, firebaseAuth);

    if (quantity === "single") {
      const dateTime = Date.now();
      const fileName = `images/${dateTime}-${file.originalname}`;
      const storageRef = ref(storageFB, fileName);
      const metadata = {
        contentType: file.mimetype,
      };
      await uploadBytesResumable(storageRef, file.buffer, metadata);
      return fileName;
    } else if (quantity === "multiple") {
      const fileNames = [];
      for (let i = 0; i < file.length; i++) {
        const dateTime = Date.now();
        const fileName = `images/${dateTime}-${file[i].originalname}`;
        const storageRef = ref(storageFB, fileName);
        const metadata = {
          contentType: file[i].mimetype,
        };
        await uploadBytesResumable(storageRef, file[i].buffer, metadata);
        fileNames.push(fileName);
      }
      return fileNames;
    }
  }
  static async edittkls(taskerListId: number, status: string) {
    const currentDate = new Date();
    const taskerListRepository = AppDataSource.getRepository(TaskerList);
    const taskerList = await taskerListRepository.findOne({
      where: { id: taskerListId },
    });
    if (taskerList) {
      taskerList.status = status;
      await taskerListRepository.save(taskerList);
    }
    const taskRepository = AppDataSource.getRepository(Tasks);
    if (taskerList) {
      const task = await taskRepository.findOne({
        where: { id: taskerList.taskId },
      });
      if (task) {
        const taskerListCount = await taskerListRepository.count({
          where: { taskId: taskerList.taskId, status: "S2" },
        });

        if (taskerListCount === task.numberOfTasker) {
          task.taskStatus = "TS2";
          await taskRepository.save(task);
          task.approvedAt = currentDate;
        } else {
          task.taskStatus = "TS1";
          await taskRepository.save(task);
        }
      }
    }

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async deleteAccount(userId: number) {
    const userRepository = AppDataSource.getRepository(User);
    const user = await userRepository.findOne({ where: { id: userId } });
    if (user) {
      await userRepository.delete({ id: userId });
    }

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async cancelTask(taskId: number, cancelCode: number) {
    const currentDate = new Date();
    const taskRepository = AppDataSource.getRepository(Tasks);
    const task = await taskRepository.findOne({ where: { id: taskId } });
    if (task) {
      task.taskStatus = "TS4";
      if (cancelCode === 0) {
        task.cancelReason = "Khách hàng không có nhu cầu nữa";
      }
      if (cancelCode === 1) {
        task.cancelReason = "Khách hàng có công việc đột xuất";
      }
      if (cancelCode === 2) {
        task.cancelReason = "Khách hàng muốn đặt công việc khác";
      }
      if (cancelCode === 3) {
        task.cancelReason = "Lý do khác";
      }
      task.cancelAt = currentDate;
      await taskRepository.save(task);
    }
    const taskerListRepository = AppDataSource.getRepository(TaskerList);
    await taskerListRepository.delete({ taskId: taskId });

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async finishTask(taskId: number) {
    const currentDate = new Date();
    const taskRepository = AppDataSource.getRepository(Tasks);
    const task = await taskRepository.findOne({ where: { id: taskId } });
    if (task) {
      task.taskStatus = "TS3";
      task.finishedAt = currentDate;
      await taskRepository.save(task);
    }
    const taskerListRepository = AppDataSource.getRepository(TaskerList);
    const taskerLists = await taskerListRepository.find({
      where: { taskId: taskId, status: "S2" },
    });

    for (const taskerList of taskerLists) {
      taskerList.status = "S5";
      await taskerListRepository.save(taskerList);
    }

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async editUserProfile(
    userId: any,
    name: any,
    email: any,
    phoneNumber: any,
    avatar: any
  ) {
    const userRepository = AppDataSource.getRepository(User);
    const user = await userRepository.findOne({ where: { id: userId } });
    if (user) {
      if (name !== undefined) user.name = name;
      if (email !== undefined) user.email = email;
      if (phoneNumber !== undefined) user.phoneNumber = phoneNumber;
      if (avatar !== undefined) user.avatar = avatar;
      await userRepository.save(user);
    }

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async deleteMyVoucher(userId: number, myVoucherId: number) {
    const myVoucherRepository = AppDataSource.getRepository(MyVouchers);
    await myVoucherRepository.delete({
      userId: userId,
      voucherId: myVoucherId,
    });
    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async pushNotification(
    userId: number,
    header: string,
    content: string,
    image: string
  ) {
    const notificationRepository = AppDataSource.getRepository(Notifications);
    const notification = notificationRepository.create({
      userId: userId,
      header: header,
      content: content,
      image: image,
    });
    await notificationRepository.save(notification);

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async getNotification(userId: number) {
    const notificationRepository = AppDataSource.getRepository(Notifications);
    const notifications = await notificationRepository.find({
      where: { userId: userId },
    });

    return {
      errCode: 0,
      errMessage: "OK",
      notificationList: notifications,
    };
  }
  static async deleteNotification(notificationId: number) {
    const notificationRepository = AppDataSource.getRepository(Notifications);
    await notificationRepository.delete({ id: notificationId });
    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
}
