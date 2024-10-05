import express from 'express';
import { AppDataSource } from "./data-source"
import { Request, Response } from "express";
import bodyParser from 'body-parser';
import userRouter from "./routes/user.routes";
import { movieRouter } from "./routes/movie.routes";
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;
app.use(bodyParser.json());
app.use("/user", userRouter);
app.use("/movie", movieRouter);
app.get("*", (req: Request, res: Response) => {
  res.status(505).json({ message: "Bad Request" });
});

AppDataSource.initialize().then(async () => {
    // const user = new User()
    // user.firstName = "Timber"
    // user.lastName = "Saw"
    // user.age = 25
    // await AppDataSource.manager.save(user)
  // const users = await AppDataSource.manager.find(User)
  app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
}).catch(error => console.log(error))



