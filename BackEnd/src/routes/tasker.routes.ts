import express from "express";
const taskerRouter = express.Router();
import { auth, checkPermission } from "../middleware/auth";
import { TaskerController } from "../controllers/tasker.controller";

taskerRouter.all("*", auth, checkPermission);
taskerRouter.get(
  "/api/v1/get-tasker-profile",
  TaskerController.handleGetTaskerProfile
);
taskerRouter.put(
  "/api/v1/edit-tasker-profile",
  TaskerController.handleEditTaskerProfile
);
taskerRouter.get(
  "/api/v1/get-all-reviews",
  TaskerController.handleGetAllReviews
);
taskerRouter.get(
  "/api/v1/get-my-location",
  TaskerController.handleGetMyLocation
);
taskerRouter.get(
  "/api/v1/get-my-default-location",
  TaskerController.handleGetMyDefaultLocation
);

taskerRouter.post(
  "/api/v1/add-new-location",
  TaskerController.handleAddNewLocation
);
taskerRouter.put(
  "/api/v1/edit-my-location",
  TaskerController.handleEditMyLocation
);
taskerRouter.delete(
  "/api/v1/delete-my-location",
  TaskerController.handleDeleteMyLocation
);
taskerRouter.post("/api/v1/get-find-tasks", TaskerController.handleGetAllTasks);
taskerRouter.get("/api/v1/get-my-task", TaskerController.handleGetMyTask);
taskerRouter.get(
  "/api/v1/get-my-task-history",
  TaskerController.handleGetMyTaskHistory
);
taskerRouter.post("/api/v1/apply-task", TaskerController.handleApplyTask);
taskerRouter.put("/api/v1/cancel-task", TaskerController.handleCancelTask);
taskerRouter.get(
  "/api/v1/get-apply-tasks",
  TaskerController.handelGetApplyTask
);

export default taskerRouter;
