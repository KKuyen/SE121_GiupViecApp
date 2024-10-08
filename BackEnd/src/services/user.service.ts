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
        if (await UserService.checkUserPhone(user.phoneNumber)) {
          resolve({ errCode: 1, message: "Phone number already exists" });
        } else {
          const userRepository = AppDataSource.getRepository(User);
          user.password = await UserService.hashUserPassword(user.password);
          await userRepository.save(user);
          resolve({ errCode: 0, message: "Ok" });
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
                "Your password is incorrect. Please try again!";
            }
          } else {
            userData.errCode = 2;
            userData.errMessage =
              "Your phone number isn`t exist in system. Please try again!";
          }
        } else {
          userData.errCode = 2;
          userData.errMessage =
            "Your phone number isn`t exist in system. Please try again!";
        }
        resolve(userData);
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
    isReTaskChildren: number,
    voucherId: number,
    myVoucherId: number
  ) {
    let pricedetail = "";
    const taskTypeRepository = AppDataSource.getRepository(TaskTypes);
    const taskType = await taskTypeRepository.findOne({
      where: { id: taskTypeId },
    });

    if (!taskType) {
      return { errCode: 1, message: "Task type not found" };
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
      isReTaskChildren,
      taskStatus: "S1", // Set default value for taskStatus
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
          addPriceDetail.name.toString();

        console.log("sum:" + sum);
        console.log("totalPrice:" + totalPrice);
        console.log("pricedetail:" + pricedetail);

        if (isReTaskChildren === 0) {
          return addPriceRepository.create({
            taskId: newTask.id,
            addPriceDetailId: detail.addPriceDetailId,
            quantity: detail.quantity,
            price: detail.price,
          });
        } else {
          return addPriceRepository.create({
            reTaskId: newTask.id,
            addPriceDetailId: detail.addPriceDetailId,
            quantity: detail.quantity,
            price: detail.price,
          });
        }
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
            totalPrice = totalPrice - parseFloat(voucher.value);
          }
        } else {
          const taskIds = voucher.applyTasks.split("_");
          if (taskIds.includes(taskType.id.toString())) {
            if (voucher.value.includes("%")) {
              const discount = parseFloat(voucher.value.replace("%", ""));
              totalPrice = (totalPrice * (100 - discount)) / 100;
            } else {
              totalPrice = totalPrice - parseFloat(voucher.value);
            }
          }
        }
        const myVoucherRepository = AppDataSource.getRepository(MyVouchers);
        const myVoucher = await myVoucherRepository.findOne({
          where: { id: myVoucherId },
        });
        if (myVoucher) {
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

    return {
      errCode: 0,
      message: "Task updated successfully",
    };
  }
  static async getAllTasks(userId: number) {
    const taskRepository = AppDataSource.getRepository(Tasks);
    const tasks = await taskRepository.find({ where: { userId: userId } });
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
  static async getTaskerList(taskId: number) {
    const taskerListRepository = AppDataSource.getRepository(TaskerList);
    const taskerList = await taskerListRepository.find({
      where: { taskId: taskId },
    });

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
    const loveList = await taskerListRepository.find({
      where: { userId: userId },
    });

    return {
      errCode: 0,
      errMessage: "OK",
      loveList: loveList,
    };
  }
  static async getBlockTaskerList(userId: number) {
    const taskerListRepository = AppDataSource.getRepository(BlockTaskers);
    const blockList = await taskerListRepository.find({
      where: { userId: userId },
    });

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
    imageArray: any
  ) {
    const reviewRepository = AppDataSource.getRepository(Reviews);
    const review = reviewRepository.create({
      taskId: taskId,
      taskerId: taskerId,
      star: star,
      content: content,
    });
    if (imageArray.length > 0) review.image1 = imageArray[0];
    if (imageArray.length > 1) review.image2 = imageArray[1];
    if (imageArray.length > 2) review.image3 = imageArray[2];
    if (imageArray.length > 3) review.image4 = imageArray[3];

    await reviewRepository.save(review);

    return {
      errCode: 0,
      errMessage: "OK",
    };
  }
  static async getATask(taskId: number) {
    const taskRepository = AppDataSource.getRepository(Tasks);
    const task = await taskRepository.findOne({ where: { id: taskId } });
    const taskerListRepository = AppDataSource.getRepository(TaskerList);
    const taskerList = await taskerListRepository.find({
      where: { taskId: taskId },
    });

    return {
      errCode: 0,
      errMessage: "OK",
      task: task,
      taskerList: taskerList,
    };
  }
  static async getTaskerInfo(taskerId: number, userId: number) {
    const userRepository = AppDataSource.getRepository(User);
    const tasker = await userRepository.findOne({ where: { id: taskerId } });
    const reviewRepository = AppDataSource.getRepository(Reviews);
    const reviews = await reviewRepository.find({
      where: { taskerId: taskerId },
    });
    const loveTaskerRepository = AppDataSource.getRepository(LoveTaskers);
    const loveTasker = await loveTaskerRepository.findOne({
      where: { userId: userId, taskerId: taskerId },
    });
    const blockTaskerRepository = AppDataSource.getRepository(BlockTaskers);
    const blockTasker = await blockTaskerRepository.findOne({
      where: { userId: userId, taskerId: taskerId },
    });
    const taskerInfoRepository = AppDataSource.getRepository(TaskerInfo);
    const taskerInfo = await taskerInfoRepository.findOne({
      where: { id: tasker?.taskerInfo },
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
        errMessage: "Voucher not found",
      };
    }

    const myVoucherRepository = AppDataSource.getRepository(MyVouchers);
    const myVoucher = myVoucherRepository.create({
      userId: userId,
      voucherId: voucherId,
      isUsed: false,
    });

    await myVoucherRepository.save(myVoucher);

    voucher.quantity = voucher.quantity - 1;
    await voucherRepository.save(voucher);

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
}
