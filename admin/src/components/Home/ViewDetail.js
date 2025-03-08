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
  Modal,
  Input,
  InputNumber,
  DatePicker,
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
  const [openResponsive, setOpenResponsive] = useState(false);
  const { RangePicker } = DatePicker;
  const [reviews, setReviews] = useState([]);

  const confirmDelete = () => {};
  const confirmDeleteLocation = () => {};
  useEffect(() => {
    // Call API
    axios.get(`/api/v1/get-a-user?id=${userId}`).then((res) => {
      console.log("res", res.user);
      console.log("review", res.user.reviews);
      setUser(res.user);
      setLocation(res.user.location);
      setReviews(res.user.reviews);
    });
  }, [userId]);

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
          <div className="name">{user?.name || "N/A"}</div>
          <div className="phone">
            <PhoneOutlined /> {user?.phoneNumber || "N/A"}
          </div>
          <div className="mail">
            <MailOutlined /> {user?.email || "N/A"}
          </div>
        </Col>
        <Col xs={24} sm={6} md={4}>
          <div className="btn">
            <Button
              type="primary"
              onClick={() => setOpenResponsive(true)}
              icon={<EditOutlined />}>
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
                    {user?.birthday ? user.birthday.substring(0, 10) : "N/A"}
                  </div>
                </div>
              </Col>
              <Col xs={24} sm={12}>
                <div className="info-item">
                  <div className="info-label">RPoints</div>
                  <div className="info-value">{user?.Rpoints || 0}</div>
                </div>
              </Col>
              <Col xs={24} sm={12}>
                <div className="info-item">
                  <div className="info-label">Ngày tham gia</div>
                  <div className="info-value">
                    {user?.createdAt ? user.createdAt.substring(0, 10) : "N/A"}
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
                        {review?.userName ? review.userName : "N/A"} <br />
                        <Rate
                          className="rate"
                          disabled
                          defaultValue={review?.star ? review.star : 0}
                        />
                      </span>
                    }
                    description={review?.content ? review.content : "N/A"}
                  />
                  <Row gutter={[16, 16]}>
                    <Col key={1}>
                      <Image
                        src={
                          review?.image1
                            ? review.image1
                            : require("../../assets/images/capy.jpeg")
                        }
                        width={100}
                      />
                    </Col>
                    <Col key={2}>
                      <Image
                        src={
                          review?.image2
                            ? review.image2
                            : require("../../assets/images/capy.jpeg")
                        }
                        width={100}
                      />
                    </Col>
                    <Col key={3}>
                      <Image
                        src={
                          review?.image3
                            ? review.image3
                            : require("../../assets/images/capy.jpeg")
                        }
                        width={100}
                      />
                    </Col>
                    <Col key={4}>
                      <Image
                        src={
                          review?.image4
                            ? review.image4
                            : require("../../assets/images/capy.jpeg")
                        }
                        width={100}
                      />
                    </Col>
                  </Row>
                  <div className="task-info">
                    <CalendarOutlined style={{ marginRight: 8 }} />
                    {review?.taskType?.name ? review.taskType.name : "N/A"}
                    <div>
                      {review?.createdAt
                        ? review.createdAt.substring(0, 10)
                        : "N/A"}
                    </div>
                  </div>
                </List.Item>
              )}
            />
          </Tabs.TabPane>
        </Tabs>
      </Row>
      <Modal
        title="Chỉnh sửa thông tin người dùng"
        centered
        open={openResponsive}
        onOk={() => setOpenResponsive(false)}
        onCancel={() => setOpenResponsive(false)}
        width="450px">
        <Space direction="vertical" style={{ width: "100%" }}>
          <Input placeholder="Họ tên" value={user?.name} />
          <Input placeholder="Email" value={user?.email} />
          <Input placeholder="Số điện thoại" value={user?.phoneNumber} />
          <DatePicker placeholder="Ngày sinh" value={user?.birthday} />
        </Space>
      </Modal>
    </>
  );
}
