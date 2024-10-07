import { User } from "../entity/User.entity";
import { AppDataSource } from "../data-source";
import bcrypt from "bcryptjs";
const salt = bcrypt.genSaltSync(10);

export class TaskerService {
    static checkUserPhone = async (phoneNumber: string) => {
        return new Promise<boolean>(async (resolve, reject) => {
            try {
               
            } catch (e) {
                reject(e);
            }
        });
 
    };
    
    
    
}