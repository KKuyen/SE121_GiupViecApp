import React, { useEffect, useState } from "react";
import axios from "../../untils/axiosCustomize";
import { useNavigate } from "react-router-dom";
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
  Image,
  Space,
  Table,
  Tag,
  Popconfirm,
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

const { Search } = Input;

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
  const [filteredData, setFilteredData] = useState([]);
  const [openResponsive, setOpenResponsive] = useState(false);
  const [data, setData] = useState([]);
  const [isUser, setIsUser] = useState(true);
  const nav = useNavigate();
  const columns = [
    {
      title: "Ảnh đại diện",
      dataIndex: "avatar",
      key: "avatar",
      render: (avatar) => (
        <Image src={require("../../assets/images/avatar.jpg")} width={35} />
      ),
    },
    {
      title: "Tên",
      dataIndex: "name",
      key: "name",
      render: (text) => <a>{text}</a>,
      sorter: (a, b) => a.name.length - b.name.length,
      sortDirections: ["descend", "ascend"],
    },
    {
      title: "Số điện thoại",
      dataIndex: "phoneNumber",
      key: "phoneNumber",
      sorter: (a, b) => a.phoneNumber - b.phoneNumber,
      sortDirections: ["descend", "ascend"],
    },
    {
      title: "Email",
      dataIndex: "email",
      key: "email",
      sorter: (a, b) => a.email.length - b.email.length,
      sortDirections: ["descend", "ascend"],
    },
    {
      title: "Action",
      key: "action",
      render: (_, record) => (
        console.log("record", record),
        (
          <Space size="middle">
            <EyeOutlined onClick={() => viewDetail(record)} />
            <Popconfirm
              title="Xóa người dùng"
              description="Bạn có chắc chắn muốn xóa người dùng này không?"
              onConfirm={confirmDeleteUser}
              okText="Xóa"
              cancelText="Hủy">
              <DeleteOutlined style={{ color: "#ff4d4f" }} />
            </Popconfirm>
          </Space>
        )
      ),
    },
  ];
  const confirmDeleteUser = () => {};

  const viewDetail = (record) => {
    console.log("view detail", record);
    nav("/view-detail?userId=" + record.id);
  };
  useEffect(() => {
    // call api
    axios.get("/api/v1/get-all-users").then((res) => {
      console.log("res", res.users);
      const usersWithKey = res.users.map((user) => ({
        ...user,
        key: user.id,
      }));
      const filteredUsers = usersWithKey.filter((user) => user.role === "R1");

      setData(usersWithKey);
      setFilteredData(filteredUsers);
    });
  }, []);
  useEffect(() => {
    const filteredUsers = data.filter((user) =>
      isUser ? user.role === "R1" : user.role === "R2"
    );
    setFilteredData(filteredUsers);
  }, [isUser]);

  const handleRoleChange = (e) => {
    setIsUser(!isUser);
  };
  const onSearch = (value) => {
    const filteredResults = filteredData.filter((item) =>
      Object.values(item).some((val) =>
        String(val).toLowerCase().includes(value.toLowerCase())
      )
    );
    setFilteredData(filteredResults);
  };
  const onClear = () => {
    console.log("clear");
    let filteredData;
    if (isUser) {
      filteredData = data.filter((user) => user.role === "R1");
    } else {
      filteredData = data.filter((user) => user.role === "R2");
    }
    setFilteredData(filteredData);
  };
  return (
    <div>
      <Row justify="space-between">
        <Col md={11}>
          <Search
            placeholder="Tìm kiếm"
            allowClear
            onSearch={onSearch}
            onClear={onClear}
            size="large"
          />
        </Col>
        <Col md={8} style={{ margin: "5px" }}>
          <Segmented
            onChange={(value) => handleRoleChange(value)}
            options={[
              { label: "Khách hàng", value: "user", icon: <UserOutlined /> },
              {
                label: "Người giúp việc",
                value: "tasker",
                icon: <TeamOutlined />,
              },
            ]}
            selected={isUser ? "user" : "tasker"}
          />
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
    </div>
  );
};
export default Home;
