import express from 'express';
import { AppDataSource } from "./data-source"
import { Request, Response } from "express";
import bodyParser from 'body-parser';
import userRouter from "./routes/user.routes";
import taskerRouter from "./routes/tasker.routes";
require('dotenv').config();
import session from 'express-session';

const app = express();
const port = process.env.PORT || 3000;
app.use(bodyParser.json());
app.use("/", userRouter);
app.use("/", taskerRouter);
app.use(session({
  secret: 'your_secret_key',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false }, // Để `secure: true` khi chạy HTTPS
}));
app.get("*", (req: Request, res: Response) => {
  res.status(505).json({ message: "Bad Request" });
});

AppDataSource.initialize().then(async () => {
  app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
}).catch(error => console.log(error))



