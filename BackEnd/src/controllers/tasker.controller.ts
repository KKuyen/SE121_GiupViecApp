import { Request, Response } from "express";
import { AppDataSource } from "../data-source";
import { User } from "../entity/User.entity";
import {TaskerService} from "../services/tasker.service";
// import { encrypt } from "../helpers/encrypt";
// import * as cache from "memory-cache";

export class TaskerController {
    static async handleGetAllTasks(req: Request, res: Response) {
    
    }
    static async handleGetTaskerProfile(req: Request, res: Response) { 
        const taskerId = parseInt(req.query.taskerId as string, 10);
        if(!taskerId) {
            res.status(500).json({
                errCode: 1,
                message: "Missing required fields"
            });
        }
        else {
            let message = await TaskerService.getTaskerProfile(taskerId);
            res.status(200).json(message);
        }
       

    }
    static async handleEditTaskerProfile(req: Request, res: Response) {
        const { taskerId, name, email, phoneNumber, avatar, introduction, taskList } = req.body;
        if(!taskerId || !name || !email || !phoneNumber || !avatar ) {
            res.status(500).json({
                errCode: 1,
                message: "Missing required fields"
            });
        }
        let message = await TaskerService.editTaskerProfile(req.body);
        res.status(200).json(message);
        
        
    }
    static async handleGetAllReviews(req: Request, res: Response) { 
        let  taskerId :any = req.query.taskerId;
        if(!taskerId ) {
            res.status(500).json({
                errCode: 1,
                message: "Missing required fields"
            });
        }
        let message = await TaskerService.getAllReviews(taskerId);
        res.status(200).json(message);
    }
    
 
  
 
  
}