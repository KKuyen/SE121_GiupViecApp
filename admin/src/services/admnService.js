import axios from "../untils/axiosCustomize";

export const getAllTaskTypes = () => {
  return axios.post("api/v1/get-all-task-type");
};
export const deleteATaskType = (id) => {
  return axios.delete(`api/v1/delete-task-type?taskTypeId=${id}`);
};
export const addNewTaskType = (data) => {
  return axios.post("api/v1/create-new-task-type", data);
};
export const getATaskType = (data) => {
  return axios.post(`api/v1/get-a-task-type`, data);
};
export const updateService = (data) => {
  return axios.put("api/v1/edit-task-type", data);
};
export const addAddPriceDetail = (data) => {
  return axios.post("api/v1/create-add-price-detail", data);
};
export const deleteAddPriceDetail = (id) => {
  return axios.delete(`api/v1/delete-add-price-detail?addPriceDetailId=${id}`);
};
export const editAddPriceDetail = (data) => {
  return axios.put("api/v1/edit-add-price-detail", data);
};
export const getPaymentInfor = () => {
  return axios.post("api/v1/get-payment-information");
};
export const getIncome = (month, year) => {
  return axios.post(`api/v1/get-payment?month=${month}&year=${year}`);
};
export const getComplaints = () => {
  return axios.post("api/v1/get-complaints");
};
export const getAcomplaint = (id) => {
  return axios.post(`api/v1/get-a-complaint?complaintId=${id}`);
};
export const getUser = (id) => {
  return axios.post("api/v1/get-a-user?userId=" + id);
};
export const editPaymentInformation = (data) => {
  return axios.put("api/v1/edit-payment-information", data);
};
