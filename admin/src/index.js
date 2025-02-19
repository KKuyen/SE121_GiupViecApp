import React from "react";
import ReactDOM from "react-dom/client";

import App from "./App";
import Layout from "./layout";
import { BrowserRouter } from "react-router";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(
  <BrowserRouter>
    <Layout />
  </BrowserRouter>
);
