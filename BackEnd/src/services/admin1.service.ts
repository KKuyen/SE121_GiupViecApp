import { AddPriceDetails } from "./../entity/AddPriceDetails.entity";
import * as dotenv from "dotenv";
require("dotenv").config();
import { AppDataSource } from "../data-source"; // Adjust the path as necessary
import { TaskTypes } from "../entity/TaskTypes.entity";
import { PaymentInformation } from "../entity/PaymentInfomation.entity";

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
}
