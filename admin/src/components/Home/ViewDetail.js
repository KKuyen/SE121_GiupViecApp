import {
  Button,
  Col,
  Image,
  Row,
  Tabs,
  Avatar,
  List,
  Rate,
  Table,
  Space,
  Popconfirm,
} from "antd";
import React, { useEffect, useState } from "react";
import { useSearchParams } from "react-router";
import "./ViewDetail.scss";
import axios from "../../untils/axiosCustomize";

import {
  EditOutlined,
  MailOutlined,
  PhoneOutlined,
  CalendarOutlined,
  EyeOutlined,
  DeleteOutlined,
} from "@ant-design/icons";

export default function ViewDetail({ record }) {
  const [searchParams] = useSearchParams();
  const userId = searchParams.get("userId");
  const [activeTab, setActiveTab] = useState("1");
  const [user, setUser] = useState({});
  const [location, setLocation] = useState([]);
  const confirmDelete = () => {};
  const confirmDeleteLocation = () => {};
  useEffect(() => {
    // Call API
    axios.get(`/api/v1/get-a-user?id=${userId}`).then((res) => {
      console.log("res", res.user);
      console.log("location", res.user.location);
      setUser(res.user);
      setLocation(res.user.location);
    });
  }, []);

  useEffect(() => {
    // Call API
    console.log("userId", userId);
  }, [record]);

  const handleTabChange = (key) => {
    setActiveTab(key);
  };
  const columns = [
    {
      title: "Tên người dùng",
      dataIndex: "ownerName",
      key: "ownerName",
    },
    {
      title: "Số điện thoại",
      dataIndex: "ownerPhoneNumber",
      key: "ownerPhoneNumber",
    },
    {
      title: "Địa chỉ",
      dataIndex: "map",
      key: "map",
    },
    {
      title: "Action",
      key: "action",
      render: (_, record) => (
        console.log("record", record),
        (
          <Space size="middle">
            <EditOutlined />
            <Popconfirm
              title="Xóa địa chỉ"
              description="Bạn có chắc chắn muốn xóa địa chỉ này không?"
              onConfirm={confirmDeleteLocation}
              okText="Xóa"
              cancelText="Hủy">
              <DeleteOutlined style={{ color: "#ff4d4f" }} />
            </Popconfirm>
          </Space>
        )
      ),
    },
  ];
  const reviews = [
    {
      username: "toitenlatao",
      rating: 4,
      comment: "Xinh đẹp tuyệt vời",
      images: [
        require("../../assets/images/capy.jpeg"),
        require("../../assets/images/capy.jpeg"),
      ],
      task: "Giúp việc định kỳ",
      date: "12/09/2024 9:00",
    },
    {
      username: "toitenlatao",
      rating: 4,
      comment: "Xinh đẹp tuyệt vời",
      images: [
        require("../../assets/images/capy.jpeg"),
        require("../../assets/images/capy.jpeg"),
      ],
      task: "Giúp việc định kỳ",
      date: "12/09/2024 9:00",
    },
  ];

  return (
    <>
      <Row className="top-card" gutter={[16, 16]}>
        <Col xs={24} sm={6} md={3}>
          <Image
            className="avatar"
            src={require("../../assets/images/capy.jpeg")}
            width={100}
          />
        </Col>
        <Col xs={24} sm={12} md={17}>
          <div className="name">{user.name || "N/A"}</div>
          <div className="phone">
            <PhoneOutlined /> {user.phoneNumber || "N/A"}
          </div>
          <div className="mail">
            <MailOutlined /> {user.email || "N/A"}
          </div>
        </Col>
        <Col xs={24} sm={6} md={4}>
          <div className="btn">
            <Button type="primary" icon={<EditOutlined />}>
              Chỉnh sửa
            </Button>
            <Popconfirm
              title="Xóa người dùng"
              description="Bạn có chắc chắn muốn xóa người dùng này không?"
              onConfirm={confirmDelete}
              okText="Xóa"
              cancelText="Hủy">
              <Button danger className="btn-delete">
                <DeleteOutlined /> Xóa người dùng
              </Button>
            </Popconfirm>
          </div>
        </Col>
      </Row>
      <Row className="menu-container">
        <Tabs activeKey={activeTab} onChange={handleTabChange}>
          <Tabs.TabPane tab="Thông tin cá nhân" key="1">
            <Row gutter={[16, 16]}>
              <Col xs={24} sm={12}>
                <div className="info-item">
                  <div className="info-label">Ngày sinh</div>
                  <div className="info-value">
                    {user.birthday ? user.birthday.substring(0, 10) : "N/A"}
                  </div>
                </div>
              </Col>
              <Col xs={24} sm={12}>
                <div className="info-item">
                  <div className="info-label">RPoints</div>
                  <div className="info-value">{user.Rpoints || 0}</div>
                </div>
              </Col>
              <Col xs={24} sm={12}>
                <div className="info-item">
                  <div className="info-label">Ngày tham gia</div>
                  <div className="info-value">
                    {user.createdAt ? user.createdAt.substring(0, 10) : "N/A"}
                  </div>
                </div>
              </Col>
            </Row>
          </Tabs.TabPane>
          <Tabs.TabPane tab="Địa chỉ" key="2">
            <Table
              columns={columns}
              pagination={{
                position: ["bottomCenter"],
                pageSize: 8,
              }}
              dataSource={location}
            />
          </Tabs.TabPane>
          <Tabs.TabPane tab="Lịch sử" key="3">
            <div>aaaaaaaaaaaaaaaaaaaaaaa</div>
          </Tabs.TabPane>
          <Tabs.TabPane tab="Đánh giá" key="4">
            <List
              itemLayout="vertical"
              dataSource={reviews}
              renderItem={(review) => (
                <List.Item>
                  <List.Item.Meta
                    avatar={
                      <Avatar src={require("../../assets/images/avatar.jpg")} />
                    }
                    title={
                      <span>
                        {review.username} <br />
                        <Rate
                          className="rate"
                          disabled
                          defaultValue={review.rating}
                        />
                      </span>
                    }
                    description={review.comment}
                  />
                  <Row gutter={[16, 16]}>
                    {review.images.map((image, index) => (
                      <Col key={index}>
                        <Image src={image} width={100} />
                      </Col>
                    ))}
                  </Row>
                  <div className="task-info">
                    <CalendarOutlined style={{ marginRight: 8 }} />
                    {review.task}
                    <div>{review.date}</div>
                  </div>
                </List.Item>
              )}
            />
          </Tabs.TabPane>
        </Tabs>
      </Row>
    </>
  );
}
