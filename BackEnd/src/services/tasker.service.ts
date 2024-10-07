import { User } from "../entity/User.entity";
import { TaskerInfo } from "../entity/TaskerInfo.entity";
import { AppDataSource } from "../data-source";
import { Reviews } from "../entity/Review.entity";


export class TaskerService {
    static getTaskerProfile = async (taskerId: number) => {
        return new Promise(async (resolve, reject) => {
            try {
                const taskerRepository = AppDataSource.getRepository(User);
                // const tasker = await taskerRepository.findOne({
                //     select: ["id", "name", "email","phoneNumber","role","avatar","taskerInfo","birthday"],
                //     where: { id: taskerId },
                //     relations: ["taskerInfo"],

                // });
                const tasker = await taskerRepository
                .createQueryBuilder("user")
                .leftJoinAndSelect("user.taskerInfo", "taskerInfo")
                .select([
                    "user.id",
                    "user.name",
                    "user.email",
                    "user.phoneNumber",
                    "user.role",
                    "user.avatar",
                    "user.birthday",
                    // Chỉ chọn các trường cần thiết từ taskerInfo
                    "taskerInfo.totalStar", // Ví dụ về các trường cần thiết từ taskerInfo
                    "taskerInfo.totalReviews",
                    "taskerInfo.introduction",
                    "taskerInfo.taskList"

                ])
                .where("user.id = :taskerId", { taskerId })
                .getOne();
                if (tasker) {
                    resolve({ errCode: 0, tasker: tasker });
                } else {
                    resolve({ errCode: 1, message: "Tasker not found" });
                }
            } catch (e) {
                reject(e);
            }
        });
 
    };
    static editTaskerProfile = async (data: any) => { 
        return new Promise(async (resolve, reject) => {
            try {
                const taskerInfoRepository = AppDataSource.getRepository(TaskerInfo);
                const taskerRepository = AppDataSource.getRepository(User);
                const tasker = await taskerRepository.findOne({
                    where: { id: data["taskerId"] },
                    relations: ["taskerInfo"],
                });
                if (tasker) {
                    tasker.name = data["name"];
                    tasker.email = data["email"];
                    tasker.phoneNumber = data["phoneNumber"];
                    tasker.avatar = data["avatar"];

                    if (tasker.taskerInfo) {
                        tasker.taskerInfo.introduction = data["introduction"];
                        tasker.taskerInfo.taskList = data["taskList"];
                        await taskerInfoRepository.save(tasker.taskerInfo); // Lưu đối tượng taskerInfo
                    }

                    await taskerRepository.save(tasker); // Lưu đối tượng tasker
                    resolve({ errCode: 0, message: "Ok" });

                } else {
                    resolve({ errCode: 1, message: "Tasker not found" });

                }
            } catch (e) {
                reject(e);
            }
        });

    }
    static getAllReviews = async (taskerId: string) => {
        return new Promise(async (resolve, reject) => {
            try {
                const reviewsRepository = AppDataSource.getRepository(Reviews);
                let reviews;
                if (taskerId === "all") {
                    reviews = await reviewsRepository
                        .createQueryBuilder("reviews")
                        .leftJoinAndSelect("reviews.task", "task")
                        .leftJoinAndSelect("task.taskType", "taskType")
                        .select([
                            "reviews.id",
                            "reviews.star",
                            "reviews.content",
                            "reviews.image1",
                            "reviews.image2",
                            "reviews.image3",
                            "reviews.image4",
                            "reviews.createdAt",
                            "taskType.name as taskTypeName",
                        ])
                        .getMany();
                }
                else { 
                    let id = parseInt(taskerId, 10);
                    reviews = await reviewsRepository
                        .createQueryBuilder("reviews")
                        .leftJoinAndSelect("reviews.task", "task")
                        .leftJoinAndSelect("task.taskType", "taskType")
                        .where("reviews.taskerId = :taskerId", { taskerId: id })
                        .select([
                            "reviews.id",
                            "reviews.star",
                            "reviews.content",
                            "reviews.image1",
                            "reviews.image2",
                            "reviews.image3",
                            "reviews.image4",
                            "reviews.createdAt",
                            "task.id",
                            "taskType.name",
                        ])
                        .getMany();
                }
                resolve({ errCode: 0, reviews: reviews });
                
            } catch (e) {
                reject(e);
            }
        });
    }
    
    
}