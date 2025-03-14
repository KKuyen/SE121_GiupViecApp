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
  Tag,
} from "antd";
import React, { useEffect, useState } from "react";
import { useNavigate, useSearchParams } from "react-router";
import "./ViewDetail.scss";
import axios from "../../untils/axiosCustomize";
import moment from "moment";

import {
  EditOutlined,
  MailOutlined,
  PhoneOutlined,
  CalendarOutlined,
  EyeOutlined,
  DeleteOutlined,
} from "@ant-design/icons";
import MapPicker from "react-google-map-picker";

const DefaultLocation = { lat: 10, lng: 106 };
const DefaultZoom = 10;
export default function ViewDetail({ record }) {
  const [searchParams] = useSearchParams();
  const userId = searchParams.get("userId");
  const [activeTab, setActiveTab] = useState("1");
  const [user, setUser] = useState({});
  const [location, setLocation] = useState([]);
  const [openResponsive, setOpenResponsive] = useState(false);
  const [openLocationResponsive, setOpenLocationResponsive] = useState(false);
  const { RangePicker } = DatePicker;
  const [reviews, setReviews] = useState([]);
  const [tasks, setTasks] = useState([]);
  const [name, setName] = useState("");
  const [email, setEmail] = useState("");
  const [phoneNumber, setPhoneNumber] = useState("");
  const [birthday, setBirthday] = useState(null);
  const nav = useNavigate();

  const confirmDelete = () => {
    axios.delete(`/api/v1/delete-user?id=${userId}`).then((res) => {
      if (res.errCode === 0) {
        nav("/");
      }
    });
  };
  const confirmDeleteLocation = () => {};
  const confirmDeleteTask = () => {};

  useEffect(() => {
    // Call API
    axios.get(`/api/v1/get-a-user?id=${userId}`).then((res) => {
      setUser(res.user);
      setLocation(res.user.location);
      setReviews(res.user.reviews);
    });
    axios.post("/api/v1/get-all-tasks", { userId: userId }).then((res) => {
      console.log("res", res.taskList);
      res.taskList.map((task) => {
        const temp = {
          key: task?._id,
          taskName: task?.taskType?.name,
          createdAt: task?.createdAt?.substring(0, 10),
          map:
            task?.location?.detailAddress +
            ", " +
            task?.location?.district +
            ", " +
            task?.location?.province,
          numberOfTasker: task?.numberOfTasker,
          taskStatus: task?.taskStatus,
        };
        setTasks((tasks) => [...tasks, temp]);
      });
      //setTasks(res.tasks);
    });
  }, [userId]);

  useEffect(() => {
    // Call API
    console.log("userId", userId);
  }, [record]);

  const handleTabChange = (key) => {
    setActiveTab(key);
  };

  const handleEditClick = () => {
    setName(user.name);
    setEmail(user.email);
    setPhoneNumber(user.phoneNumber);
    setBirthday(user.birthday ? moment(user.birthday) : null);
    setOpenResponsive(true);
  };
  const handleEditLocationClick = () => {
    setName(user.name);
    setEmail(user.email);
    setPhoneNumber(user.phoneNumber);
    setBirthday(user.birthday ? moment(user.birthday) : null);
    setOpenLocationResponsive(true);
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
            <EditOutlined onClick={handleEditLocationClick} />
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
  const historyColumns = [
    {
      title: "Tên công việc",
      dataIndex: "taskName",
      key: "taskName",
    },
    {
      title: "Ngày đặt",
      dataIndex: "createdAt",
      key: "createdAt",
    },
    {
      title: "Địa chỉ",
      dataIndex: "map",
      key: "map",
    },
    {
      title: "Số người làm",
      dataIndex: "numberOfTasker",
      key: "numberOfTasker",
    },
    {
      title: "Trạng thái",
      key: "taskStatus",
      dataIndex: "taskStatus",
      render: (_, { taskStatus }) => {
        let color = "";
        let text = "";
        switch (taskStatus) {
          case "TS1":
            color = "blue";
            text = "Đang đặt";
            break;
          case "TS2":
            color = "green";
            text = "Đã đặt";
            break;
          case "TS3":
            color = "yellow";
            text = "Hoàn thành";
            break;
          case "TS4":
            color = "red";
            text = "Đã hủy";
            break;
          default:
            color = "gray";
            text = "Không xác định";
        }
        return (
          <Tag color={color} key={taskStatus}>
            {text}
          </Tag>
        );
      },
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
              title="Xóa công việc"
              description="Bạn có chắc chắn muốn xóa công việc này không?"
              onConfirm={confirmDeleteTask}
              okText="Xóa"
              cancelText="Hủy">
              <DeleteOutlined style={{ color: "#ff4d4f" }} />
            </Popconfirm>
          </Space>
        )
      ),
    },
  ];
  const handleEditUser = () => {
    setOpenResponsive(false);
    const data = {
      id: userId,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      birthday: birthday,
    };
    axios.put("/api/v1/edit-user", data).then((res) => {
      if (res.errCode === 0) {
        setUser(
          (user) => (user = { ...user, name, email, phoneNumber, birthday })
        );
      }
    });
  };
  const handleEditLocation = () => {
    setOpenLocationResponsive(false);
  };
  const [defaultLocation, setDefaultLocation] = useState(DefaultLocation);

  const [map, setMap] = useState(defaultLocation);
  const [zoom, setZoom] = useState(DefaultZoom);

  function handleChangeLocation(lat, lng) {
    setMap({ lat: lat, lng: lng });
  }

  function handleChangeZoom(newZoom) {
    setZoom(newZoom);
  }

  function handleResetLocation() {
    setDefaultLocation({ ...DefaultLocation });
    setZoom(DefaultZoom);
  }
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
              onClick={handleEditClick}
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
                    {user?.birthday
                      ? user.birthday.toString().substring(0, 10)
                      : "N/A"}
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
            <Table
              columns={historyColumns}
              pagination={{
                position: ["bottomCenter"],
                pageSize: 7,
              }}
              dataSource={tasks}
            />
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
        onOk={handleEditUser}
        onCancel={() => setOpenResponsive(false)}
        width="450px">
        <Space direction="vertical" style={{ width: "100%" }}>
          <Input
            placeholder="Họ tên"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
          <Input
            placeholder="Email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <Input
            placeholder="Số điện thoại"
            value={phoneNumber}
            onChange={(e) => setPhoneNumber(e.target.value)}
          />
          <DatePicker
            placeholder="Ngày sinh"
            value={birthday}
            onChange={(date) => setBirthday(date)}
          />
        </Space>
      </Modal>
      <Modal
        title="Chỉnh sửa địa chỉ"
        centered
        open={openLocationResponsive}
        onOk={handleEditLocation}
        onCancel={() => setOpenLocationResponsive(false)}
        width="450px">
        <Space direction="vertical" style={{ width: "100%" }}>
          <Input
            placeholder="Họ tên"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />

          <Input
            placeholder="Số điện thoại"
            value={phoneNumber}
            onChange={(e) => setPhoneNumber(e.target.value)}
          />
          <Input
            placeholder="Tỉnh"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <Input
            placeholder="Huyện"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <Input
            placeholder="Địa chỉ chi tiết"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />
          <MapPicker
            defaultLocation={defaultLocation}
            zoom={zoom}
            mapTypeId="roadmap"
            style={{ height: "400px" }}
            onChangeLocation={handleChangeLocation}
            onChangeZoom={handleChangeZoom}
            apiKey="AIzaSyD07E1VvpsN_0FvsmKAj4nK9GnLq-9jtj8"
          />
        </Space>
      </Modal>
    </>
  );
}
