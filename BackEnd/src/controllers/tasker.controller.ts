import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
import { User } from "../entity/User.entity";
import {TaskerService} from "../services/tasker.service";
// import { encrypt } from "../helpers/encrypt";
// import * as cache from "memory-cache";

export class TaskerController {
  static async handleGetAllTasks(req: Request, res: Response) {
    // const { phoneNumber, password } = req.body;
    // if (!phoneNumber || !password) {
    //   res.status(500).json({
    //     errCode: 1,
    //     message: "Missing required fields",
    //   });
    // }
    // //let userData: any = await UserService.loginUser(phoneNumber, password);
    
    // res.status(200).json({
    //     errCode: userData.errCode,
    //     message: userData.errMessage,
    //     user: userData.user ? userData.user : {},
    //     access_token: userData.access_token ? userData.access_token : {},
    // });
  }
 
  
 
  
}