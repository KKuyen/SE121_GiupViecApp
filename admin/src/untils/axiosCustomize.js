import axios from "axios";

const instance = axios.create({
  baseURL: "http://localhost:8080/",
  timeout: 1000000,
  headers: {
    "Content-Type": "application/json; charset=utf-8",
  },
});

// Add a request interceptor
instance.interceptors.request.use(
  function (config) {
    // Do something before request is sent
    // Temporary solution for token (Neu chua lam login thi vao postman call API login de lay token roi quang no vao localStorage voi key la: 'token')
    // const token = localStorage.getItem("jwt");
    // if (token) {
    //   console.log("token", token);


    // }
    return config;
  },
  function (error) {
    // Do something with request error
    return Promise.reject(error);
  }
);

// Add a response interceptor
instance.interceptors.response.use(
  function (response) {
    // Any status code that lie within the range of 2xx cause this function to trigger
    // Do something with response data
    return response.data;
  },
  function (error) {
    // Any status codes that falls outside the range of 2xx cause this function to trigger
    // Do something with response error
    console.log("API error", error);
    return Promise.reject(error);
  }
);
export default instance;
