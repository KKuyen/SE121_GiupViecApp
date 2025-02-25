import React, { useState } from "react";
import {
  Form,
  Input,
  Button,
  Upload,
  Card,
  Row,
  Col,
  Table,
  Space,
} from "antd";
import { UploadOutlined, DeleteOutlined } from "@ant-design/icons";

const AddNewService = () => {
  const [priceList, setPriceList] = useState([]);
  const [form] = Form.useForm();

  const addPrice = () => {
    form
      .validateFields([
        "priceName",
        "beginPrice",
        "stepPrice",
        "priceDescription",
        "unit",
        "beginValue",
        "stepValue",
      ])
      .then((values) => {
        setPriceList([...priceList, { ...values, key: priceList.length + 1 }]);
        form.resetFields([
          "priceName",
          "beginPrice",
          "stepPrice",
          "priceDescription",
          "unit",
          "beginValue",
          "stepValue",
        ]);
      });
  };

  const deletePrice = (key) => {
    setPriceList(priceList.filter((item) => item.key !== key));
  };

  const columns = [
    { title: "Name", dataIndex: "priceName", key: "priceName" },
    {
      title: "Description",
      dataIndex: "priceDescription",
      key: "priceDescription",
    },
    { title: "Step Price", dataIndex: "stepPrice", key: "stepPrice" },
    { title: "Begin Price", dataIndex: "beginPrice", key: "beginPrice" },
    { title: "Unit", dataIndex: "unit", key: "unit" },
    { title: "Begin Value", dataIndex: "beginValue", key: "beginValue" },
    { title: "Step Value", dataIndex: "stepValue", key: "stepValue" },
    {
      title: "Action",
      key: "action",
      render: (_, record) => (
        <Space size="middle">
          <Button
            type="link"
            icon={<DeleteOutlined />}
            onClick={() => deletePrice(record.key)}
          />
        </Space>
      ),
    },
  ];

  return (
    <Form layout="vertical" form={form}>
      <Form.Item label="Upload" valuePropName="fileList">
        <Upload listType="picture-card">
          <div>
            <UploadOutlined />
          </div>
        </Upload>
      </Form.Item>

      <Row gutter={16}>
        <Col span={8}>
          <Form.Item
            label="Name"
            name="name"
            rules={[{ required: true, message: "Please enter name" }]}
          >
            <Input placeholder="Enter name" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item label="Original Price" name="originalPrice">
            <Input placeholder="Enter original price" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item label="Value" name="value">
            <Input placeholder="Enter value" />
          </Form.Item>
        </Col>
      </Row>

      <Row gutter={16}>
        <Col span={24}>
          <Form.Item label="Description" name="description">
            <Input.TextArea placeholder="Enter description" />
          </Form.Item>
        </Col>
      </Row>

      <h3>Add Price</h3>
      <Row gutter={16}>
        <Col span={8}>
          <Form.Item
            label="Name"
            name="priceName"
            rules={[{ required: true, message: "Enter price name" }]}
          >
            <Input placeholder="Enter price name" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item label="Begin Price" name="beginPrice">
            <Input placeholder="Enter begin price" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item label="Step Price" name="stepPrice">
            <Input placeholder="Enter step price" />
          </Form.Item>
        </Col>
      </Row>

      <Row gutter={16}>
        <Col span={8}>
          <Form.Item label="Unit" name="unit">
            <Input placeholder="Enter unit" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item label="Begin Value" name="beginValue">
            <Input placeholder="Enter begin value" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item label="Step Value" name="stepValue">
            <Input placeholder="Enter step value" />
          </Form.Item>
        </Col>
      </Row>

      <Row gutter={16}>
        <Col span={24}>
          <Form.Item label="Description" name="priceDescription">
            <Input.TextArea placeholder="Enter price description" />
          </Form.Item>
        </Col>
      </Row>

      <Button type="dashed" block onClick={addPrice}>
        Add Price
      </Button>

      <Table
        columns={columns}
        dataSource={priceList}
        style={{ marginTop: 20 }}
      />

      <Row justify="end" style={{ marginTop: 20 }}>
        <Button style={{ marginRight: 10 }}>Cancel</Button>
        <Button type="primary">Finish</Button>
      </Row>
    </Form>
  );
};

export default AddNewService;
