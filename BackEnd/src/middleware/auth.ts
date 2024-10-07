import { verifyJWT } from "./JWTAction";
import { Request, Response,NextFunction } from "express";
const nonSecurePaths = ["/api/v1/login", "/api/v1/register"];
const userPaths:string[] = ["/api/v1/hello"];
const taskerPaths:string[] = ["/api/v1/get-tasker-profile","/api/v1/edit-tasker-profile","/api/v1/get-all-reviews"];
const commonPaths:string[] = [];

export const auth = (req:Request, res:Response, next:NextFunction):void => {
  if (nonSecurePaths.includes(req.path)) {
    return next();
  }
  if (req?.headers?.authorization?.split(" ")[1]) {
    const token = req.headers.authorization.split(" ")[1];
    console.log(">>>Token:", token);
    try {
      //verify token
      const decoded:any = verifyJWT(token);
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
export const checkPermission = (req:Request, res:Response, next:NextFunction):void => {
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

declare module 'express-serve-static-core' {
  interface Request {
    user?: {
      phoneNumber: string;
      userId: string;
      role: string;
    };
  }
}