import { User } from "../entity/User.entity";
import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
export class UserService {
    static async createUser(user: User) {
        const userRepository = AppDataSource.getRepository(User);
        await userRepository.save(user); 
        return {errCode: 0, message: "Ok"};
    }
   
}