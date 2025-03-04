import React, { useState } from "react";
import { Button, Col, Image, Input, Row, Space, Table } from "antd";
import { EditOutlined, DeleteOutlined, DownOutlined } from "@ant-design/icons";
import { useNavigate } from "react-router-dom";
import AddPrices from "./Addprices"; // Ensure this import is correct

const { Search } = Input;

const ExpandedRow = ({ record }) => {
  return (
    <div>
      <AddPrices />
    </div>
  );
};

const ServiceTable = () => {
  const [expandedRowKeys, setExpandedRowKeys] = useState([]);
  const navigate = useNavigate();

  const handleExpand = (record) => {
    setExpandedRowKeys((prevKeys) =>
      prevKeys.includes(record.key)
        ? prevKeys.filter((key) => key !== record.key)
        : [...prevKeys, record.key]
    );
  };

  const onSearch = (value) => {
    console.log("Search value:", value);
  };

  const columns = [
    {
      title: "Image",
      dataIndex: "image",
      key: "image",
      render: (image) => <Image width={50} src={image} />,
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
    },
    {
      title: "Action",
      key: "action",
      render: (_, record) => (
        <Space size="middle">
          <EditOutlined />
          <DeleteOutlined />

          <DownOutlined
            onClick={() => handleExpand(record)}
            rotate={expandedRowKeys.includes(record.key) ? 180 : 0}
          />
        </Space>
      ),
    },
  ];

  const data = [
    {
      key: "1",
      image: "https://via.placeholder.com/50",
      name: "Service 1",
      description: "This is a sample service description.",
      value: "$100",
      originalPrice: "$150",
    },
    {
      key: "2",
      image: "https://via.placeholder.com/50",
      name: "Service 2",
      description: "Another service description.",
      value: "$200",
      originalPrice: "$250",
    },
  ];

  return (
    <div>
      <Row>
        <Col md={11}>
          <Search
            placeholder="input search text"
            allowClear
            onSearch={onSearch}
            size="large"
          />
        </Col>
        <Col>
          <Button onClick={() => navigate("/add-new-service")}>
            Add New Service
          </Button>
        </Col>
      </Row>

      <Table
        columns={columns}
        dataSource={data}
        expandable={{
          expandedRowRender: (record) => <ExpandedRow record={record} />,
          expandedRowKeys,
          onExpand: (expanded, record) => handleExpand(record),
          expandIcon: () => null,
        }}
        pagination={{ position: ["bottomCenter"], pageSize: 5 }}
      />
    </div>
  );
};

export default ServiceTable;
