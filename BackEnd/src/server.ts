import express from 'express';
import { AppDataSource } from "./data-source"
import { Request, Response } from "express";
import bodyParser from 'body-parser';
import userRouter from "./routes/user.routes";
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;
app.use(bodyParser.json());
app.use("/", userRouter);
app.get("*", (req: Request, res: Response) => {
  res.status(505).json({ message: "Bad Request" });
});

AppDataSource.initialize().then(async () => {
  app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
}).catch(error => console.log(error))



