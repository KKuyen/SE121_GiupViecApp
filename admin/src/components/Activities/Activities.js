import { DeleteOutlined, EditOutlined } from "@ant-design/icons";
import { Popconfirm, Space, Table, Tag } from "antd";
import React, { useEffect, useState } from "react";
import axios from "../../untils/axiosCustomize";

const historyColumns = [
  {
    title: "Tên công việc",
    dataIndex: "taskName",
    key: "taskName",
  },
  {
    title: "Ngày đặt",
    dataIndex: "createdAt",
    key: "createdAt",
  },
  {
    title: "Địa chỉ",
    dataIndex: "map",
    key: "map",
  },
  {
    title: "Số người làm",
    dataIndex: "numberOfTasker",
    key: "numberOfTasker",
  },
  {
    title: "Trạng thái",
    key: "taskStatus",
    dataIndex: "taskStatus",
    render: (_, { taskStatus }) => {
      let color = "";
      let text = "";
      switch (taskStatus) {
        case "TS1":
          color = "blue";
          text = "Đang đặt";
          break;
        case "TS2":
          color = "green";
          text = "Đã đặt";
          break;
        case "TS3":
          color = "yellow";
          text = "Hoàn thành";
          break;
        case "TS4":
          color = "red";
          text = "Đã hủy";
          break;
        default:
          color = "gray";
          text = "Không xác định";
      }
      return (
        <Tag color={color} key={taskStatus}>
          {text}
        </Tag>
      );
    },
  },
  {
    title: "Action",
    key: "action",
    render: (_, record) => (
      console.log("record", record),
      (
        <Space size="middle">
          <EditOutlined />
          <Popconfirm
            title="Xóa công việc"
            description="Bạn có chắc chắn muốn xóa công việc này không?"
            onConfirm={confirmDeleteTask}
            okText="Xóa"
            cancelText="Hủy"
          >
            <DeleteOutlined style={{ color: "#ff4d4f" }} />
          </Popconfirm>
        </Space>
      )
    ),
  },
];
const confirmDeleteTask = (e) => {
  console.log("e", e);
  // Call API
};
export default function Activities() {
  const [tasks, setTasks] = useState([]);
  useEffect(() => {
    // Call API

    axios.get("/api/v1/get-all-activities").then((res) => {
      console.log("res", res.taskList);
      res.activities.map((task) => {
        const temp = {
          key: task?._id,
          taskName: task?.taskType?.name,
          createdAt: task?.createdAt?.substring(0, 10),
          map:
            task?.location?.detailAddress +
            ", " +
            task?.location?.district +
            ", " +
            task?.location?.province,
          numberOfTasker: task?.numberOfTasker,
          taskStatus: task?.taskStatus,
        };
        setTasks((tasks) => [...tasks, temp]);
      });
      //setTasks(res.tasks);
    });
  }, []);
  return (
    <div>
      <Table
        columns={historyColumns}
        pagination={{
          position: ["bottomCenter"],
          pageSize: 7,
        }}
        dataSource={tasks}
      />
    </div>
  );
}
