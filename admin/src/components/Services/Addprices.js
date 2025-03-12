import React from "react";
import {
  Table,
  Row,
  Button,
  Space,
  Drawer,
  Input,
  message,
  Popconfirm,
} from "antd";
import { EditOutlined, DeleteOutlined } from "@ant-design/icons";
import "./style.css";
import {
  addAddPriceDetail,
  deleteAddPriceDetail,
  editAddPriceDetail,
} from "../../services/admnService";

const AddPrices = ({ prices = [], id }) => {
  const [dataSource, setDataSource] = React.useState(prices);
  const [isDrawerVisible, setIsDrawerVisible] = React.useState(false);
  const [editingPrice, setEditingPrice] = React.useState(null);

  const handleDeletePrice = async (id) => {
    try {
      await deleteAddPriceDetail(id);
      setDataSource(dataSource.filter((price) => price.id !== id));
      message.success("Xóa giá thành công!");
    } catch (error) {
      message.error("Xóa giá thất bại!");
    }
  };

  const handleEditPrice = (record) => {
    setEditingPrice(record); // Lưu thông tin cần sửa
    setIsDrawerVisible(true);
  };

  const handleSavePrice = async () => {
    try {
      const data = {
        taskTypeId: parseFloat(id),
        name: editingPrice.name,
        value: parseFloat(editingPrice.value) || 0,
        stepPrice: parseFloat(editingPrice.stepPrice) || 0,
        beginPrice: 0,
        stepValue: parseFloat(editingPrice.stepValue) || 0,
        unit: editingPrice.unit,
        beginValue: parseFloat(editingPrice.beginValue) || 0,
      };

      if (editingPrice.id) {
        // Chỉnh sửa
        await editAddPriceDetail(data);
        setDataSource(
          dataSource.map((item) =>
            item.id === editingPrice.id ? editingPrice : item
          )
        );
        message.success("Cập nhật giá thành công!");
      } else {
        // Thêm mới

        const newPrice = { ...editingPrice, id: id };

        await addAddPriceDetail({
          taskTypeId: parseFloat(id),
          name: editingPrice.name,
          value: parseFloat(editingPrice.value),
          stepPrice: parseFloat(editingPrice.stepPrice),
          beginPrice: 10000,
          stepValue: parseFloat(editingPrice.stepValue),
          unit: editingPrice.unit,
          beginValue: parseFloat(editingPrice.beginValue),
        });

        setDataSource([...dataSource, newPrice]);
        message.success("Thêm giá thành công!");
      }
      setIsDrawerVisible(false);
      setEditingPrice(null);
    } catch (error) {
      message.error("Có lỗi xảy ra!");
    }
  };

  const columns = [
    {
      title: "name",
      dataIndex: "name",
      key: "name",
    },
    {
      title: "beginValue",
      dataIndex: "beginValue",
      key: "beginValue",
      render: (price) => `${price.toLocaleString()} VND`,
    },
    {
      title: "stepPrice",
      dataIndex: "stepPrice",
      key: "stepPrice",
      render: (price) => `${price.toLocaleString()} VND`,
    },
    {
      title: "unit",
      dataIndex: "unit",
      key: "unit",
    },
    {
      title: "stepValue",
      dataIndex: "stepValue",
      key: "stepValue",
    },
    {
      title: "Value",
      dataIndex: "value",
      key: "value",
    },
    {
      title: "Hành động",
      key: "action",
      render: (_, record) => (
        <Space size="middle">
          <EditOutlined onClick={() => handleEditPrice(record)} />
          <Popconfirm
            title="Bạn có chắc chắn muốn xóa?"
            onConfirm={() => handleDeletePrice(record.id)}
            okText="Xóa"
            cancelText="Hủy"
          >
            <DeleteOutlined style={{ color: "red" }} />
          </Popconfirm>
        </Space>
      ),
    },
  ];

  const handleNumberInput = (event) => {
    const { value } = event.target;
    const charCode = event.which ? event.which : event.keyCode;
    const char = String.fromCharCode(charCode);

    if (!/[\d.]/.test(char)) {
      event.preventDefault();
    }

    if (char === "." && value.includes(".")) {
      event.preventDefault();
    }
  };

  return (
    <>
      <Row justify="space-between" align="middle">
        <h4 style={{ fontSize: "15px" }}>Giá tăng thêm</h4>
        <Button
          type="primary"
          onClick={() => {
            if (dataSource.length >= 4) {
              alert("Chỉ được thêm tối đa 4 giá");
              return;
            }
            setEditingPrice({
              name: "",
              beginValue: "",
              stepPrice: "",
              unit: "",
              stepValue: "",
              value: "",
            });
            setIsDrawerVisible(true);
          }}
        >
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
        dataSource={dataSource.map((p) => ({ ...p, key: p.id }))}
        pagination={{ pageSize: 5 }}
      />
      <Drawer
        title={editingPrice?.id ? "Chỉnh sửa giá" : "Thêm giá mới"}
        width={360}
        onClose={() => setIsDrawerVisible(false)}
        open={isDrawerVisible}
        footer={
          <div style={{ textAlign: "right" }}>
            <Button
              onClick={() => {
                setIsDrawerVisible(false);
                setEditingPrice(null);
              }}
              style={{ marginRight: 8 }}
            >
              Hủy
            </Button>
            <Button onClick={handleSavePrice} type="primary">
              {editingPrice?.id ? "Lưu" : "Thêm"}
            </Button>
          </div>
        }
      >
        <div className="nhan">name</div>
        <Input
          placeholder="name"
          value={editingPrice?.name || ""}
          onChange={(e) =>
            setEditingPrice({ ...editingPrice, name: e.target.value })
          }
          style={{ marginBottom: 16 }}
        />
        <div className="nhan">beginValue</div>
        <Input
          onKeyPress={handleNumberInput}
          placeholder="beginValue"
          value={editingPrice?.beginValue || ""}
          onChange={(e) =>
            setEditingPrice({ ...editingPrice, beginValue: e.target.value })
          }
          style={{ marginBottom: 16 }}
        />
        <div className="nhan">stepPrice</div>
        <Input
          onKeyPress={handleNumberInput}
          placeholder="stepPrice"
          value={editingPrice?.stepPrice || ""}
          onChange={(e) =>
            setEditingPrice({ ...editingPrice, stepPrice: e.target.value })
          }
          style={{ marginBottom: 16 }}
        />
        <div className="nhan">unit</div>
        <Input
          placeholder="unit"
          value={editingPrice?.unit || ""}
          onChange={(e) =>
            setEditingPrice({ ...editingPrice, unit: e.target.value })
          }
          style={{ marginBottom: 16 }}
        />
        <div className="nhan">stepValue</div>
        <Input
          onKeyPress={handleNumberInput}
          placeholder="stepValue"
          value={editingPrice?.stepValue || ""}
          onChange={(e) =>
            setEditingPrice({ ...editingPrice, stepValue: e.target.value })
          }
          style={{ marginBottom: 16 }}
        />
        <div className="nhan">value</div>
        <Input
          onKeyPress={handleNumberInput}
          placeholder="value"
          value={editingPrice?.value || ""}
          onChange={(e) =>
            setEditingPrice({ ...editingPrice, value: e.target.value })
          }
          style={{ marginBottom: 16 }}
        />
      </Drawer>
    </>
  );
};

export default AddPrices;
