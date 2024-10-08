import express from 'express';
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


export default userRouter;