import { Routes, Route, Navigate } from "react-router-dom";
import Home from "./components/Home/Home";
import App from "./App";
import Activities from "./components/Activities/Activities";
import Finance from "./components/Finance/Finance";
import Report from "./components/Report/Report";
import Service from "./components/Services/Service";
import Vouchers from "./components/Vouchers/Vouchers";
const Layout = () => {
  return (
    <>
      <Routes>
        <Route path="/" element={<App />}>
          <Route index element={<Home />} />
          <Route path="home" element={<Home />} />
          <Route path="activities" element={<Activities />} />
          <Route path="finance" element={<Finance />} />
          <Route path="report" element={<Report />} />
          <Route path="services" element={<Service />} />
          <Route path="vouchers" element={<Vouchers />} />
        </Route>
      </Routes>
    </>
  );
};

export default Layout;
