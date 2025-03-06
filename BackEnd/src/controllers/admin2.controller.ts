import { Request, Response } from "express";
import { User } from "../entity/User.entity";
import { AdminService } from "../services/admin2.service";


export class AdminController {
  static async getAllUsers(req: Request, res: Response) {
    try {
      const users = await AdminService.getAllUsers();
      res.status(200).send(users);
    } catch (error) {
      console.log(error);
      res.status(500).send("Internal server error");
    }
  }
  static async getAUser(req: Request, res: Response) {
    const { id } = req.query;
    if (id === undefined || id === null) {
         console.log(id);
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    try {
      const user = await AdminService.getAUser(parseInt(id as string));
      res.status(200).send(user);
    } catch (error) {
      console.log(error);
      res.status(500).send("Internal server error");
    }
  }
  static async editUser(req: Request, res: Response) {
    const { id} = req.body;
    if (!id) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    try {
      const user = await AdminService.editUser(req.body);
      res.status(200).send(user);
    } catch (error) {
      console.log(error);
      res.status(500).send("Internal server error");
    }
  }
  static async deleteUser(req: Request, res: Response) {
    const { id } = req.query;
    if (!id) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    try {
      const user = await AdminService.deleteUser(parseInt(id as string));
      res.status(200).send(user);
    } catch (error) {
      console.log(error);
      res.status(500).send("Internal server error");
    }
  }
  static async getAllVouchers(req: Request, res: Response) {
    try {
      const vouchers = await AdminService.getAllVouchers();
      res.status(200).send(vouchers);
    } catch (error) {
      console.log(error);
      res.status(500).send("Internal server error");
    }
  }
  static async addVoucher(req: Request, res: Response) {
    try {
      const { image, content, header, applyTasks,RpointCost,value, isInfinity,quantity, startDate,endDate} = req.body;
      if (!image || !content || !header || !applyTasks || !RpointCost || !value ||  !quantity || !startDate || !endDate) {
        res.status(500).json({
          errCode: 1,
          message: "Missing required fields",
        });
      }
      const vouchers = await AdminService.addVoucher(req.body);
      res.status(200).send(vouchers);
    } catch (error) {
      console.log(error);
      res.status(500).send("Internal server error");
    }
  }
  static async editVoucher(req: Request, res: Response) {
    try {
      const { image, content, header, applyTasks,RpointCost,value, isInfinity,quantity, startDate,endDate} = req.body;
      const vouchers = await AdminService.editVoucher(req.body);
      res.status(200).send(vouchers);
    } catch (error) {
      console.log(error);
      res.status(500).send("Internal server error");
    }
  }
  static async deleteVoucher(req: Request, res: Response) {
    const { id } = req.query;
    if (!id) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    try {
      const vouchers = await AdminService.deleteVoucher(parseInt(id as string));
      res.status(200).send(vouchers);
    } catch (error) {
      console.log(error);
      res.status(500).send("Internal server error");
    }
  }
  static async getAllActivities(req: Request, res: Response) {
    try {
      const activities = await AdminService.getAllActivities();
      res.status(200).send(activities);
    } catch (error) {
      console.log(error);
      res.status(500).send("Internal server error");
    }
  }

}
