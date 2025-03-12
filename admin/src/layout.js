import { Routes, Route, Navigate } from "react-router-dom";
import Home from "./components/Home/Home";
import App from "./App";
import Activities from "./components/Activities/Activities";
import Finance from "./components/Finance/Finance";
import Report from "./components/Report/Report";
import Service from "./components/Services/Service";
import Vouchers from "./components/Vouchers/Vouchers";
import AddNewService from "./components/Services/AddNewService";
import ReportDetail from "./components/Report/ReportDetail";

import EditService from "./components/Services/EditService";

import ViewDetail from "./components/Home/ViewDetail";

const Layout = () => {
  return (
    <>
      <Routes>
        <Route path="/" element={<App />}>
          <Route index element={<Home />} />
          <Route path="home" element={<Home />} />
          <Route path="view-detail" element={<ViewDetail />} />
          <Route path="activities" element={<Activities />} />
          <Route path="finance" element={<Finance />} />
          <Route path="report" element={<Report />} />
          <Route path="services" element={<Service />} />
          <Route path="vouchers" element={<Vouchers />} />
          <Route path="add-new-service" element={<AddNewService />} />
          <Route path="report-detail/*" element={<ReportDetail />} />
          <Route path="report-detail" element={<ReportDetail />} />
          <Route path="edit-service/:id" element={<EditService />} />
        </Route>
      </Routes>
    </>
  );
};

export default Layout;
