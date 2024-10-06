require("dotenv").config();
import jwt from "jsonwebtoken";

export const createJWT = (payload:{}):string => {
  let key = process.env.JWT_SECRET;
  let token = "";
  try {
    token = jwt.sign(payload, key!);
  } catch (error) {
    console.log(error);
  }
  return token;
};

export const verifyJWT = (token:string) => {
  let key = process.env.JWT_SECRET;
  let decoded = null;
  decoded = jwt.verify(token, key!);
  return decoded;
};
