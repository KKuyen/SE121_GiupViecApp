import React, { useState } from "react";
import {
  Button,
  Col,
  Dropdown,
  Input,
  Menu,
  Modal,
  Radio,
  Row,
  Segmented,
  Space,
  Table,
  Tag,
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

const Home = () => {
  const [selectedItem, setSelectedItem] = useState(items[0].label);
  const [filteredData, setFilteredData] = useState(data);
  const [openResponsive, setOpenResponsive] = useState(false);

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
        <Col md={8} style={{ margin: "5px" }}>
          <Segmented
            options={[
              { label: "Khách hàng", value: "List", icon: <UserOutlined /> },
              {
                label: "Người giúp việc",
                value: "Kanban",
                icon: <TeamOutlined />,
              },
            ]}
          />
        </Col>
        <Col md={2} style={{ margin: "5px" }}>
          <Button onClick={() => setOpenResponsive(true)}>
            <Space>
              <FilterOutlined />
              Filter
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
        title="Lọc"
        centered
        open={openResponsive}
        onOk={() => setOpenResponsive(false)}
        onCancel={() => setOpenResponsive(false)}
        width="400px">
        <p>some contents...</p>
        <p>some contents...</p>
        <p>some contents...</p>
      </Modal>
    </div>
  );
};
export default Home;
