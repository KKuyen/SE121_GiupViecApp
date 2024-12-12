import { User } from "../entity/User.entity";
import { In } from "typeorm";
import { TaskerInfo } from "../entity/TaskerInfo.entity";
import { AppDataSource } from "../data-source";
import { Reviews } from "../entity/Review.entity";
import { Location } from "../entity/Location.entity";
import { Tasks } from "../entity/Task.entity";
import { TaskerList } from "../entity/TaskerList.entity";
import { BlockList } from "net";
import { BlockTaskers } from "../entity/BlockTasket.entity";
import { LoveTaskers } from "../entity/LoveTasker.entity";
import { UserSettings } from "../entity/UserSetting.entity";

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
          resolve({ errCode: 1, message: "Không tìm thấy người giúp việc" });
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
          resolve({ errCode: 1, message: "Không tìm thấy người giúp việc" });
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
          resolve({ errCode: 1, message: "Không tìm thấy địa chỉ" });
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
          resolve({ errCode: 1, message: "Không tìm thấy địa chỉ" });
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

        // Fetch task IDs for the tasker with status "S1"
        const taskerList = await taskerListRepository.find({
          where: { taskerId: taskerId, status: "S2" },
        });

        // Extract task IDs from the tasker list
        const taskIds = taskerList.map((tasker) => tasker.taskId);

        // If taskIds is empty, return an empty array directly
        if (taskIds.length === 0) {
          return resolve({
            errCode: 0,
            taskerList: [],
          });
        }

        const taskRepository = AppDataSource.getRepository(Tasks);

        // Query tasks with the specified task IDs
        const tasks = await taskRepository
          .createQueryBuilder("task")
          .leftJoinAndSelect("task.location", "location")
          .leftJoinAndSelect("task.user", "user")
          .leftJoinAndSelect("task.taskType", "taskType")
          .leftJoinAndSelect("task.taskerLists", "taskerLists")
          .orderBy("task.createdAt", "DESC")
          .where("task.id IN (:...taskIds)", { taskIds })
          .select([
            "task.id",
            "task.userId",
            "task.taskTypeId",
            "task.time",
            "task.locationId",
            "task.note",
            "task.isReTaskChildren",
            "task.taskStatus",
            "task.createdAt",
            "task.updatedAt",
            "task.price",
            "task.approvedAt",
            "task.cancelAt",
            "task.finishedAt",
            "task.cancelReason",
            "task.numberOfTasker",

            "user.id",
            "user.name",
            "user.email",
            "user.phoneNumber",
            "user.role",
            "user.avatar",
            "user.birthday",
            "user.Rpoints",

            "location.id",
            "location.country",
            "location.province",
            "location.district",
            "location.ownerName",
            "location.ownerPhoneNumber",
            "location.detailAddress",
            "location.map",

            "taskType.id",
            "taskType.name",
            "taskType.avatar",

            "taskerLists.id",
            "taskerLists.status",
          ])
          .getMany();

        // Return tasks result if taskIds were found
        resolve({
          errCode: 0,
          taskerList: tasks,
        });
      } catch (e) {
        reject(e);
      }
    });
  };
  static getApplyTask = async (taskerId: number) => {
    return new Promise(async (resolve, reject) => {
      try {
        const taskerListRepository = AppDataSource.getRepository(TaskerList);

        // Fetch task IDs for the tasker with status "S1"
        const taskerList = await taskerListRepository.find({
          where: { taskerId: taskerId, status: "S1" },
        });

        // Extract task IDs from the tasker list
        const taskIds = taskerList.map((tasker) => tasker.taskId);

        // If taskIds is empty, return an empty array directly
        if (taskIds.length === 0) {
          return resolve({
            errCode: 0,
            taskerList: [],
          });
        }

        const taskRepository = AppDataSource.getRepository(Tasks);

        // Query tasks with the specified task IDs
        const tasks = await taskRepository
          .createQueryBuilder("task")
          .leftJoinAndSelect("task.location", "location")
          .leftJoinAndSelect("task.user", "user")
          .leftJoinAndSelect("task.taskType", "taskType")
          .leftJoinAndSelect("task.taskerLists", "taskerLists")
          .orderBy("task.createdAt", "DESC")
          .where("task.id IN (:...taskIds)", { taskIds })
          .select([
            "task.id",
            "task.userId",
            "task.taskTypeId",
            "task.time",
            "task.locationId",
            "task.note",
            "task.isReTaskChildren",
            "task.taskStatus",
            "task.createdAt",
            "task.updatedAt",
            "task.price",
            "task.approvedAt",
            "task.cancelAt",
            "task.finishedAt",
            "task.cancelReason",
            "task.numberOfTasker",

            "user.id",
            "user.name",
            "user.email",
            "user.phoneNumber",
            "user.role",
            "user.avatar",
            "user.birthday",
            "user.Rpoints",

            "location.id",
            "location.country",
            "location.province",
            "location.district",
            "location.ownerName",
            "location.ownerPhoneNumber",
            "location.detailAddress",
            "location.map",

            "taskType.id",
            "taskType.name",
            "taskType.avatar",

            "taskerLists.id",
            "taskerLists.status",
          ])
          .getMany();

        // Return tasks result if taskIds were found
        resolve({
          errCode: 0,
          taskerList: tasks,
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

        // Fetch task IDs for the tasker with status "S1"
        const taskerList = await taskerListRepository.find({
          where: { taskerId: taskerId, status: "S5" },
        });

        // Extract task IDs from the tasker list
        const taskIds = taskerList.map((tasker) => tasker.taskId);

        // If taskIds is empty, return an empty array directly
        if (taskIds.length === 0) {
          return resolve({
            errCode: 0,
            taskerList: [],
          });
        }

        const taskRepository = AppDataSource.getRepository(Tasks);

        // Query tasks with the specified task IDs
        const tasks = await taskRepository
          .createQueryBuilder("task")
          .leftJoinAndSelect("task.location", "location")
          .leftJoinAndSelect("task.user", "user")
          .leftJoinAndSelect("task.taskType", "taskType")
          .leftJoinAndSelect("task.taskerLists", "taskerLists")
          .orderBy("task.createdAt", "DESC")
          .where("task.id IN (:...taskIds)", { taskIds })
          .select([
            "task.id",
            "task.userId",
            "task.taskTypeId",
            "task.time",
            "task.locationId",
            "task.note",
            "task.isReTaskChildren",
            "task.taskStatus",
            "task.createdAt",
            "task.updatedAt",
            "task.price",
            "task.approvedAt",
            "task.cancelAt",
            "task.finishedAt",
            "task.cancelReason",
            "task.numberOfTasker",

            "user.id",
            "user.name",
            "user.email",
            "user.phoneNumber",
            "user.role",
            "user.avatar",
            "user.birthday",
            "user.Rpoints",

            "location.id",
            "location.country",
            "location.province",
            "location.district",
            "location.ownerName",
            "location.ownerPhoneNumber",
            "location.detailAddress",
            "location.map",

            "taskType.id",
            "taskType.name",
            "taskType.avatar",

            "taskerLists.id",
            "taskerLists.status",
          ])
          .getMany();

        // Return tasks result if taskIds were found
        resolve({
          errCode: 0,
          taskerList: tasks,
        });
      } catch (e) {
        reject(e);
      }
    });
  };
  static getAllTask = async (
    taskerId: number,
    fromDate: Date | null,
    toDate: Date | null,
    taskTypes: any | null
  ) => {
    return new Promise(async (resolve, reject) => {
      try {
        const taskeRepository = AppDataSource.getRepository(Tasks);
        const tasksQuery = taskeRepository
          .createQueryBuilder("task")
          .leftJoinAndSelect("task.location", "location")
          .leftJoinAndSelect("task.user", "user")
          .leftJoinAndSelect("task.taskType", "taskType")
          .leftJoinAndSelect("task.taskerLists", "taskerLists")
          .orderBy("task.createdAt", "DESC")
          .select([
            "task.id",
            "task.userId",
            "task.taskTypeId",
            "task.time",
            "task.locationId",
            "task.note",
            "task.isReTaskChildren",
            "task.taskStatus",
            "task.createdAt",
            "task.updatedAt",
            "task.price",
            "task.approvedAt",
            "task.cancelAt",
            "task.finishedAt",
            "task.cancelReason",
            "task.numberOfTasker",
            "user.id",
            "user.name",
            "user.email",
            "user.phoneNumber",
            "user.role",
            "user.avatar",
            "user.birthday",
            "user.Rpoints",
            "location.id",
            "location.country",
            "location.province",
            "location.district",
            "location.ownerName",
            "location.ownerPhoneNumber",
            "location.detailAddress",
            "location.map",
            "taskType.id",
            "taskType.name",
            "taskType.avatar",
            "taskerLists.id",
            "taskerLists.status",
          ])
          .where("(task.taskStatus = 'TS1' AND task.time > CURRENT_TIMESTAMP)");

        if (fromDate) {
          tasksQuery.andWhere("task.time > :fromDate", { fromDate });
        }
        if (toDate) {
          tasksQuery.andWhere("task.time < :toDate", { toDate });
        }
        if (taskTypes) {
          tasksQuery.andWhere("task.taskTypeId IN (:...taskTypes)", {
            taskTypes,
          });
        }

        let tasks = await tasksQuery.getMany();
        const blockListRepository = AppDataSource.getRepository(BlockTaskers);
        const blockList = await blockListRepository.find({
          where: { taskerId: taskerId },
        });

        const blockedUserIds = blockList.map((block) => block.userId);

        tasks = tasks.filter((task) => !blockedUserIds.includes(task.userId));
        const taskerListRepository = AppDataSource.getRepository(TaskerList);
        const taskerLists = await taskerListRepository.find({
          where: { taskerId: taskerId },
        });
        const taskerListWithTasks = taskerLists.map((taskerList) => {
          const taskIndex = tasks.findIndex(
            (task) => task.id === taskerList.taskId
          );

          if (taskIndex !== -1) {
            const task = tasks[taskIndex];
            tasks.splice(taskIndex, 1); // Xóa task khỏi mảng tasks
          }
        });

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
          resolve({ errCode: 1, message: "Bạn đã ứng cử công việc này!" });
        }
        const taskerListNew = new TaskerList();
        taskerListNew.taskerId = taskerId;
        taskerListNew.taskId = taskId;
        taskerListNew.status = "S1";
        const taskRepository = AppDataSource.getRepository(Tasks);
        const task = await taskRepository.findOne({
          where: { id: taskId },
        });
        if (!task) {
          return resolve({ errCode: 1, message: "Không tìm thấy công việc" });
        }
        const userSettingRepository = AppDataSource.getRepository(UserSettings);
        const userSetting = await userSettingRepository.findOne({
          where: { userId: task.userId },
        });
        // tim so sao trb
        const reviewsRepository = AppDataSource.getRepository(Reviews);
        const reviews = await reviewsRepository.find({
          where: { taskerId: taskerId },
        });

        const totalStars = reviews.reduce(
          (sum, review) => sum + review.star,
          0
        );
        const averageStars =
          reviews.length > 0 ? totalStars / reviews.length : 0;
        //autoaccept
        if (userSetting?.autoAcceptStatus === true) {
          const loveTaskersRepository =
            AppDataSource.getRepository(LoveTaskers);
          const loveTasker = await loveTaskersRepository.findOne({
            where: { userId: task.userId, taskerId: taskerId },
          });

          if (loveTasker && userSetting.loveTaskerOnly === true) {
            taskerListNew.status = "S2";
          }
          if (
            userSetting.loveTaskerOnly === false &&
            userSetting.upperStar >= averageStars
          ) {
            taskerListNew.status = "S2";
          }
        }
        await taskerListRepository.save(taskerListNew);

        const taskerListCount = await taskerListRepository.count({
          where: { taskId: taskId, status: "S2" },
        });
        if (taskerListCount === task.numberOfTasker) {
          task.taskStatus = "TS2";
          await taskRepository.save(task);
          task.approvedAt = new Date();
        }

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
          resolve({ errCode: 1, message: "Không tìm thấy địa chỉ" });
        }
      } catch (e) {
        reject(e);
      }
    });
  };
}
