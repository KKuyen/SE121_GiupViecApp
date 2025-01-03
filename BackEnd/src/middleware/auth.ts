import { verifyJWT } from "./JWTAction";

import { Request, Response, NextFunction } from "express";
const nonSecurePaths = [
  "/api/v1/login",
  "/api/v1/register",
  "/api/v1/upload-and-get-link",
  ,
  "/api/v1/send-otp",
  "/api/v1/verify-otp",
  "/api/v1/forget-password",
];
const userPaths: string[] = [
  "/api/v1/hello",
  "/api/v1/create-new-task",
  "/api/v1/edit-a-task",
  "/api/v1/get-all-tasks",
  "/api/v1/get-all-voucher",
  "/api/v1/get-my-voucher",
  "/api/v1/get-all-task-type",
  "/api/v1/get-tasker-list",
  "/api/v1/add-new-love-tasker",
  "/api/v1/add-new-block-tasker",
  "/api/v1/get-love-tasker",
  "/api/v1/get-block-tasker",
  "/api/v1/delete-a-love-tasker",
  "/api/v1/delete-a-block-tasker",
  "/api/v1/review",
  "/api/v1/get-a-task",
  "/api/v1/get-tasker-info",
  "/api/v1/edit-setting",
  "/api/v1/claim-voucher",
  "/api/v1/get-avaiable-voucher",
  "/api/v1/edit-tasker-list-status",
  "/api/v1/delete-account",
  "/api/v1/cancel-a-task",

  "/api/v1/finish-a-task",
  "/api/v1/get-all-reviews",
  "/api/v1/get-a-task-type",
  "/api/v1/get-my-location",
  "/api/v1/finish-a-task",
  "/api/v1/get-my-location",
  "/api/v1/add-new-location",
  "/api/v1/edit-my-location",
  "/api/v1/delete-my-location",
  "/api/v1/change-password",
  "/api/v1/get-my-default-location",
  "/api/v1/push-notification",

  "/api/v1/edit-user-profile",
  "/api/v1/delete-my-voucher",
  "/api/v1/get-a-review",
  "/api/v1/get-user-setting",
  "/api/v1/get-notification",
  "/api/v1/delete-notification",
];
const taskerPaths: string[] = [
  "/api/v1/get-a-task",
  "/api/v1/get-a-review",
  "/api/v1/get-tasker-list",
  "/api/v1/get-all-task-type",
  "/api/v1/push-notification",
  "/api/v1/get-notification",
  "/api/v1/get-tasker-profile",
  "/api/v1/edit-tasker-profile",
  "/api/v1/get-all-reviews",
  "/api/v1/get-my-location",
  "/api/v1/add-new-location",
  "/api/v1/edit-my-location",
  "/api/v1/delete-my-location",
  "/api/v1/change-password",
  "/api/v1/get-find-tasks",
  "/api/v1/get-all-tasks",
  "/api/v1/get-my-task",
  "/api/v1/get-my-task-history",
  "/api/v1/apply-task",
  "/api/v1/cancel-task",
  "/api/v1/get-my-default-location",
  "/api/v1/get-apply-tasks",
  "/api/v1/delete-notification",
  "/api/v1/get-tasker-info",
];
const commonPaths: string[] = [];

export const auth = (req: Request, res: Response, next: NextFunction): void => {
  if (nonSecurePaths.includes(req.path)) {
    return next();
  }
  if (req?.headers?.authorization?.split(" ")[1]) {
    const token = req.headers.authorization.split(" ")[1];
    console.log(">>>Token:", token);
    try {
      //verify token
      const decoded: any = verifyJWT(token);
      console.log(">>>Decoded:", decoded);
      req.user = {
        phoneNumber: decoded.phoneNumber,
        userId: decoded.userId,
        role: decoded.role,
      };
      next();
    } catch (error) {
      res.status(401).json({ message: "Unauthorized" });
    }
  } else {
    res.status(401).json({ message: "Unauthorized" });
  }
};
export const checkPermission = (
  req: Request,
  res: Response,
  next: NextFunction
): void => {
  if (nonSecurePaths.includes(req.path)) {
    return next();
  }
  if (commonPaths.includes(req.path)) {
    return next();
  }
  if (req.user!.role === "R1" && userPaths.includes(req.path)) {
    return next();
  }
  if (req.user!.role === "R2" && taskerPaths.includes(req.path)) {
    return next();
  }
  res.status(403).json({ message: "Forbidden" });
};

declare module "express-serve-static-core" {
  interface Request {
    user?: {
      phoneNumber: string;
      userId: string;
      role: string;
    };
  }
}
