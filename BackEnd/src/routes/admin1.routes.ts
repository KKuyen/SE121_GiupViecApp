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
export default admin1Router;
