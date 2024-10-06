import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
import { User } from "../entity/User.entity";
import {UserService} from "../services/user.service";
// import { encrypt } from "../helpers/encrypt";
// import * as cache from "memory-cache";

export class UserController {
  static async signup(req: Request, res: Response) {
    const { name, email, password, role } = req.body;
    if (!name || !email || !password || !role) { 
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

    let message=await UserService.createUser(user);
    res
      .status(200)
      .json(message);
  }
 
  static async updateUser(req: Request, res: Response) {
    try {
        const { id } = req.params;
        const { name, email } = req.body;
        const userRepository = AppDataSource.getRepository(User);
        const user = await userRepository.findOne({
        where: { id: parseInt(id, 10) },
        });
        user!.name = name;
        user!.email = email;
        await userRepository.save(user!);
         res.status(200).json({ message: "udpdate", user });
    } catch (error) {
         res.status(400).json({ message: "error" });
    }
  }

  static async deleteUser(req: Request, res: Response) {
        const { id } = req.params;
        const userRepository = AppDataSource.getRepository(User);
        const user = await userRepository.findOne({
        where: { id: parseInt(id, 10) },
        });
        await userRepository.remove(user!);
        res.status(200).json({ message: "ok" });
  }
  static async getUsers(req: Request, res: Response) {
        console.log("serving from db");
      const userRepository = AppDataSource.getRepository(User);
      const users = await userRepository.find();

     // cache.put("data", users, 6000);
      res.status(200).json({
        data: users,
      });
    //const data = cache.get("data");
    // if (data) {
    //   console.log("serving from cache");
    //   return res.status(200).json({
    //     data,
    //   });
    // } else {
      
    //}
  }
}