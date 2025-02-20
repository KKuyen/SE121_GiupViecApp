import React from "react";
import {
  DownOutlined,
  UploadOutlined,
  UserOutlined,
  VideoCameraOutlined,
  LogoutOutlined,
  AppstoreOutlined,
  SolutionOutlined,
  DollarOutlined,
  FileExclamationOutlined,
  GiftOutlined,
} from "@ant-design/icons";
import {
  Avatar,
  Breadcrumb,
  Button,
  Col,
  Dropdown,
  Image,
  Layout,
  Menu,
  Row,
  Space,
  theme,
  ConfigProvider,
} from "antd";
import { useNavigate } from "react-router";
import { Outlet } from "react-router";
const { Header, Content, Footer, Sider } = Layout;

const items = [
  {
    key: 1,
    icon: React.createElement(UserOutlined),
    label: "Người dùng",
  },
  {
    key: 2,
    icon: React.createElement(AppstoreOutlined),
    label: "Hoạt động",
  },
  {
    key: 3,
    icon: React.createElement(SolutionOutlined),
    label: "Dịch vụ",
  },
  {
    key: 4,
    icon: React.createElement(DollarOutlined),
    label: "Tài chính",
  },
  {
    key: 5,
    icon: React.createElement(FileExclamationOutlined),
    label: "Khiếu nại",
  },
  {
    key: 6,
    icon: React.createElement(GiftOutlined),

    label: "Ưu đãi",
  },
];

const menuProps = [
  {
    key: 2,
    label: "Đăng xuất",
    icon: React.createElement(LogoutOutlined),
  },
];

const App = () => {
  const nav = useNavigate();
  const [isShowLogo, setIsShowLogo] = React.useState(true);
  const {
    token: { colorBgContainer, borderRadiusLG },
  } = theme.useToken();
  return (
    <ConfigProvider
      theme={{
        token: {
          colorPrimary: "#4AB7B6", // Green color
        },
      }}>
      <Layout>
        <Sider
          theme="light"
          breakpoint="lg"
          collapsedWidth="50px"
          onBreakpoint={(broken) => {
            console.log(broken);
          }}
          onCollapse={(collapsed, type) => {
            console.log(collapsed, type);
            setIsShowLogo(!isShowLogo);
          }}>
          {isShowLogo && (
            <Image
              src={require("./assets/images/TaskMate.png")}
              width={120}
              style={{ margin: 27 }}
            />
          )}

          <Menu
            theme="light"
            mode="vertical"
            defaultSelectedKeys={["1"]}
            items={items.map((item) => ({
              ...item,
              icon: React.cloneElement(item.icon, {
                style: { fontSize: "18px" },
              }),
              label: <span style={{ fontSize: "16px" }}>{item.label}</span>,
            }))}
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
            <Row justify="space-between">
              <span
                style={{
                  color: "black",
                  fontSize: "1rem",
                  marginLeft: "1rem",
                  fontWeight: "bold",
                }}>
                Khách hàng
              </span>
              <Dropdown overlay={<Menu items={menuProps} />}>
                <div>
                  <Button>
                    <Space>
                      <Avatar size="small" icon={<UserOutlined />} />
                      {isShowLogo && <span>Nguyễn Văn A</span>}
                      <DownOutlined />
                    </Space>
                  </Button>
                </div>
              </Dropdown>
            </Row>
          </Header>
          <Content
            style={{
              margin: "10px  10px 0",
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
    </ConfigProvider>
  );
};
export default App;
