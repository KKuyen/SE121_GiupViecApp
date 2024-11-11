import express from "express";
const userRouter = express.Router();
import { auth, checkPermission } from "../middleware/auth";

import { UserController } from "../controllers/user.controller";
userRouter.all("*", auth, checkPermission);
userRouter.get("/api/v1/hello", UserController.handleHelloWorld);
userRouter.post("/api/v1/register", UserController.signup);
userRouter.post("/api/v1/login", UserController.login);

userRouter.post("/api/v1/send-otp", UserController.sendOTP);
userRouter.post("/api/v1/verify-otp", UserController.verifyOTP);
userRouter.put("/api/v1/forget-password", UserController.forgetPassword);
userRouter.put("/api/v1/change-password", UserController.changePassword);

userRouter.post("/api/v1/create-new-task", UserController.createNewTask);
userRouter.put("/api/v1/edit-a-task", UserController.editTask);
userRouter.post("/api/v1/get-all-tasks", UserController.getAllTasks);
userRouter.post("/api/v1/get-all-voucher", UserController.getAllVoucher);
userRouter.post("/api/v1/get-my-voucher", UserController.getMyVoucher);
userRouter.post("/api/v1/get-all-task-type", UserController.getAllTaskType);
userRouter.post("/api/v1/get-tasker-list", UserController.getTaskerList);
userRouter.post("/api/v1/add-new-love-tasker", UserController.addNewLoveTasker);
userRouter.post(
  "/api/v1/add-new-block-tasker",
  UserController.addNewBlockTasker
);

userRouter.post("/api/v1/get-love-tasker", UserController.getLoveTaskerList);
userRouter.post("/api/v1/get-block-tasker", UserController.getBlockTaskerList);
userRouter.delete(
  "/api/v1/delete-a-love-tasker",
  UserController.deleteLoveTasker
);
userRouter.delete(
  "/api/v1/delete-a-block-tasker",
  UserController.deleteBlockTasker
);
userRouter.post("/api/v1/review", UserController.review);
userRouter.post("/api/v1/get-a-task", UserController.getATask);
userRouter.post("/api/v1/get-tasker-info", UserController.getTaskerInfo);
userRouter.post("/api/v1/edit-setting", UserController.editSetting);
userRouter.post("/api/v1/claim-voucher", UserController.claimVoucher);
userRouter.post(
  "/api/v1/get-avaiable-voucher",
  UserController.getAvailableVoucher
);
userRouter.put("/api/v1/edit-tasker-list-status", UserController.edittkls);
userRouter.post("/api/v1/push-image", UserController.uploadImage);
userRouter.delete("/api/v1/delete-account", UserController.deleteAccount);
userRouter.put("/api/v1/cancel-a-task", UserController.cancelTask);
userRouter.put("/api/v1/finish-a-task", UserController.finishTask);

userRouter.put("/api/v1/edit-user-profile", UserController.editUserProfile);
userRouter.post("/api/v1/delete-my-voucher", UserController.deleteMyVoucher);

userRouter.post("/api/v1/get-all-reviews", UserController.getAllReviews);
userRouter.post("/api/v1/get-a-task-type", UserController.getATaskType);
userRouter.post("/api/v1/get-a-review", UserController.getAReviews);
userRouter.post("/api/v1/get-user-setting", UserController.getSetting);
userRouter.post("/api/v1/push-notification", UserController.pushNotification);
userRouter.post("/api/v1/get-notification", UserController.getNotification);
userRouter.post(
  "/api/v1/delete-notification",
  UserController.deleteNotification
);

export default userRouter;
