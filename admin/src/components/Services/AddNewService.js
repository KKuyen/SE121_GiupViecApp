import React, { useState } from "react";
import { Form, Input, Button, Upload, Row, Col, Table, Space } from "antd";
import { UploadOutlined, DeleteOutlined } from "@ant-design/icons";
import { addNewTaskType } from "../../services/admnService";
const AddNewService = () => {
  const [priceList, setPriceList] = useState([]);
  const [form] = Form.useForm();

  const addPrice = () => {
    form
      .validateFields([
        "priceName",
        "pricevalue",
        "stepPrice",
        "unit",
        "beginValue",
        "stepValue",
      ])
      .then((values) => {
        setPriceList([...priceList, { ...values, key: priceList.length + 1 }]);
        form.resetFields([
          "priceName",
          "pricevalue",
          "stepPrice",
          "unit",
          "beginValue",
          "stepValue",
        ]);
      })
      .catch(() => {
        alert("Vui lòng nhập đủ thông tin");
      });
  };

  const deletePrice = (key) => {
    setPriceList(priceList.filter((item) => item.key !== key));
  };
  const handleSubmit = async () => {
    try {
      // Lấy dữ liệu từ form chính
      const values = await form.validateFields([
        "name",
        "description",
        "value",
        "originalPrice",
      ]);

      // Chuẩn bị dữ liệu gửi API
      const data = {
        name: values.name,
        avatar: null, // Hiện tại chưa có upload ảnh, để null
        description: values.description,
        image: "broom", // Giữ nguyên như yêu cầu
        value: parseFloat(values.value),
        originalPrice: parseFloat(values.originalPrice),
        addPriceDetails: priceList.map((item) => ({
          name: item.priceName,
          value: parseFloat(item.beginValue),
          stepPrice: parseFloat(item.stepPrice),
          value: parseFloat(item.pricevalue),
          stepValue: parseFloat(item.stepValue),
          unit: item.unit,
          beginValue: parseFloat(item.beginValue),
        })),
      };

      console.log("Dữ liệu gửi API:", data);

      // Gửi dữ liệu qua API
      const response = await addNewTaskType(data);
      console.log("Phản hồi API:", response.data);

      alert("Thêm dịch vụ thành công!");

      // Reset form sau khi gửi thành công
      form.resetFields();
      setPriceList([]);
    } catch (error) {
      console.error("Lỗi khi gửi dữ liệu:", error);
      alert("Vui lòng nhập đủ thông tin!");
    }
  };

  const columns = [
    { title: "Name", dataIndex: "priceName", key: "priceName" },
    { title: "Step Price", dataIndex: "stepPrice", key: "stepPrice" },
    { title: "Value", dataIndex: "pricevalue", key: "pricealue" },
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

  // Hàm chỉ cho phép nhập số
  const handleNumberInput = (event) => {
    const { value } = event.target;
    const charCode = event.which ? event.which : event.keyCode;
    const char = String.fromCharCode(charCode);

    // Cho phép số (0-9) và dấu chấm `.`
    if (!/[\d.]/.test(char)) {
      event.preventDefault();
    }

    // Không cho phép nhập nhiều hơn một dấu `.`
    if (char === "." && value.includes(".")) {
      event.preventDefault();
    }
  };

  return (
    <Form layout="vertical" form={form}>
      <Form.Item label="Upload" valuePropName="fileList">
        <Upload listType="picture-card" maxCount={1}>
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
          <Form.Item
            label="Original Price"
            name="originalPrice"
            rules={[{ required: true, message: "Enter original price" }]}
          >
            <Input
              placeholder="Enter original price"
              inputMode="numeric"
              onKeyPress={handleNumberInput}
            />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Value"
            name="value"
            rules={[{ required: true, message: "Enter value" }]}
          >
            <Input
              placeholder="Enter value"
              inputMode="numeric"
              onKeyPress={handleNumberInput}
            />
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
            rules={[{ required: true, message: "Enter name" }]}
          >
            <Input placeholder="Enter name" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Value"
            name="pricevalue"
            rules={[{ required: true, message: "Enter Value" }]}
          >
            <Input
              placeholder="Enter Value"
              inputMode="numeric"
              onKeyPress={handleNumberInput}
            />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Step Price"
            name="stepPrice"
            rules={[{ required: true, message: "Enter step price" }]}
          >
            <Input
              placeholder="Enter step price"
              inputMode="numeric"
              onKeyPress={handleNumberInput}
            />
          </Form.Item>
        </Col>
      </Row>

      <Row gutter={16}>
        <Col span={8}>
          <Form.Item
            label="Unit"
            name="unit"
            rules={[{ required: true, message: "Enter unit" }]}
          >
            <Input placeholder="Enter unit" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Begin Value"
            name="beginValue"
            rules={[{ required: true, message: "Enter begin value" }]}
          >
            <Input
              placeholder="Enter begin value"
              inputMode="numeric"
              onKeyPress={handleNumberInput}
            />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Step Value"
            name="stepValue"
            rules={[{ required: true, message: "Enter step value" }]}
          >
            <Input
              placeholder="Enter step value"
              inputMode="numeric"
              onKeyPress={handleNumberInput}
            />
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
        <Button type="primary" onClick={handleSubmit}>
          Finish
        </Button>
      </Row>
    </Form>
  );
};

export default AddNewService;
