import React, { useState } from "react";
import { Table, Row, Button, Space } from "antd";
import { EditOutlined, DeleteOutlined } from "@ant-design/icons";

export default function AddPrices() {
  const [data, setData] = useState([
    {
      key: "1",
      name: "Price 1",
      description: "Description of price 1",
      stepValue: 10,
      stepPrice: 200,
      unit: "kg",
      beginValue: 100,
      beginPrice: 5000,
    },
    {
      key: "2",
      name: "Price 2",
      description: "Description of price 2",
      stepValue: 5,
      stepPrice: 150,
      unit: "L",
      beginValue: 50,
      beginPrice: 3000,
    },
  ]);

  const handleDelete = (key) => {
    setData(data.filter((item) => item.key !== key));
  };

  const columns = [
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
      title: "Begin Value",
      dataIndex: "beginValue",
      key: "beginValue",
    },
    {
      title: "Step Value",
      dataIndex: "stepValue",
      key: "stepValue",
    },
    {
      title: "Begin Price",
      dataIndex: "beginPrice",
      key: "beginPrice",
    },
    {
      title: "Step Price",
      dataIndex: "stepPrice",
      key: "stepPrice",
    },
    {
      title: "Unit",
      dataIndex: "unit",
      key: "unit",
    },

    {
      title: "Action",
      key: "action",
      render: (_, record) => (
        <Space size="middle">
          <EditOutlined style={{ color: "blue" }} />
          <DeleteOutlined
            style={{ color: "red" }}
            onClick={() => handleDelete(record.key)}
          />
        </Space>
      ),
    },
  ];

  return (
    <>
      <Row>
        <h4>Add Prices</h4>
        <Button type="primary">Add New Price</Button>
      </Row>
      <Table columns={columns} dataSource={data} pagination={{ pageSize: 5 }} />
    </>
  );
}
