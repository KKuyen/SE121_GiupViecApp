import express from 'express';
const taskerRouter = express.Router();
import { auth, checkPermission } from "../middleware/auth";
import { TaskerController } from "../controllers/tasker.controller";

taskerRouter.all("*", auth, checkPermission);
taskerRouter.get("/api/v1/get-all-tasks", TaskerController.handleGetAllTasks);
taskerRouter.get("/api/v1/get-tasker-profile", TaskerController.handleGetTaskerProfile);
taskerRouter.put("/api/v1/edit-tasker-profile", TaskerController.handleEditTaskerProfile);
taskerRouter.get("/api/v1/get-all-reviews", TaskerController.handleGetAllReviews);


export default taskerRouter;