import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
import { User } from "../entity/User.entity";
import { UserService } from "../services/user.service";
import { Tasks } from "../entity/Task.entity";
import { getStorage, ref, uploadBytesResumable } from "firebase/storage";
import { signInWithEmailAndPassword } from "firebase/auth";
import * as admin from "firebase-admin";

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
    const { name, email, phoneNumber, password, role } = req.body;
    if (!name || !phoneNumber || !password) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    const user = new User();
    user.name = name;
    user.email = email;
    user.password = password;
    user.role = role;
    user.phoneNumber = phoneNumber;

    let message = await UserService.createUser(user);
    res.status(200).json(message);
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
    const message = await UserService.sendOTP(phoneNumber, otp);
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
      res.status(400).json({ message: "OTP not found for this phone number" });
    } else {
      const { otp: actualOtp, expiresAt } = otpDetails;
      if (new Date() > expiresAt) {
        res.status(400).json({ message: "OTP has expired" });
      } else {
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
    } else {
      const message = await UserService.forgetPassword(
        newPassword,
        phoneNumber
      );
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
    } else {
      const message = await UserService.changePassword(
        userId,
        oldPassword,
        newPassword
      );
      res.status(200).json(message);
    }
  }
  static async createNewTask(req: Request, res: Response) {
    const {
      userId,
      taskTypeId,
      time,
      addPriceDetail,
      locationId,
      note,
      isReTaskChildren,
      voucherId,
      myVoucherId,
    } = req.body;
    if (
      userId === undefined ||
      taskTypeId === undefined ||
      time === undefined ||
      locationId === undefined ||
      note === undefined ||
      isReTaskChildren === undefined ||
      addPriceDetail === undefined
    ) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    } else {
      let message: any = await UserService.createTask(
        userId,
        taskTypeId,
        time,
        addPriceDetail,
        locationId,
        note,
        isReTaskChildren,
        voucherId,
        myVoucherId
      );
      res
        .status(200)
        .json({ errCode: message.errCode, message: message.message });
    }
  }
  static async editTask(req: Request, res: Response) {
    const { taskId, time, addPriceDetail, locationId, note, taskStatus } =
      req.body;

    let message: any = await UserService.editTask(
      taskId,
      time,
      addPriceDetail,
      locationId,
      note,
      taskStatus
    );
    if (taskId === undefined) {
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
  static async getAllTasks(req: Request, res: Response) {
    const { userId } = req.body;
    if (userId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.getAllTasks(userId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
      taskList: message.tasklist,
    });
  }
  static async getAllVoucher(req: Request, res: Response) {
    let message = await UserService.getAllVoucher();
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
      voucherList: message.voucherList,
    });
  }
  static async getMyVoucher(req: Request, res: Response) {
    const { userId } = req.body;
    if (userId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.getMyVoucher(userId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
      voucherList: message.voucherList,
    });
  }
  static async getAllTaskType(req: Request, res: Response) {
    let message = await UserService.getAllTaskType();
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
      taskTypeList: message.taskTypeList,
    });
  }
  static async getTaskerList(req: Request, res: Response) {
    const { taskId } = req.body;
    if (taskId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.getTaskerList(taskId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
      taskerList: message.taskerList,
    });
  }
  static async addNewLoveTasker(req: Request, res: Response) {
    const { userId, taskerId } = req.body;
    if (userId === undefined || taskerId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.addNewLoveTasker(userId, taskerId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
  static async addNewBlockTasker(req: Request, res: Response) {
    const { userId, taskerId } = req.body;
    if (userId === undefined || taskerId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.addNewBlockTasker(userId, taskerId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
  static async getLoveTaskerList(req: Request, res: Response) {
    const { userId } = req.body;
    if (userId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.getLoveTaskerList(userId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
      loveList: message.loveList,
    });
  }
  static async getBlockTaskerList(req: Request, res: Response) {
    const { userId } = req.body;
    if (userId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.getBlockTaskerList(userId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
      blockList: message.blockList,
    });
  }
  static async deleteLoveTasker(req: Request, res: Response) {
    const { userId, taskerId } = req.body;
    if (userId === undefined || taskerId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.deleteLoveTasker(userId, taskerId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
  static async deleteBlockTasker(req: Request, res: Response) {
    const { userId, taskerId } = req.body;
    if (userId === undefined || taskerId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.deleteBlockTasker(userId, taskerId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
  static async review(req: Request, res: Response) {
    const { taskId, taskerId, star, content, imageArray } = req.body;
    if (
      taskId === undefined ||
      taskerId === undefined ||
      star === undefined ||
      content === undefined
    ) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.review(
      taskId,
      taskerId,
      star,
      content,
      imageArray
    );
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
  static async getATask(req: Request, res: Response) {
    const { taskId } = req.body;
    if (taskId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.getATask(taskId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
      task: message.task,
    });
  }
  static async getTaskerInfo(req: Request, res: Response) {
    const { taskerId, userId } = req.body;
    if (taskerId === undefined || userId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }

    let message = await UserService.getTaskerInfo(taskerId, userId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
      tasker: message.tasker,
      taskerInfo: message.taskerInfo,
      reviewList: message.reviewList,
      isLove: message.loveTasker,
      isBlock: message.blockTasker,
    });
  }
  static async editSetting(req: Request, res: Response) {
    const { userId, autoAcceptStatus, loveTaskerOnly, upperStar } = req.body;
    if (userId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }

    let message = await UserService.editSetting(
      userId,
      autoAcceptStatus,
      loveTaskerOnly,
      upperStar
    );
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
  static async claimVoucher(req: Request, res: Response) {
    const { userId, voucherId } = req.body;
    if (userId === undefined || voucherId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }

    let message = await UserService.claimVoucher(userId, voucherId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
  static async getAvailableVoucher(req: Request, res: Response) {
    const { userId, taskTypeId } = req.body;
    if (userId === undefined || taskTypeId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.getAvailableVoucher(userId, taskTypeId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
      availableVouchers: message.availableVouchers,
    });
  }
  static async uploadImage(req: Request, res: Response): Promise<void> {
    try {
      const { quantity, file } = req.body; // Expecting 'single' or 'multiple' in the request body
      let imageUrl;

      if (quantity === "single") {
        imageUrl = await UserService.uploadImage(file, "single");
      } else if (quantity === "multiple") {
        imageUrl = await UserService.uploadImage(file, "multiple");
      } else {
        res.status(400).send({ message: "Invalid quantity" });
      }

      res.status(200).send({ imageUrl });
    } catch (error) {}
  }
  static async edittkls(req: Request, res: Response) {
    const { taskId, taskerId, status } = req.body;
    if (
      taskId === undefined ||
      taskerId === undefined ||
      status === undefined
    ) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.edittkls(taskId, taskerId, status);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
  static async deleteAccount(req: Request, res: Response) {
    const { userId } = req.body;
    if (userId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.deleteAccount(userId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
  static async cancelTask(req: Request, res: Response) {
    const { taskId, cancelCode } = req.body;
    if (taskId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.cancelTask(taskId, cancelCode);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
  static async finishTask(req: Request, res: Response) {
    const { taskId } = req.body;
    if (taskId === undefined) {
      res.status(500).json({
        errCode: 1,
        message: "Missing required fields",
      });
    }
    let message = await UserService.finishTask(taskId);
    res.status(200).json({
      errCode: message.errCode,
      message: message.errMessage,
    });
  }
}
