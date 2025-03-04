import React, { useState } from "react";
import {
  Button,
  Col,
  Dropdown,
  Input,
  InputNumber,
  Menu,
  Modal,
  Radio,
  Row,
  Segmented,
  Space,
  Table,
  Tag,
  DatePicker,
} from "antd";

import {
  AppstoreOutlined,
  BarsOutlined,
  DeleteOutlined,
  DownOutlined,
  EditOutlined,
  EyeOutlined,
  UserOutlined,
  TeamOutlined,
  FilterOutlined,
  PlusCircleFilled,
  PlusCircleOutlined,
} from "@ant-design/icons";

const columns = [
  {
    title: "Name",
    dataIndex: "name",
    key: "name",
    render: (text) => <a>{text}</a>,
  },
  {
    title: "Age",
    dataIndex: "age",
    key: "age",
  },
  {
    title: "Address",
    dataIndex: "address",
    key: "address",
  },
  {
    title: "Tags",
    key: "tags",
    dataIndex: "tags",
    render: (tags) => (
      <span>
        {tags.map((tag) => {
          let color = tag.length > 5 ? "geekblue" : "green";
          if (tag === "loser") {
            color = "volcano";
          }
          return (
            <Tag color={color} key={tag}>
              {tag.toUpperCase()}
            </Tag>
          );
        })}
      </span>
    ),
  },
  {
    title: "Action",
    key: "action",
    render: (_, record) => (
      <Space size="middle">
        <EyeOutlined size={30} />
        <EditOutlined />
        <DeleteOutlined />
      </Space>
    ),
  },
];
const data = [
  {
    key: "1",
    name: "John Brown",
    age: 32,
    address: "New York No. 1 Lake Park",
    tags: ["nice", "developer"],
  },
  {
    key: "2",
    name: "Jim Green",
    age: 42,
    address: "London No. 1 Lake Park",
    tags: ["loser"],
  },
  {
    key: "3",
    name: "Joe Black",
    age: 32,
    address: "Sydney No. 1 Lake Park",
    tags: ["cool", "teacher"],
  },
  {
    key: "4",
    name: "John Brown",
    age: 32,
    address: "New York No. 1 Lake Park",
    tags: ["nice", "developer"],
  },
  {
    key: "5",
    name: "Jim Green",
    age: 42,
    address: "London No. 1 Lake Park",
    tags: ["loser"],
  },
  {
    key: "6",
    name: "Joe Black",
    age: 32,
    address: "Sydney No. 1 Lake Park",
    tags: ["cool", "teacher"],
  },
  {
    key: "7",
    name: "John Brown",
    age: 32,
    address: "New York No. 1 Lake Park",
    tags: ["nice", "developer"],
  },
  {
    key: "8",
    name: "Jim Green",
    age: 42,
    address: "London No. 1 Lake Park",
    tags: ["loser"],
  },
  {
    key: "9",
    name: "Joe Black",
    age: 32,
    address: "Sydney No. 1 Lake Park",
    tags: ["cool", "teacher"],
  },
  {
    key: "10",
    name: "Jim Green",
    age: 42,
    address: "London No. 1 Lake Park",
    tags: ["loser"],
  },
  {
    key: "11",
    name: "Joe Black",
    age: 32,
    address: "Sydney No. 1 Lake Park",
    tags: ["cool", "teacher"],
  },
];
const items = [
  {
    label: "Người giúp việc",
    key: "1",
  },
  {
    label: "Khách hàng",
    key: "2",
  },
];
const { Search } = Input;
const onSearch = (value, _e, info) => console.log(info?.source, value);

const filterItems = [
  {
    label: "Age > 30",
    key: "1",
  },
  {
    label: "Age <= 30",
    key: "2",
  },
  {
    label: "Developer",
    key: "3",
  },
  {
    label: "Teacher",
    key: "4",
  },
];

const Vouchers = () => {
  const [selectedItem, setSelectedItem] = useState(items[0].label);
  const [filteredData, setFilteredData] = useState(data);
  const [openResponsive, setOpenResponsive] = useState(false);
  const { RangePicker } = DatePicker;

  const handleMenuClick = (e) => {
    const selected = items.find((item) => item.key === e.key);
    setSelectedItem(selected.label);
  };

  const handleFilterClick = ({ key }) => {
    let filtered = data;
    switch (key) {
      case "1":
        filtered = data.filter((item) => item.age > 30);
        break;
      case "2":
        filtered = data.filter((item) => item.age <= 30);
        break;
      case "3":
        filtered = data.filter((item) => item.tags.includes("developer"));
        break;
      case "4":
        filtered = data.filter((item) => item.tags.includes("teacher"));
        break;
      default:
        break;
    }
    setFilteredData(filtered);
  };

  return (
    <div>
      <Row justify="space-between">
        <Col md={11}>
          <Search
            placeholder="input search text"
            allowClear
            onSearch={onSearch}
            size="large"
          />
        </Col>
        <Col md={3}>
          <Button
            onClick={() => setOpenResponsive(true)}
            style={{
              backgroundColor: "#4AB7B6",
              color: "white",
              fontSize: "15px",
            }}>
            <Space>
              <PlusCircleOutlined />
              <span>Thêm ưu đãi</span>
            </Space>
          </Button>
        </Col>
      </Row>
      <Table
        columns={columns}
        pagination={{
          position: ["bottomCenter"],
          pageSize: 8,
        }}
        dataSource={filteredData}
      />
      <Modal
        title="Thêm ưu đãi"
        centered
        open={openResponsive}
        onOk={() => setOpenResponsive(false)}
        onCancel={() => setOpenResponsive(false)}
        width="450px">
        <Space direction="vertical" style={{ width: "100%" }}>
          <Input placeholder="Tên voucher" />
          <InputNumber min={1} max={100} placeholder="Tỉ lệ ưu đãi   " />
          <RangePicker showTime />
        </Space>
      </Modal>
    </div>
  );
};
export default Vouchers;
