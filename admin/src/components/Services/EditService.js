import React, { useState, useEffect } from "react";
import { Form, Input, Button, Row, Col, Table, Space } from "antd";
import { DeleteOutlined } from "@ant-design/icons";
import { getATaskType, updateService } from "../../services/admnService";

const EditService = () => {
  const [priceList, setPriceList] = useState([]);
  const [form] = Form.useForm();
  const [id, setId] = useState(
    window.location.href.substring(window.location.href.lastIndexOf("/") + 1)
  );

  useEffect(() => {
    const fetchService = async () => {
      try {
        const response = await getATaskType({ taskTypeId: id });
        const serviceData = response.TaskType;

        form.setFieldsValue({
          mainName: serviceData.name,
          description: serviceData.description,
          mainvalue: serviceData.value,
          originalPrice: serviceData.originalPrice,
        });
        setPriceList(
          serviceData.addPriceDetails.map((item, index) => ({
            ...item,
            key: index + 1,
          }))
        );
      } catch (error) {
        console.error("Error fetching service details:", error);
      }
    };

    fetchService();
  }, [id, form]);

  const addPrice = () => {
    form
      .validateFields([
        "name",
        "stepPrice",
        "value",
        "unit",
        "beginValue",
        "stepValue",
      ])
      .then((values) => {
        setPriceList([...priceList, { ...values, key: priceList.length + 1 }]);
        form.resetFields([
          "name",
          "stepPrice",
          "value",
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

  const columns = [
    { title: "Name", dataIndex: "name", key: "name" },
    { title: "Value", dataIndex: "value", key: "value" },
    { title: "Step Price", dataIndex: "stepPrice", key: "stepPrice" },
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

  const handleSubmit = async () => {
    try {
      const values = await form.validateFields([
        "mainName",
        "description",
        "mainvalue",
        "originalPrice",
      ]);

      const data = {
        taskTypeId: id,
        name: values.mainName,
        avatar: null,
        description: values.description,
        image: "broom",
        value: parseFloat(values.mainvalue),
        originalPrice: parseFloat(values.originalPrice),
        addPriceDetails: priceList.map((item) => ({
          taskTypeId: id, // Include taskTypeId here
          name: item.name, // Ensure name is included

          value: parseFloat(item.value),
          stepPrice: parseFloat(item.stepPrice),
          stepValue: parseFloat(item.stepValue),
          unit: item.unit,
          beginValue: parseFloat(item.beginValue),
        })),
      };

      const response = await updateService(data);
      console.log("API Response:", response.data);
      alert("Cập nhật dịch vụ thành công!");
    } catch (error) {
      console.error("Lỗi khi cập nhật dữ liệu:", error);
      alert("Vui lòng nhập đủ thông tin!");
    }
  };

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
      <Row gutter={16}>
        <Col span={8}>
          <Form.Item label="Name" name="mainName" rules={[{ required: true }]}>
            <Input placeholder="Enter name" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Original Price"
            name="originalPrice"
            rules={[{ required: true }]}
          >
            <Input
              placeholder="Enter original price"
              onKeyPress={handleNumberInput}
            />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Value"
            name="mainvalue"
            rules={[{ required: true }]}
          >
            <Input placeholder="Enter value" onKeyPress={handleNumberInput} />
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
          <Form.Item label="Name" name="name" rules={[{ required: true }]}>
            <Input placeholder="Enter name" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Step Price"
            name="stepPrice"
            rules={[{ required: true }]}
          >
            <Input
              placeholder="Enter Step price"
              onKeyPress={handleNumberInput}
            />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item label="Value" name="value" rules={[{ required: true }]}>
            <Input placeholder="Enter value" onKeyPress={handleNumberInput} />
          </Form.Item>
        </Col>
      </Row>
      <Row gutter={16}>
        <Col span={8}>
          <Form.Item label="Unit" name="unit" rules={[{ required: true }]}>
            <Input placeholder="Enter unit" />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Begin Value"
            name="beginValue"
            rules={[{ required: true }]}
          >
            <Input
              placeholder="Enter begin value"
              onKeyPress={handleNumberInput}
            />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Step Value"
            name="stepValue"
            rules={[{ required: true }]}
          >
            <Input
              placeholder="Enter step value"
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
          Save
        </Button>
      </Row>
    </Form>
  );
};

export default EditService;
