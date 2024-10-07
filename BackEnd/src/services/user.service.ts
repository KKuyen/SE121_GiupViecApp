import { User } from "../entity/User.entity";
import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
import bcrypt from "bcryptjs";
const salt = bcrypt.genSaltSync(10);
import { createJWT, verifyJWT } from "../middleware/JWTAction";

export class UserService {
    static checkUserPhone = async (phoneNumber: string) => {
        return new Promise<boolean>(async (resolve, reject) => {
            try {
                const userRepository = AppDataSource.getRepository(User);
                const user = await userRepository.findOne({
                    where: { phoneNumber: phoneNumber },
                });
                if (user) resolve(true);
                else resolve(false);
            } catch (e) {
                reject(e);
            }
        });
 
    };
    static hashUserPassword = (password:string) => {
        return new Promise<string>(async (resolve, reject) => {
            try {
                let hashPassword = await bcrypt.hashSync(password, salt);
                resolve(hashPassword);
            } catch (error) {
                reject(error);
            }
        });
    };
    static createUser = async (user: User) => {
        return new Promise(async (resolve, reject) => {
            try {
                if (await UserService.checkUserPhone(user.phoneNumber)) {
                     resolve ({ errCode: 1, message: "Phone number already exists" });
                }
                else {
                    const userRepository = AppDataSource.getRepository(User);
                    user.password = await UserService.hashUserPassword(user.password);
                    await userRepository.save(user); 
                    resolve ({errCode: 0, message: "Ok"});
                }
            }
            catch (error) {
                reject(error);
            }
        });
           
       
    }
    static loginUser = async (phoneNumber: string, password: string) => {
        return new Promise(async (resolve, reject) => {
            try {
                let userData:any = {};
                let checkUserPhone = await UserService.checkUserPhone(phoneNumber);
                if (checkUserPhone) {
                    let userRepository = AppDataSource.getRepository(User);
                    let user = await userRepository.findOne({
                        select: ["id", "name", "email","password","phoneNumber","role","avatar","taskerInfo","birthday","Rpoints"],
                        where: { phoneNumber: phoneNumber },
                    });
                    if (user) {
                        if (bcrypt.compareSync(password, user.password)) {
                            userData.errCode = 0;
                            userData.errMessage = "OK";
                            userData.user = user;
                            delete  userData.user.password;
                            let payload = {
                            userId: user.id,
                            phoneNumber: user.phoneNumber,
                            role: user.role,
                            expiresIn: process.env.JWT_EXPIRES_IN,
                            };
                            userData.access_token = await createJWT(payload);
                        }
                        else {
                            userData.errCode = 3;
                            userData.errMessage =
                            "Your password is incorrect. Please try again!";
                        }
                    }
                    else {
                        userData.errCode = 2;
                        userData.errMessage =
                        "Your phone number isn`t exist in system. Please try again!";
                    }
                }
                else {
                        userData.errCode = 2;
                        userData.errMessage =
                        "Your phone number isn`t exist in system. Please try again!";
                }
                resolve(userData);
            } catch (error) {
                reject(error);
            }
        });
    };
   
}