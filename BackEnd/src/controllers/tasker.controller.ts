import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
import { User } from "../entity/User.entity";
import { Location } from "../entity/Location.entity";

import { TaskerService } from "../services/tasker.service";
// import { encrypt } from "../helpers/encrypt";
// import * as cache from "memory-cache";

export class TaskerController {
  static async handleGetTaskerProfile(req: Request, res: Response) {
    const taskerId = parseInt(req.query.taskerId as string, 10);
    if (!taskerId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    } else {
      let message = await TaskerService.getTaskerProfile(taskerId);
      res.status(200).json(message);
    }
  }
  static async handleEditTaskerProfile(req: Request, res: Response) {
    const {
      taskerId,
      name,
      email,
      phoneNumber,
      avatar,
      introduction,
      taskList,
    } = req.body;
    if (!taskerId || !name || !email || !phoneNumber || !avatar) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await TaskerService.editTaskerProfile(req.body);
    res.status(200).json(message);
  }
  static async handleGetAllReviews(req: Request, res: Response) {
    let taskerId: any = req.query.taskerId;
    if (!taskerId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await TaskerService.getAllReviews(taskerId);
    res.status(200).json(message);
  }
  static async handleGetMyLocation(req: Request, res: Response) {
    let userId: any = req.query.userId;
    if (!userId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await TaskerService.getMyLocation(userId);
    res.status(200).json(message);
  }
  static async handleAddNewLocation(req: Request, res: Response) {
    const {
      ownerName,
      ownerPhoneNumber,
      country,
      province,
      district,
      detailAddress,
      map,
      userId,
      isDefault,
    } = req.body;
    console.log(req.body);
    if (!country || !province || !district || !detailAddress || !userId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
      return;
    }
    let location: Location = new Location();
    location.ownerName = ownerName ? ownerName : null;
    location.ownerPhoneNumber = ownerPhoneNumber ? ownerPhoneNumber : null;
    location.country = country;
    location.province = province;
    location.district = district;
    location.detailAddress = detailAddress;
    location.map = map ? map : null;
    location.userId = userId;
    location.isDefault = isDefault;

    let message = await TaskerService.addNewLocation(location);
    res.status(200).json(message);
  }
  static async handleEditMyLocation(req: Request, res: Response) {
    const {
      id,
      ownerName,
      ownerPhoneNumber,
      country,
      province,
      district,
      detailAddress,
      map,
      userId,
      isDefault,
    } = req.body;
    if (
      !id ||
      !country ||
      !province ||
      !district ||
      !detailAddress ||
      !userId ||
      !isDefault
    ) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let location: Location = new Location();
    location.id = id;
    location.ownerName = ownerName ? ownerName : null;
    location.ownerPhoneNumber = ownerPhoneNumber ? ownerPhoneNumber : null;
    location.country = country;
    location.province = province;
    location.district = district;
    location.detailAddress = detailAddress;
    location.map = map ? map : null;
    location.userId = userId;
    location.isDefault = isDefault;

    let message = await TaskerService.editLocation(location);
    res.status(200).json(message);
  }
  static async handleDeleteMyLocation(req: Request, res: Response) {
    let id: any = req.query.id;
    if (!id) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await TaskerService.deleteLocation(id);
    res.status(200).json(message);
  }
  static async handleGetAllTasks(req: Request, res: Response) {
    const { taskerId, fromDate, toDate, taskTypes } = req.body;
    if (taskerId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }

    let message = await TaskerService.getAllTask(
      taskerId,
      fromDate,
      toDate,
      taskTypes
    );
    res.status(200).json(message);
  }
  static async handleGetMyTask(req: Request, res: Response) {
    let taskerId: any = req.query.taskerId;
    if (!taskerId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await TaskerService.getMyTask(taskerId);
    res.status(200).json(message);
  }
  static async handelGetApplyTask(req: Request, res: Response) {
    let taskerId: any = req.query.taskerId;
    if (!taskerId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await TaskerService.getApplyTask(taskerId);
    res.status(200).json(message);
  }
  static async handleGetMyTaskHistory(req: Request, res: Response) {
    let taskerId: any = req.query.taskerId;
    if (!taskerId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await TaskerService.getMyHistoryTask(taskerId);
    res.status(200).json(message);
  }
  static async handleApplyTask(req: Request, res: Response) {
    let taskerId: any = req.query.taskerId;
    let taskId: any = req.query.taskId;
    if (!taskerId || !taskId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await TaskerService.applyTask(taskerId, taskId);
    res.status(200).json(message);
  }
  static async handleCancelTask(req: Request, res: Response) {
    let taskerId: any = req.query.taskerId;
    let taskId: any = req.query.taskId;
    if (!taskerId || !taskId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await TaskerService.cancelTask(taskerId, taskId);
    res.status(200).json(message);
  }
  static async handleGetMyDefaultLocation(req: Request, res: Response) {
    let userId: any = req.query.userId;
    if (!userId) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await TaskerService.getMyDefaultLocation(userId);
    res.status(200).json(message);
  }
}
