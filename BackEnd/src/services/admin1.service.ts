import { AddPriceDetails } from "./../entity/AddPriceDetails.entity";
import * as dotenv from "dotenv";
require("dotenv").config();
import { AppDataSource } from "../data-source"; // Adjust the path as necessary
import { TaskTypes } from "../entity/TaskTypes.entity";
import { PaymentInformation } from "../entity/PaymentInfomation.entity";
import { Tasks } from "../entity/Task.entity";
import { Complaint } from "../entity/Complaint.entity";
import { User } from "../entity/User.entity";

export class Admin1Service {
  static async getAllTaskType() {
    const taskTypeRepository = AppDataSource.getRepository(TaskTypes);
    const taskTypes = await taskTypeRepository
      .createQueryBuilder("taskType")
      .leftJoinAndSelect("taskType.addPriceDetails", "addPriceDetails")
      .getMany();
    return {
      errCode: 0,
      errMessage: "OK",
      taskTypeList: taskTypes,
    };
  }
  static async createATaskType(
    name: string,
    avatar: string,
    description: string,
    image: string,
    value: number,
    originalPrice: number,
    addPriceDetails: any[] // Danh sách chi tiết giá bổ sung
  ) {
    const taskTypeRepository = AppDataSource.getRepository(TaskTypes);
    const addPriceDetailsRepository =
      AppDataSource.getRepository(AddPriceDetails);

    // Tạo và lưu TaskType mới
    const newTaskType = taskTypeRepository.create({
      name,
      avatar,
      description,
      image,
      value,
      originalPrice,
    });
    await taskTypeRepository.save(newTaskType);

    // Nếu có addPriceDetails, thêm vào database và liên kết với TaskType mới
    if (addPriceDetails) {
      const newAddPriceDetails = addPriceDetails.map((detail) => {
        return addPriceDetailsRepository.create({
          taskTypeId: newTaskType.id, // Liên kết với TaskType vừa tạo
          name: detail.name,
          value: detail.value,
          stepPrice: detail.stepPrice,
          beginPrice: detail.beginPrice,
          stepValue: detail.stepValue,
          unit: detail.unit,
          beginValue: detail.beginValue,
        });
      });

      await addPriceDetailsRepository.save(newAddPriceDetails);
    }

    return {
      errCode: 0,
      errMessage: "Task type created successfully",
      taskType: newTaskType,
    };
  }
  static async deleteTaskType(taskTypeId: number) {
    const taskTypeRepository = AppDataSource.getRepository(TaskTypes);
    const addPriceDetailsRepository =
      AppDataSource.getRepository(AddPriceDetails);

    const taskType = await taskTypeRepository.findOne({
      where: {
        id: taskTypeId,
      },
    });

    if (!taskType) {
      return {
        errCode: 1,
        errMessage: "Task type not found",
      };
    }

    // Xóa các AddPriceDetails liên quan
    await addPriceDetailsRepository.delete({
      taskTypeId: taskTypeId,
    });

    // Xóa TaskType
    await taskTypeRepository.delete({
      id: taskTypeId,
    });

    return {
      errCode: 0,
      errMessage: "Task type deleted successfully",
    };
  }
  static async deleteAddPriceDetail(addPriceDetailId: number) {
    const addPriceDetailsRepository =
      AppDataSource.getRepository(AddPriceDetails);

    const addPriceDetail = await addPriceDetailsRepository.findOne({
      where: {
        id: addPriceDetailId,
      },
    });

    if (!addPriceDetail) {
      return {
        errCode: 1,
        errMessage: "Add price detail not found",
      };
    }

    await addPriceDetailsRepository.delete({
      id: addPriceDetailId,
    });

    return {
      errCode: 0,
      errMessage: "Add price detail deleted successfully",
    };
  }
  static async createAAddPriceDetail(
    taskTypeId: number,
    name: string,
    value: number,
    stepPrice: number,
    beginPrice: number,
    stepValue: number,
    unit: string,
    beginValue: number
  ) {
    const addPriceDetailsRepository =
      AppDataSource.getRepository(AddPriceDetails);

    const newAddPriceDetail = addPriceDetailsRepository.create({
      taskTypeId,
      name,
      value,
      stepPrice,
      beginPrice,
      stepValue,
      unit,
      beginValue,
    });
    await addPriceDetailsRepository.save(newAddPriceDetail);

    return {
      errCode: 0,
      errMessage: "Add price detail created successfully",
      addPriceDetail: newAddPriceDetail,
    };
  }
  static async editTaskType(
    taskTypeId: number,
    name: string,
    avatar: string,
    description: string,
    image: string,
    value: number,
    originalPrice: number,
    addPriceDetails: any[] // Danh sách chi tiết giá bổ sung (được thay thế hoàn toàn)
  ) {
    const taskTypeRepository = AppDataSource.getRepository(TaskTypes);
    const addPriceDetailsRepository =
      AppDataSource.getRepository(AddPriceDetails);

    // Tìm TaskType theo ID
    const existingTaskType = await taskTypeRepository.findOne({
      where: { id: taskTypeId },
    });

    if (!existingTaskType) {
      return {
        errCode: 1,
        errMessage: "Task type not found",
      };
    }

    // Cập nhật thông tin TaskType
    existingTaskType.name = name;
    existingTaskType.avatar = avatar;
    existingTaskType.description = description;
    existingTaskType.image = image;
    existingTaskType.value = value;
    existingTaskType.originalPrice = originalPrice;

    await taskTypeRepository.save(existingTaskType);

    // Xóa tất cả các AddPriceDetails cũ của TaskType
    await addPriceDetailsRepository.delete({ taskTypeId });

    // Thêm mới danh sách AddPriceDetails
    if (addPriceDetails && addPriceDetails.length > 0) {
      const newAddPriceDetails = addPriceDetails.map((detail) =>
        addPriceDetailsRepository.create({
          taskTypeId: taskTypeId,
          name: detail.name,
          value: detail.value,
          stepPrice: detail.stepPrice,
          beginPrice: detail.beginPrice,
          stepValue: detail.stepValue,
          unit: detail.unit,
          beginValue: detail.beginValue,
        })
      );

      await addPriceDetailsRepository.save(newAddPriceDetails);
    }

    return {
      errCode: 0,
      errMessage: "Task type updated successfully",
      taskType: existingTaskType,
    };
  }
  static async editAAddPriceDetail(
    id: number, // ID của AddPriceDetail cần cập nhật
    taskTypeId: number,
    name: string,
    value: number,
    stepPrice: number,
    beginPrice: number,
    stepValue: number,
    unit: string,
    beginValue: number
  ) {
    const addPriceDetailsRepository =
      AppDataSource.getRepository(AddPriceDetails);

    // Tìm AddPriceDetail theo ID
    const existingDetail = await addPriceDetailsRepository.findOne({
      where: { id },
    });

    if (!existingDetail) {
      return {
        errCode: 1,
        errMessage: "Add price detail not found",
      };
    }

    // Cập nhật thông tin AddPriceDetail
    existingDetail.taskTypeId = taskTypeId;
    existingDetail.name = name;
    existingDetail.value = value;
    existingDetail.stepPrice = stepPrice;
    existingDetail.beginPrice = beginPrice;
    existingDetail.stepValue = stepValue;
    existingDetail.unit = unit;
    existingDetail.beginValue = beginValue;

    await addPriceDetailsRepository.save(existingDetail);

    return {
      errCode: 0,
      errMessage: "Add price detail updated successfully",
      addPriceDetail: existingDetail,
    };
  }
  static async getPaymentInformation() {
    const taskTypeRepository = AppDataSource.getRepository(PaymentInformation);
    const paymentInformation = await taskTypeRepository.find();
    return {
      errCode: 0,
      errMessage: "OK",
      paymentInformation: paymentInformation,
    };
  }
  static async getIncome(month: number, year: number) {
    const taskRepository = AppDataSource.getRepository(Tasks);
    const tasks = await taskRepository
      .createQueryBuilder("task")
      .where("task.taskStatus = :taskStatus", { taskStatus: "TS3" })
      .andWhere("EXTRACT(MONTH FROM task.finishedAt) = :month", { month })
      .andWhere("EXTRACT(YEAR FROM task.finishedAt) = :year", { year })
      .getMany();

    const dailyIncome: { [key: string]: number } = {};
    let totalIncome = 0;
    let totalTasks = tasks.length;

    tasks.forEach((task) => {
      const dateObj = new Date(task.finishedAt);
      const day = dateObj.getDate();
      const formattedDate = `${year}-${String(month).padStart(2, "0")}-${String(
        day
      ).padStart(2, "0")}`;

      const priceMatch = task.price.match(/\d+/);
      const price = priceMatch ? parseInt(priceMatch[0], 10) : 0;

      if (!isNaN(price)) {
        dailyIncome[formattedDate] = (dailyIncome[formattedDate] || 0) + price;
        totalIncome += price;
      }
    });

    return {
      errCode: 0,
      income: dailyIncome,
      totalIncome,
      totalTasks,
    };
  }
  static async getComplaints() {
    const complaintRepository = AppDataSource.getRepository(Complaint);
    const complaints = await complaintRepository.find();

    return {
      errCode: 0,
      complaints,
    };
  }
  static async getAComplaint(complaintId: number) {
    const complaintRepository = AppDataSource.getRepository(Complaint);
    const complaint = await complaintRepository.findOne({
      where: { id: complaintId },
    });

    if (!complaint) {
      return {
        errCode: 1,
        errMessage: "Complaint not found",
      };
    }

    return {
      errCode: 0,
      complaint,
    };
  }
  static async getUserById(userId: number) {
    const userRepository = AppDataSource.getRepository(User);
    const user = await userRepository.findOne({
      where: { id: userId },
    });
    if (!user) {
      return {
        errCode: 1,
        errMessage: "Complaint not found",
      };
    }

    return {
      errCode: 0,
      user,
    };
  }
  static async editPaymentInformation(
    momo: string,
    bankAccount: string,
    bankAccountName: string,
    subBankAccount: string,
    subBankAccountName: string
  ) {
    const paymentInformationRepository =
      AppDataSource.getRepository(PaymentInformation);

    const existingPaymentInformation =
      await paymentInformationRepository.findOne({
        where: { id: 1 },
      });

    if (!existingPaymentInformation) {
      return {
        errCode: 1,
        errMessage: "Payment information not found",
      };
    }

    existingPaymentInformation.momo = momo;
    existingPaymentInformation.bankAccount = bankAccount;
    existingPaymentInformation.bankAccountName = bankAccountName;
    existingPaymentInformation.subBankAccount = subBankAccount;
    existingPaymentInformation.subBankAccountName = subBankAccountName;

    await paymentInformationRepository.save(existingPaymentInformation);

    return {
      errCode: 0,
      errMessage: "Payment information updated successfully",
      paymentInformation: existingPaymentInformation,
    };
  }
}
