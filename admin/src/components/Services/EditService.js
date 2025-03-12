import React, { useState, useEffect } from "react";
import {
  Form,
  Input,
  Button,
  Row,
  Col,
  Table,
  Space,
  Upload,
  message,
} from "antd";
import { UploadOutlined, DeleteOutlined } from "@ant-design/icons";
import { getATaskType, updateService } from "../../services/admnService";
import { createClient } from "@supabase/supabase-js";

const supabase = createClient(
  "https://wbekftdbbgbvuybtvjoi.supabase.co",
  "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndiZWtmdGRiYmdidnV5YnR2am9pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjgwODgxNTEsImV4cCI6MjA0MzY2NDE1MX0.j-bv1lYpTHBiCjFjlwpXGtLqoftFZRqazzoROas6gAA"
);

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

        if (serviceData) {
          const seriveImage = supabase.storage
            .from("images")
            .getPublicUrl(serviceData.image);
          serviceData.image = seriveImage.data.publicUrl;

          form.setFieldsValue({
            mainName: serviceData.name,
            description: serviceData.description,
            mainvalue: serviceData.value,
            originalPrice: serviceData.originalPrice,
            icon: serviceData.image ? [{ url: serviceData.image }] : [],
          });

          setPriceList(
            serviceData.addPriceDetails.map((item, index) => ({
              ...item,
              key: index + 1,
            }))
          );
        } else {
          console.error("Service data is undefined");
        }
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
        message.error("Vui lòng nhập đủ thông tin");
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
        "icon",
      ]);

      const fileList = form.getFieldValue("icon") || [];

      let fileName = null;

      if (
        Array.isArray(fileList) &&
        fileList.length > 0 &&
        fileList[0]?.originFileObj
      ) {
        const file = fileList[0].originFileObj;
        fileName = `${Date.now()}-${file.name}`;

        try {
          // Upload ảnh lên Supabase Storage
          const { data, error } = await supabase.storage
            .from("images")
            .upload(fileName, file);

          if (error) throw error;
        } catch (err) {
          console.error("Lỗi khi upload ảnh:", err);
          message.error("Không thể tải ảnh lên, vui lòng thử lại!");
        }
      } else {
        console.warn("Không có file nào được chọn.");
      }
      const data = {
        taskTypeId: id,
        name: values.mainName,
        avatar: fileName,
        description: values.description,
        image: fileName,
        value: parseFloat(values.mainvalue),
        originalPrice: parseFloat(values.originalPrice),
        addPriceDetails: priceList.map((item) => ({
          taskTypeId: id,
          name: item.name,
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
      alert(error);
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

  const handleUploadChange = (info) => {
    console.log("Upload info:", info);
    form.setFieldsValue({ icon: info.fileList });
  };

  return (
    <Form layout="vertical" form={form}>
      <Row gutter={16}>
        <Col span={8}>
          <Form.Item
            label="Name"
            name="mainName"
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
              onKeyPress={handleNumberInput}
            />
          </Form.Item>
        </Col>
        <Col span={8}>
          <Form.Item
            label="Value"
            name="mainvalue"
            rules={[{ required: true, message: "Enter value" }]}
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

      <h3>Giá tăng thêm</h3>
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
          Lưu
        </Button>
      </Row>
    </Form>
  );
};

export default EditService;
