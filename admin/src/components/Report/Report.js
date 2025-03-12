import React, { useEffect, useState } from "react";
import { Table, Input, Row, Space, Select } from "antd";
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

const statusOptions = ["Pending", "Approval"];
const typeOptions = ["Type A", "Type B", "Type C", "Type D"];

const Report = () => {
  const [data, setData] = useState([]);
  const [filteredData, setFilteredData] = useState([]);
  const [searchText, setSearchText] = useState("");
  const [selectedStatus, setSelectedStatus] = useState(null);
  const [selectedType, setSelectedType] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await getComplaints();
        setData(response.complaints);
        setFilteredData(response.complaints);
      } catch (error) {
        console.error("Failed to fetch complaints:", error);
      }
    };
    fetchData();
  }, []);

  useEffect(() => {
    let filtered = data;
    if (searchText) {
      filtered = filtered.filter(
        (item) =>
          item.description.toLowerCase().includes(searchText.toLowerCase()) ||
          item.type.toLowerCase().includes(searchText.toLowerCase()) ||
          item.id.toString().includes(searchText) ||
          item.taskId.toString().includes(searchText)
      );
    }
    if (selectedStatus) {
      filtered = filtered.filter((item) => item.status === selectedStatus);
    }
    if (selectedType) {
      filtered = filtered.filter((item) => item.type === selectedType);
    }
    setFilteredData(filtered);
  }, [searchText, selectedStatus, selectedType, data]);

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
        <Search
          placeholder="Tìm kiếm ID, mô tả, loại, TaskID"
          allowClear
          style={{ width: 400 }}
          onChange={(e) => setSearchText(e.target.value)}
          prefix={<SearchOutlined />}
        />
        <Row>
          <Select
            placeholder="Chọn trạng thái"
            allowClear
            style={{ width: 200, marginRight: 20 }}
            onChange={(value) => setSelectedStatus(value)}
          >
            {statusOptions.map((status) => (
              <Option key={status} value={status}>
                {status}
              </Option>
            ))}
          </Select>

          <Select
            placeholder="Chọn loại"
            allowClear
            style={{ width: 200 }}
            onChange={(value) => setSelectedType(value)}
          >
            {typeOptions.map((type) => (
              <Option key={type} value={type}>
                {type}
              </Option>
            ))}
          </Select>
        </Row>
      </Space>
      <Table
        columns={columns}
        dataSource={filteredData}
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
