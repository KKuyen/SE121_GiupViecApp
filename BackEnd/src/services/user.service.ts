import { User } from "../entity/User.entity";
import { UserSettings } from "../entity/UserSetting.entity";
import { AppDataSource } from "../data-source";
import bcrypt from "bcryptjs";
const salt = bcrypt.genSaltSync(10);
import twilio from 'twilio';
import { createJWT, verifyJWT } from "../middleware/JWTAction";
require("dotenv").config();
const client = twilio(process.env.TWILIO_ACCOUNT_SID, process.env.TWILIO_AUTH_TOKEN);

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
                    const userSettingRepository = AppDataSource.getRepository(UserSettings);
                    let userSetting = new UserSettings();
                    userSetting.userId = user.id;
                    userSetting.autoAcceptStatus = false;
                    userSetting.loveTaskerOnly = false;
                    userSetting.upperStar = 0;
                    userSetting.nightMode = false;
                    await userSettingRepository.save(userSetting);

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
    static sendOTP = async (phoneNumber: string, otp :string) => { 
        return new Promise(async (resolve, reject) => {
            try {
                    await client.messages.create({
                    body: `Your OTP is: ${otp}`,
                    from: process.env.TWILIO_PHONE_NUMBER!,
                    to: phoneNumber,
                    });
                    resolve ({errCode: 0, message: "Ok"});
                } catch (error) {
                    reject(error);
                }
         });
    }
    static verifyOtp = async (userOtp: string, actualOtp: string) => {
        return new Promise(async (resolve, reject) => {
            try {
                if (userOtp === actualOtp) {
                    resolve({ errCode: 0, message: "Ok" });
                } else {
                    resolve({ errCode: 1, message: "Invalid OTP" });
                }
            } catch (error) {
                reject(error);
            }
        });
    };
    static forgetPassword = async (newPassword: string, phoneNumber: string) => { 
        return new Promise(async (resolve, reject) => { 
            try {
                let userRepository = AppDataSource.getRepository(User);
                let user = await userRepository.findOne({
                    where: { phoneNumber: phoneNumber },
                });
                if (user) {
                    user.password = await UserService.hashUserPassword(newPassword);
                    await userRepository.save(user);
                    resolve({ errCode: 0, message: "Ok" });
                } else {
                    resolve({ errCode: 1, message: "User not found" });
                }
            } catch (error) {
                reject(error);
            }
        });
    }
    static changePassword = async (userId: number, oldPassword: string, newPassword: string) => {
        return new Promise(async (resolve, reject) => {
            try {
                let userRepository = AppDataSource.getRepository(User);
                let user = await userRepository.findOne({
                    where: { id: userId },
                });
                if (user) {
                    if (bcrypt.compareSync(oldPassword, user.password)) {
                        user.password = await UserService.hashUserPassword(newPassword);
                        await userRepository.save(user);
                        resolve({ errCode: 0, message: "Ok" });
                    } else {
                        resolve({ errCode: 1, message: "Your old password is incorrect" });
                    }
                } else {
                    resolve({ errCode: 1, message: "User not found" });
                }
            } catch (error) {
                reject(error);
            }
        });
    };
}