import { Request, Response } from "express";

import { Admin1Service } from "../services/admin1.service";

export class Admin1Controller {
  static async createNewTaskType(req: Request, res: Response) {
    const {
      name,
      avatar,
      description,
      image,
      value,
      originalPrice,
      addPriceDetails,
    } = req.body;
    if (!name || !description || !originalPrice || !value) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    } else {
      let message: any = await Admin1Service.createATaskType(
        name,
        avatar,
        description,
        image,
        value,
        originalPrice,
        addPriceDetails
      );
      res
        .status(200)
        .json({ errCode: message.errCode, message: message.message });
    }
  }
  static async deleteTaskType(req: Request, res: Response) {
    const { taskTypeId } = req.query;
    if (!taskTypeId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    } else {
      let message: any = await Admin1Service.deleteTaskType(Number(taskTypeId));
      res
        .status(200)
        .json({ errCode: message.errCode, message: message.message });
    }
  }
  static async deleteAAddPriceDetail(req: Request, res: Response) {
    const { addPriceDetailId } = req.query;
    if (!addPriceDetailId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    } else {
      let message: any = await Admin1Service.deleteAddPriceDetail(
        Number(addPriceDetailId)
      );
      res
        .status(200)
        .json({ errCode: message.errCode, message: message.message });
    }
  }
  static async createAAddPriceDetails(req: Request, res: Response) {
    const {
      taskTypeId,
      name,
      value,
      stepPrice,
      beginPrice,
      stepValue,
      unit,
      beginValue,
    } = req.body;
    if (
      !taskTypeId ||
      !name ||
      !value ||
      !stepPrice ||
      !beginPrice ||
      !stepValue ||
      !unit ||
      !beginValue
    ) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    } else {
      let message: any = await Admin1Service.createAAddPriceDetail(
        taskTypeId,
        name,
        value,
        stepPrice,
        beginPrice,
        stepValue,
        unit,
        beginValue
      );
      res
        .status(200)
        .json({ errCode: message.errCode, message: message.message });
    }
  }
  static async editTaskType(req: Request, res: Response) {
    const {
      taskTypeId,
      name,
      avatar,
      description,
      image,
      value,
      originalPrice,
      addPriceDetails,
    } = req.body;

    let message: any = await Admin1Service.editTaskType(
      taskTypeId,
      name,
      avatar,
      description,
      image,
      value,
      originalPrice,
      addPriceDetails
    );
    if (taskTypeId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    } else {
      res
        .status(200)
        .json({ errCode: message.errCode, message: message.message });
    }
  }
  static async editAddPrice(req: Request, res: Response) {
    const {
      id, // ID của AddPriceDetail cần cập nhật
      taskTypeId,
      name,
      value,
      stepPrice,
      beginPrice,
      stepValue,
      unit,
      beginValue,
    } = req.body;

    let message: any = await Admin1Service.editAAddPriceDetail(
      id, // ID của AddPriceDetail cần cập nhật
      taskTypeId,
      name,
      value,
      stepPrice,
      beginPrice,
      stepValue,
      unit,
      beginValue
    );
    if (taskTypeId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    } else {
      res
        .status(200)
        .json({ errCode: message.errCode, message: message.message });
    }
  }
  static async getPaymentInformation(req: Request, res: Response) {
    let message: any = await Admin1Service.getPaymentInformation();
    res.status(200).json({
      errCode: message.errCode,
      message: message.message,
      paymentInformation: message.paymentInformation,
    });
  }
  static async getIncome(req: Request, res: Response) {
    const { month, year } = req.query;
    let message: any = await Admin1Service.getIncome(
      Number(month),
      Number(year)
    );
    res.status(200).json({
      errCode: message.errCode,
      message: message.message,
      income: message.income,
      totalIncome: message.totalIncome,
      totalTasks: message.totalTasks,
    });
  }
  static async getComplaints(req: Request, res: Response) {
    let message: any = await Admin1Service.getComplaints();
    res.status(200).json({
      errCode: message.errCode,
      message: message.message,
      complaints: message.complaints,
    });
  }
  static async getAComplaint(req: Request, res: Response) {
    const { complaintId } = req.query;
    let message: any = await Admin1Service.getAComplaint(Number(complaintId));
    res.status(200).json({
      errCode: message.errCode,
      message: message.message,
      complaint: message.complaint,
    });
  }
  static async getUserById(req: Request, res: Response) {
    const { userId } = req.query;
    let message: any = await Admin1Service.getUserById(Number(userId));
    res.status(200).json({
      errCode: message.errCode,
      message: message.message,
      user: message.user,
    });
  }
}
