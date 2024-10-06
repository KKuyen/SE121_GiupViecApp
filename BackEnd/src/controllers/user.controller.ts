import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
import { User } from "../entity/User.entity";
import {UserService} from "../services/user.service";
// import { encrypt } from "../helpers/encrypt";
// import * as cache from "memory-cache";

export class UserController {
  static async handleHelloWorld(req: Request, res: Response) {
    res.status(200).json({ message: "Hello World" });
  }
  static async signup(req: Request, res: Response) {
    const { name, email,phoneNumber, password, role } = req.body;
    if (!name || !phoneNumber || !password ) { 
       res
        .status(500)
        .json({
          errCode: 1,
          message: "Missing required fields"
        });
    }
    const user = new User();
    user.name = name;
    user.email = email;
    user.password = password;
    user.role = role;
    user.phoneNumber = phoneNumber;

    let message=await UserService.createUser(user);
    res
      .status(200)
      .json(message);
  }
  static async login(req: Request, res: Response) {
    const { phoneNumber, password } = req.body;
    if (!phoneNumber || !password) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let userData: any = await UserService.loginUser(phoneNumber, password);
    
    res.status(200).json({
        errCode: userData.errCode,
        message: userData.errMessage,
        user: userData.user ? userData.user : {},
        access_token: userData.access_token ? userData.access_token : {},
    });
  }
 
  
}