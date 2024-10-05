import * as express from "express";

import { MovieController } from "../controllers/movie.controllers";

const Router = express.Router();

Router.get("/movies", MovieController.getAllMovies);
Router.post("/movies", MovieController.createMovie);

Router.put(
  "/movies/:id",
  MovieController.updateMovie
);
Router.delete(
  "/movies/:id",
  MovieController.deleteMovie
);
export { Router as movieRouter };