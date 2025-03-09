import React, { useState, useEffect } from "react";
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
  const navigate = useNavigate();

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await getAllTaskTypes();
        if (response.errCode === 0) {
          setData(response.taskTypeList);
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
    console.log("Search value:", value);
  };

  const handleDelete = async (id) => {
    try {
      const response = await deleteATaskType(id);
      if (response.errCode === 0) {
        setData((prevData) => prevData.filter((item) => item.id !== id));
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
        <Image width={50} src={record.image || record.avatar} />
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
      <Row>
        <Col md={11}>
          <Search
            placeholder="Tìm kiếm dịch vụ"
            allowClear
            onSearch={onSearch}
            size="large"
          />
        </Col>
        <Col>
          <Button onClick={() => navigate("/add-new-service")}>
            Thêm Dịch Vụ
          </Button>
        </Col>
      </Row>
      <Table
        columns={columns}
        dataSource={data.map((item) => ({ ...item, key: item.id }))}
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
