import { User } from "../entity/User.entity";
import { TaskerInfo } from "../entity/TaskerInfo.entity";
import { AppDataSource } from "../data-source";
import { Reviews } from "../entity/Review.entity";
import { Location } from "../entity/Location.entity";
import { Tasks } from "../entity/Task.entity";
import { TaskerList } from "../entity/TaskerList.entity";

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
            "taskerInfo.taskList",
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
  };
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
        } else {
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
  };
  static getMyLocation = async (userId: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const locationRepository = AppDataSource.getRepository(Location);
        let locations;
        locations = await locationRepository.find({
          where: { userId: userId },
        });

        resolve({ errCode: 0, locations: locations });
      } catch (e) {
        reject(e);
      }
    });
  };
  static addNewLocation = async (location: Location) => {
    return new Promise(async (resolve, reject) => {
      try {
        const locationRepository = AppDataSource.getRepository(Location);
        if (location.isDefault) {
          const locationDefault = await locationRepository.findOne({
            where: { userId: location.userId, isDefault: true },
          });
          if (locationDefault) {
            locationDefault.isDefault = false;
            await locationRepository.save(locationDefault);
          }
        }
        await locationRepository.save(location);
        resolve({ errCode: 0, message: "Ok" });
      } catch (error) {
        reject(error);
      }
    });
  };
  static editLocation = async (location: Location) => {
    return new Promise(async (resolve, reject) => {
      try {
        const locationRepository = AppDataSource.getRepository(Location);
        const locationInDb = await locationRepository.findOne({
          where: { id: location.id },
        });
        if (locationInDb) {
          locationInDb.ownerName = location.ownerName;
          locationInDb.ownerPhoneNumber = location.ownerPhoneNumber;
          locationInDb.country = location.country;
          locationInDb.province = location.province;
          locationInDb.district = location.district;
          locationInDb.detailAddress = location.detailAddress;
          locationInDb.map = location.map;
          locationInDb.userId = location.userId;
          locationInDb.isDefault = location.isDefault;
          await locationRepository.save(locationInDb);
          resolve({ errCode: 0, message: "Ok" });
        } else {
          resolve({ errCode: 1, message: "Location not found" });
        }
      } catch (e) {
        reject(e);
      }
    });
  };
  static deleteLocation = async (id: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const locationRepository = AppDataSource.getRepository(Location);
        const location = await locationRepository.findOne({
          where: { id: id },
        });
        if (location) {
          await locationRepository.remove(location);
          resolve({ errCode: 0, message: "Ok" });
        } else {
          resolve({ errCode: 1, message: "Location not found" });
        }
      } catch (e) {
        reject(e);
      }
    });
  };
  static getMyTask = async (taskerId: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const taskerListRepository = AppDataSource.getRepository(TaskerList);
        const taskerList = await taskerListRepository
          .createQueryBuilder("taskerList")
          .leftJoinAndSelect("taskerList.task", "task")
          .leftJoinAndSelect("task.taskType", "taskType")
          .leftJoinAndSelect("task.location", "location")
          .select([
            "taskerList.id",
            "task.id",
            "task.userId",
            "task.taskTypeId",
            "task.time",
            "task.locationId",
            "task.note",
            "task.taskStatus",
            "task.approvedAt",
            "task.cancelAt",
            "task.cancelReason",
            "task.finishedAt",
            "task.numberOfTasker",
            "task.price",
            "taskType.name",
            "location.country",
            "location.province",
            "location.district",
            "location.detailAddress",
            "location.map",
            "location.ownerName",
            "location.ownerPhoneNumber",
          ])
          .where(
            "(taskerList.status = 'S1' OR taskerList.status = 'S2' )AND taskerList.taskerId= :taskerId",
            { taskerId: taskerId }
          )
          .getMany();

        resolve({
          errCode: 0,
          taskerList: taskerList,
        });
      } catch (e) {
        reject(e);
      }
    });
  };
  static getMyHistoryTask = async (taskerId: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const taskerListRepository = AppDataSource.getRepository(TaskerList);
        const taskerList = await taskerListRepository
          .createQueryBuilder("taskerList")
          .leftJoinAndSelect("taskerList.task", "task")
          .leftJoinAndSelect("task.taskType", "taskType")
          .leftJoinAndSelect("task.location", "location")
          .select([
            "taskerList.id",
            "task.id",
            "task.userId",
            "task.taskTypeId",
            "task.time",
            "task.locationId",
            "task.note",
            "task.taskStatus",
            "task.approvedAt",
            "task.cancelAt",
            "task.cancelReason",
            "task.finishedAt",
            "task.numberOfTasker",
            "task.price",
            "taskType.name",
            "location.country",
            "location.province",
            "location.district",
            "location.detailAddress",
            "location.map",
            "location.ownerName",
            "location.ownerPhoneNumber",
          ])
          .where(
            "(taskerList.status = 'S3' OR taskerList.status = 'S4' OR taskerList.status = 'S5' )AND taskerList.taskerId= :taskerId",
            { taskerId: taskerId }
          )
          .getMany();

        resolve({
          errCode: 0,
          errMessage: "OK",
          taskerList: taskerList,
        });
      } catch (e) {
        reject(e);
      }
    });
  };
  static getAllTask = async () => {
    return new Promise(async (resolve, reject) => {
      try {
        const taskeRepository = AppDataSource.getRepository(Tasks);
        const tasks = await taskeRepository
          .createQueryBuilder("task")
          .leftJoinAndSelect("task.taskType", "taskType")
          .leftJoinAndSelect("task.location", "location")
          .select([
            "task.id",
            "task.userId",
            "task.taskTypeId",
            "task.time",
            "task.locationId",
            "task.note",
            "task.taskStatus",
            "task.approvedAt",
            "task.cancelAt",
            "task.cancelReason",
            "task.finishedAt",
            "task.numberOfTasker",
            "task.price",
            "taskType.name",
            "location.country",
            "location.province",
            "location.district",
            "location.detailAddress",
            "location.map",
            "location.ownerName",
            "location.ownerPhoneNumber",
          ])
          .where("(task.taskStatus = 'TS1' AND task.time > CURRENT_TIMESTAMP)")
          .getMany();

        resolve({
          errCode: 0,
          errMessage: "OK",
          taskerList: tasks,
        });
      } catch (e) {
        reject(e);
      }
    });
  };
  static applyTask = async (taskerId: number, taskId: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const taskerListRepository = AppDataSource.getRepository(TaskerList);
        const taskerList = await taskerListRepository.findOne({
          where: { taskerId: taskerId, taskId: taskId },
        });
        if (taskerList) {
          resolve({ errCode: 1, message: "Tasker already applied" });
        }
        const taskerListNew = new TaskerList();
        taskerListNew.taskerId = taskerId;
        taskerListNew.taskId = taskId;
        taskerListNew.status = "S1";
        await taskerListRepository.save(taskerListNew);
        resolve({ errCode: 0, message: "Ok" });
      } catch (e) {
        reject(e);
      }
    });
  };
  static cancelTask = async (taskerId: number, taskId: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const taskerListRepository = AppDataSource.getRepository(TaskerList);
        const taskerList = await taskerListRepository.findOne({
          where: { taskerId: taskerId, taskId: taskId },
        });
        taskerList!.status = "S3";
        await taskerListRepository.save(taskerList!);
        const taskRepository = AppDataSource.getRepository(Tasks);
        const task = await taskRepository.findOne({
          where: { id: taskId },
        });
        if (task?.taskStatus === "TS2") {
          task.taskStatus = "TS1";
          await taskRepository.save(task);
        }
        resolve({ errCode: 0, message: "Ok" });
      } catch (e) {
        reject(e);
      }
    });
  };
  static getMyDefaultLocation = async (userId: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const locationRepository = AppDataSource.getRepository(Location);
        const location = await locationRepository.findOne({
          where: { userId: userId, isDefault: true },
        });
        if (location) {
          resolve({ errCode: 0, location: location });
        } else {
          resolve({ errCode: 1, message: "Location not found" });
        }
      } catch (e) {
        reject(e);
      }
    });
  }
}
