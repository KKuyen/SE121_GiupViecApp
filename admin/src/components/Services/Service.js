import React, { useState, useEffect } from "react";
import { createClient } from "@supabase/supabase-js";
import {
  Button,
  Col,
  Image,
  Input,
  Row,
  Space,
  Table,
  message,
  Popconfirm,
} from "antd";
import { EditOutlined, DeleteOutlined, DownOutlined } from "@ant-design/icons";
import { useNavigate } from "react-router-dom";
import {
  getAllTaskTypes,
  deleteATaskType,
} from "../../services/admnService.js";
import AddPrices from "./Addprices";
const supabase = createClient(
  "https://wbekftdbbgbvuybtvjoi.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndiZWtmdGRiYmdidnV5YnR2am9pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgwODgxNTEsImV4cCI6MjA0MzY2NDE1MX0.j-bv1lYpTHBiCjFjlwpXGtLqoftFZRqazzoROas6gAA"
);
const { Search } = Input;

const ExpandedRow = ({ record, isExpanded }) => (
  <div
    style={{
      maxHeight: isExpanded ? "500px" : "0px",
      opacity: isExpanded ? 1 : 0,
      overflow: "hidden",
      transition: "max-height 0.3s ease, opacity 0.3s ease",
      padding: isExpanded ? "0px 50px" : "0px",
    }}
  >
    <AddPrices prices={record.addPriceDetails} id={record.id} />
  </div>
);

const Service = () => {
  const [expandedRowKeys, setExpandedRowKeys] = useState([]);
  const [data, setData] = useState([]);
  const [filteredData, setFilteredData] = useState([]);
  const [searchText, setSearchText] = useState("");
  const navigate = useNavigate();

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await getAllTaskTypes();
        if (response.errCode === 0) {
          response.taskTypeList.forEach((taskType) => {
            taskType.image = supabase.storage
              .from("images")
              .getPublicUrl(taskType.image);
            taskType.image = taskType.image.data.publicUrl;
          });

          setData(response.taskTypeList);
          setFilteredData(response.taskTypeList);
        } else {
          message.error("Lỗi khi lấy dữ liệu từ server");
        }
      } catch (error) {
        message.error("Lỗi kết nối đến server");
      }
    };
    fetchData();
  }, []);

  const handleExpand = (record) => {
    setExpandedRowKeys((prevKeys) =>
      prevKeys.includes(record.id)
        ? prevKeys.filter((key) => key !== record.id)
        : [...prevKeys, record.id]
    );
  };

  const onSearch = (value) => {
    setSearchText(value);
    const filtered = data.filter((item) =>
      item.name.toLowerCase().includes(value.toLowerCase())
    );
    setFilteredData(filtered);
  };

  const handleDelete = async (id) => {
    try {
      const response = await deleteATaskType(id);
      if (response.errCode === 0) {
        const updatedData = data.filter((item) => item.id !== id);
        setData(updatedData);
        setFilteredData(updatedData);
        message.success("Xóa thành công");
      } else {
        message.error("Lỗi khi xóa dữ liệu: " + response.errMessage);
      }
    } catch (error) {
      message.error("Lỗi kết nối khi xóa dữ liệu");
    }
  };

  const columns = [
    {
      title: "Icon",
      dataIndex: "image",
      key: "image",
      render: (_, record) => (
        <Image width={30} src={record.image || record.avatar} />
      ),
    },
    {
      title: "Name",
      dataIndex: "name",
      key: "name",
    },
    {
      title: "Description",
      dataIndex: "description",
      key: "description",
    },
    {
      title: "Value",
      dataIndex: "value",
      key: "value",
    },
    {
      title: "Original Price",
      dataIndex: "originalPrice",
      key: "originalPrice",
      render: (price) => (price ? `${price.toLocaleString()} VND` : "N/A"),
    },
    {
      title: "Hành động",
      key: "action",
      render: (_, record) => (
        <Space size="middle">
          <EditOutlined
            onClick={() => {
              navigate(`/edit-service/${record.id}`, { state: record });
            }}
          />
          <Popconfirm
            title="Bạn có chắc chắn muốn xóa?"
            onConfirm={() => handleDelete(record.id)}
            okText="Xóa"
            cancelText="Hủy"
          >
            <DeleteOutlined style={{ color: "red" }} />
          </Popconfirm>
          <DownOutlined
            onClick={() => handleExpand(record)}
            style={{
              transition: "transform 0.3s ease",
              transform: expandedRowKeys.includes(record.id)
                ? "rotate(180deg)"
                : "rotate(0deg)",
            }}
          />
        </Space>
      ),
    },
  ];

  return (
    <div>
      <Row
        style={{
          marginBottom: "20px",
          display: "flex",
          justifyContent: "space-between",
        }}
      >
        <Col md={11}>
          <Search
            placeholder="Tìm kiếm dịch vụ"
            allowClear
            onSearch={onSearch}
            size="large"
            value={searchText}
            onChange={(e) => onSearch(e.target.value)}
          />
        </Col>
        <Col>
          <Button
            onClick={() => navigate("/add-new-service")}
            style={{ height: "38px" }}
            type="primary"
          >
            Thêm Dịch Vụ
          </Button>
        </Col>
      </Row>
      <Table
        columns={columns}
        dataSource={filteredData.map((item) => ({ ...item, key: item.id }))}
        expandable={{
          expandedRowRender: (record) => (
            <ExpandedRow
              record={record}
              isExpanded={expandedRowKeys.includes(record.id)}
            />
          ),
          expandedRowKeys,
          onExpand: (expanded, record) => handleExpand(record),
          expandIcon: () => null,
        }}
        pagination={{ position: ["bottomCenter"], pageSize: 15 }}
      />
    </div>
  );
};

export default Service;
