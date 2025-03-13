import express from "express";
const admin1Router = express.Router();
import { auth, checkPermission } from "../middleware/auth";
import { Admin1Controller } from "./../controllers/admin1.controller";

admin1Router.all("*", auth, checkPermission);
admin1Router.post(
  "/api/v1/create-new-task-type",
  Admin1Controller.createNewTaskType
);

admin1Router.delete(
  "/api/v1/delete-task-type",
  Admin1Controller.deleteTaskType
);
admin1Router.delete(
  "/api/v1/delete-add-price-detail",
  Admin1Controller.deleteAAddPriceDetail
);
admin1Router.post(
  "/api/v1/create-add-price-detail",
  Admin1Controller.createAAddPriceDetails
);
admin1Router.put("/api/v1/edit-task-type", Admin1Controller.editTaskType);
admin1Router.put(
  "/api/v1/edit-add-price-detail",
  Admin1Controller.editAddPrice
);
admin1Router.post(
  "/api/v1/get-payment-information",
  Admin1Controller.getPaymentInformation
);
admin1Router.post("/api/v1/get-payment", Admin1Controller.getIncome);
admin1Router.post("/api/v1/get-complaints", Admin1Controller.getComplaints);
admin1Router.post("/api/v1/get-a-complaint", Admin1Controller.getAComplaint);
admin1Router.post("/api/v1/get-a-user", Admin1Controller.getUserById);
admin1Router.put(
  "/api/v1/edit-payment-information",
  Admin1Controller.editPaymentInformation
);
admin1Router.post(
  "/api/v1/get-complaints-by-userId",
  Admin1Controller.getReportByUserId
);
export default admin1Router;
