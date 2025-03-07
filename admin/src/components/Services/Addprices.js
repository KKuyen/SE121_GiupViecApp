import React from "react";
import { Table, Row, Button, Space } from "antd";
import { EditOutlined, DeleteOutlined } from "@ant-design/icons";

const AddPrices = ({ prices = [] }) => {
  const columns = [
    {
      title: "Tên giá",
      dataIndex: "name",
      key: "name",
    },

    {
      title: "Giá bắt đầu",
      dataIndex: "beginPrice",
      key: "beginPrice",
      render: (price) => `${price.toLocaleString()} VND`,
    },
    {
      title: "Giá mỗi bước",
      dataIndex: "stepPrice",
      key: "stepPrice",
      render: (price) => `${price.toLocaleString()} VND`,
    },
    {
      title: "Đơn vị",
      dataIndex: "unit",
      key: "unit",
    },
    {
      title: "Bước giá trị",
      dataIndex: "stepValue",
      key: "stepValue",
    },
    {
      title: "Hành động",
      key: "action",
      render: (_, record) => (
        <Space size="middle">
          <EditOutlined />
          <DeleteOutlined style={{ color: "red" }} />
        </Space>
      ),
    },
  ];

  return (
    <>
      <Row justify="space-between" align="middle">
        <h4 style={{ fontSize: "15px" }}>Giá tăng thêm</h4>

        <Button type="primary">
          <div
            style={{
              fontSize: "22px",
              fontWeight: "bold",
              transform: "translateY(-3px)",
            }}
          >
            +
          </div>
        </Button>
      </Row>

      <Table
        columns={columns}
        dataSource={prices.map((p) => ({ ...p, key: p.id }))}
        pagination={{ pageSize: 5 }}
      />
    </>
  );
};

export default AddPrices;
