import React, { useEffect, useState } from "react";
import { Table, Input, Button, Dropdown, Menu, Space, Select } from "antd";
import { SearchOutlined, FilterOutlined } from "@ant-design/icons";
import { useNavigate } from "react-router-dom";
import { getComplaints } from "../../services/admnService";

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

const filterMenu = (
  <Menu>
    <Menu.Item key="1">Pending</Menu.Item>
    <Menu.Item key="2">Completed</Menu.Item>
  </Menu>
);

const Report = () => {
  const [data, setData] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState("Người giúp việc");
  const navigate = useNavigate();

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await getComplaints();
        setData(response.complaints);
      } catch (error) {
        console.error("Failed to fetch complaints:", error);
      }
    };

    fetchData();
  }, []);

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
