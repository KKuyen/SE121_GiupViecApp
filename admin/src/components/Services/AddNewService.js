import React, { useState } from "react";
import {
  Form,
  Input,
  Button,
  Upload,
  Row,
  Col,
  Table,
  Space,
  message,
} from "antd";
import { UploadOutlined, DeleteOutlined } from "@ant-design/icons";
import { addNewTaskType } from "../../services/admnService";
import { createClient } from "@supabase/supabase-js";

const supabase = createClient(
  "https://wbekftdbbgbvuybtvjoi.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndiZWtmdGRiYmdidnV5YnR2am9pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgwODgxNTEsImV4cCI6MjA0MzY2NDE1MX0.j-bv1lYpTHBiCjFjlwpXGtLqoftFZRqazzoROas6gAA"
);

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
        message.error("Vui lòng nhập đủ thông tin");
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
        "icon",
      ]);

      // Lấy danh sách file từ Upload
      const fileList = form.getFieldValue("icon") || [];

      let fileName = null;
      let fileUrl = null;

      if (fileList.length > 0) {
        const file = fileList[0].originFileObj;
        fileName = `${Date.now()}-${file.name}`;

        // Upload ảnh lên Supabase Storage
        const { data, error } = await supabase.storage
          .from("images")
          .upload(fileName, file);
        if (error) throw error;

        // Lấy public URL của ảnh
        const { publicURL, error: urlError } = supabase.storage
          .from("images")
          .getPublicUrl(fileName);
        if (urlError) throw urlError;

        fileUrl = publicURL;
      }

      // Chuẩn bị dữ liệu gửi API
      const data = {
        name: values.name,
        avatar: fileUrl, // Lưu URL của ảnh
        description: values.description,
        image: fileName, // Lưu fileName vào DB
        value: parseFloat(values.value),
        originalPrice: parseFloat(values.originalPrice),
        addPriceDetails: priceList.map((item) => ({
          name: item.priceName,
          value: parseFloat(item.beginValue),
          stepPrice: parseFloat(item.stepPrice),
          priceValue: parseFloat(item.pricevalue),
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
      message.error("Vui lòng nhập đủ thông tin!");
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

  const handleUploadChange = (info) => {
    const newFileList = info.fileList || [];
    form.setFieldsValue({ icon: newFileList });
  };

  return (
    <Form layout="vertical" form={form}>
      <Form.Item
        label="Icon"
        name="icon"
        valuePropName="fileList"
        rules={[{ required: true, message: "Vui lòng tải lên một ảnh" }]}
        getValueFromEvent={(e) =>
          Array.isArray(e?.fileList) ? e.fileList : []
        }
      >
        <Upload
          listType="picture-card"
          maxCount={1}
          beforeUpload={() => false} // Không tự động upload
          onChange={handleUploadChange}
        >
          <UploadOutlined />
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

      <h3>Giá tăng thêm</h3>
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

      <Button type="dashed" block onClick={addPrice} style={{ height: 38 }}>
        Tạo giá thêm
      </Button>

      <Table
        columns={columns}
        dataSource={priceList}
        style={{ marginTop: 20 }}
      />

      <Row justify="end" style={{ marginTop: 20 }}>
        <Button style={{ marginRight: 10 }}>Hủy</Button>
        <Button type="primary" onClick={handleSubmit}>
          Hoàn thành
        </Button>
      </Row>
    </Form>
  );
};

export default AddNewService;
