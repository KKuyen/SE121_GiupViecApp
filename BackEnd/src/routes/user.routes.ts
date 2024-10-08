import express from "express";
const userRouter = express.Router();
import { auth, checkPermission } from "../middleware/auth";

import { UserController } from "../controllers/user.controller";
userRouter.all("*", auth, checkPermission);
userRouter.get("/api/v1/hello", UserController.handleHelloWorld);
userRouter.post("/api/v1/register", UserController.signup);
userRouter.post("/api/v1/login", UserController.login);
userRouter.post("/api/v1/create-new-task", UserController.createNewTask);
userRouter.put("/api/v1/edit-a-task", UserController.editTask);
userRouter.get("/api/v1/get-all-tasks", UserController.getAllTasks);
userRouter.get("/api/v1/get-all-voucher", UserController.getAllVoucher);
userRouter.get("/api/v1/get-my-voucher", UserController.getMyVoucher);
userRouter.get("/api/v1/get-all-task-type", UserController.getAllTaskType);
userRouter.get("/api/v1/get-tasker-list", UserController.getTaskerList);
userRouter.post("/api/v1/add-new-love-tasker", UserController.addNewLoveTasker);
userRouter.post(
  "/api/v1/add-new-block-tasker",
  UserController.addNewBlockTasker
);

userRouter.get("/api/v1/get-love-tasker", UserController.getLoveTaskerList);
userRouter.get("/api/v1/get-block-tasker", UserController.getBlockTaskerList);
userRouter.delete(
  "/api/v1/delete-a-love-tasker",
  UserController.deleteLoveTasker
);
userRouter.delete(
  "/api/v1/delete-a-block-tasker",
  UserController.deleteBlockTasker
);
userRouter.post("/api/v1/review", UserController.review);
userRouter.get("/api/v1/get-a-task", UserController.getATask);
userRouter.get("/api/v1/get-tasker-info", UserController.getTaskerInfo);
userRouter.get("/api/v1/edit-setting", UserController.editSetting);
userRouter.post("/api/v1/claim-voucher", UserController.claimVoucher);
userRouter.get(
  "/api/v1/get-avaiable-voucher",
  UserController.getAvailableVoucher
);
userRouter.post("/api/v1/push-image", UserController.uploadImage);
export default userRouter;
