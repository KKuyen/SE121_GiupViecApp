import express from "express";
const adminRouter = express.Router();
import { auth, checkPermission } from "../middleware/auth";

import { AdminController } from "../controllers/admin2.controller";
adminRouter.all("*", auth, checkPermission);
adminRouter.get("/api/v1/get-all-users", AdminController.getAllUsers);
adminRouter.get("/api/v1/get-a-user", AdminController.getAUser);
adminRouter.put("/api/v1/edit-user", AdminController.editUser);
adminRouter.delete("/api/v1/delete-user", AdminController.deleteUser);
adminRouter.get("/api/v1/get-all-vouchers", AdminController.getAllVouchers);
adminRouter.post("/api/v1/add-voucher", AdminController.addVoucher);
adminRouter.put("/api/v1/edit-voucher", AdminController.editVoucher);
adminRouter.delete("/api/v1/delete-voucher", AdminController.deleteVoucher);
adminRouter.get("/api/v1/get-all-activities", AdminController.getAllActivities);

export default adminRouter;
