import React, { useState } from "react";
import { Table, Input, Button, Dropdown, Menu, Space, Select } from "antd";
import { SearchOutlined, FilterOutlined } from "@ant-design/icons";
import { useNavigate } from "react-router-dom";

const { Search } = Input;
const { Option } = Select;

const columns = [
  { title: "ID", dataIndex: "id", key: "id" },
  { title: "TaskID", dataIndex: "taskId", key: "taskId" },
  { title: "CustomerID", dataIndex: "customerId", key: "customerId" },
  { title: "TaskerId", dataIndex: "taskerId", key: "taskerId" },
  { title: "Type", dataIndex: "type", key: "type" },
  { title: "Description", dataIndex: "description", key: "description" },
  { title: "Status", dataIndex: "status", key: "status" },
];

const data = [
  {
    id: 1,
    taskId: "T001",
    customerId: "C001",
    taskerId: "TK001",
    type: "Cleaning",
    description: "House cleaning",
    status: "Pending",
  },
  {
    id: 2,
    taskId: "T002",
    customerId: "C002",
    taskerId: "TK002",
    type: "Cooking",
    description: "Meal preparation",
    status: "Completed",
  },
  {
    id: 3,
    taskId: "T003",
    customerId: "C003",
    taskerId: "TK003",
    type: "Laundry",
    description: "Washing clothes",
    status: "Pending",
  },
  {
    id: 4,
    taskId: "T004",
    customerId: "C004",
    taskerId: "TK004",
    type: "Babysitting",
    description: "Taking care of a child",
    status: "Completed",
  },
];

const filterMenu = (
  <Menu>
    <Menu.Item key="1">Pending</Menu.Item>
    <Menu.Item key="2">Completed</Menu.Item>
  </Menu>
);

const Report = () => {
  const [selectedCategory, setSelectedCategory] = useState("Người giúp việc");
  const navigate = useNavigate();

  const handleRowClick = (record) => {
    navigate(`/report-detail/${record.id}`);
  };

  return (
    <div style={{ padding: 20 }}>
      <Space
        style={{
          marginBottom: 16,
          display: "flex",
          justifyContent: "space-between",
        }}
      >
        <Search placeholder="Search" allowClear style={{ width: 300 }} />

        <Dropdown overlay={filterMenu} trigger={["click"]}>
          <Button icon={<FilterOutlined />}>Filter</Button>
        </Dropdown>
      </Space>
      <Table
        columns={columns}
        dataSource={data}
        pagination={{ pageSize: 10, position: ["bottomCenter"] }}
        onRow={(record) => {
          return {
            onClick: () => handleRowClick(record),
          };
        }}
      />
    </div>
  );
};

export default Report;
