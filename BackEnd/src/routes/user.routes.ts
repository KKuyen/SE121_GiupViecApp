import express from 'express';
const userRouter = express.Router();
import { UserController } from "../controllers/user.controller";

userRouter.post("/register", UserController.signup);
userRouter.put(
  "/update/:id",
  UserController.updateUser
);
userRouter.get(
  "/users",
  UserController.getUsers
);
userRouter.delete(
  "/delete/:id",
  UserController.deleteUser
);
export default userRouter;