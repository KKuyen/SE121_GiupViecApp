import express from 'express';
const taskerRouter = express.Router();
import { auth, checkPermission } from "../middleware/auth";
import { TaskerController } from "../controllers/tasker.controller";

taskerRouter.all("*", auth, checkPermission);
taskerRouter.get("/api/v1/get-all-tasks",TaskerController.handleGetAllTasks);

export default taskerRouter;