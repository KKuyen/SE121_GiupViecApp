import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
import { User } from "../entity/User.entity";
import {UserService} from "../services/user.service";
// import { encrypt } from "../helpers/encrypt";
// import * as cache from "memory-cache";
interface OtpDetails {
  otp: string;
  expiresAt: Date;
}
const otps: { [key: string]: OtpDetails } = {}; 
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
  static async sendOTP(req: Request, res: Response) { 
    const { phoneNumber } = req.body;
    if (!phoneNumber) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    const otp = Math.floor(100000 + Math.random() * 900000).toString(); // Tạo OTP ngẫu nhiên
    const expiresAt = new Date(Date.now() + 5 * 60 * 1000); // OTP hết hạn sau 5 phút
    const message = await UserService.sendOTP(phoneNumber,otp);
    otps[phoneNumber] = { otp, expiresAt };
    res.status(200).json({
      errCode: 0,
      message: message,
    });
  }
  static async verifyOTP(req: Request, res: Response) { 
    const { phoneNumber, otp } = req.body;
    const otpDetails = otps[phoneNumber];
    if (!otpDetails) {
        res.status(400).json({ message: 'OTP not found for this phone number' });
    }
    else {
        const { otp: actualOtp, expiresAt } = otpDetails;
        if (new Date() > expiresAt) {
          res.status(400).json({ message: 'OTP has expired' });
        }
        else {
          const message = await UserService.verifyOtp(otp, actualOtp);
          res.status(200).json({
            errCode: 0,
            message: message,
          });
        }
        
      }
      
    
  }
  static async forgetPassword(req: Request, res: Response) {
    const { newPassword, phoneNumber } = req.body;
    if (!newPassword || !phoneNumber) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    else {
      const message = await UserService.forgetPassword(newPassword, phoneNumber);
      res.status(200).json(message);
    }
  }
  static async changePassword(req: Request, res: Response) {
    const { userId, oldPassword, newPassword } = req.body;
    if (!userId || !oldPassword || !newPassword) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    else {
      const message = await UserService.changePassword(userId, oldPassword, newPassword);
      res.status(200).json(message);
    }
   
  }

 
  
}