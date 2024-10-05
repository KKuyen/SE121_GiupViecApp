import express from "express";
import bodyParser from "body-parser";
import initWebRoutes from "./routes/web";
require("dotenv").config();

let app = express();
app.use(bodyParser.json({ limit: "50mb" }));
app.use(bodyParser.urlencoded({ limit: "50mb", extended: true }));

initWebRoutes(app);

let port = process.env.PORT || 8080;
app.listen(port, () => {
  console.log(`App is running at the port ${port}`);
});
