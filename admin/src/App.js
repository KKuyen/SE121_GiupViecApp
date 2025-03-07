import React from "react";
import {
  DownOutlined,
  UploadOutlined,
  UserOutlined,
  VideoCameraOutlined,
} from "@ant-design/icons";
import { Button, Col, Dropdown, Layout, Menu, Row, Space, theme } from "antd";
import { useNavigate } from "react-router";
import { Outlet } from "react-router";
const { Header, Content, Footer, Sider } = Layout;
const menuProps = [
  {
    key: 2,
    label: "Đăng xuất",
  },
];
const items = [
  {
    key: 1,
    icon: React.createElement(UploadOutlined),
    label: "Khách hàng",
  },
  {
    key: 2,
    icon: React.createElement(UserOutlined),
    label: "Hoạt động",
  },
  {
    key: 3,
    icon: React.createElement(VideoCameraOutlined),
    label: "Dịch vụ",
  },
  {
    key: 4,
    icon: React.createElement(UploadOutlined),
    label: "Tài chính",
  },
  {
    key: 5,
    icon: React.createElement(UploadOutlined),
    label: "Khiếu nại",
  },
  {
    key: 6,
    icon: React.createElement(UploadOutlined),
    label: "Ưu đãi",
  },
];

const App = () => {
  const nav = useNavigate();
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();
  return (
    <Layout>
      <Sider
        breakpoint="lg"
        collapsedWidth="0"
        onBreakpoint={(broken) => {
          console.log(broken);
        }}
        onCollapse={(collapsed, type) => {
          console.log(collapsed, type);
        }}>
        <div className="demo-logo-vertical" />
        <Menu
          theme="dark"
          mode="vertical "
          defaultSelectedKeys={["1"]}
          items={items}
          onClick={(e) => {
            switch (e.key) {
              case "1":
                nav("/");
                break;
              case "2":
                nav("/activities");
                break;
              case "3":
                nav("/services");
                break;
              case "4":
                nav("/finance");
                break;
              case "5":
                nav("/report");
                break;
              case "6":
                nav("/vouchers");
                break;
              default:
                break;
            }
          }}
        />
      </Sider>
      <Layout>
        <Header
          style={{
            padding: 0,
            background: colorBgContainer,
          }}>
          <Row>
            <Col md={18}></Col>
            <Col md={6}>
              <Dropdown menu={menuProps}>
                <Button>
                  <Space>
                    Button
                    <DownOutlined />
                  </Space>
                </Button>
              </Dropdown>
            </Col>
          </Row>
        </Header>
        <Content
          style={{
            margin: "14px  10px 0",
          }}>
          <div
            style={{
              padding: 24,
              minHeight: "90vh",
              background: colorBgContainer,
              borderRadius: borderRadiusLG,
            }}>
            <Outlet />
          </div>
        </Content>
      </Layout>
    </Layout>
  );
};
export default App;
