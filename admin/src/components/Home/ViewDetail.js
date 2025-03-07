import { Button, Col, Image, Row } from "antd";
import React, { useEffect } from "react";
import { useSearchParams } from "react-router";
import "./ViewDetail.scss";
import { EditOutlined, MailOutlined, PhoneOutlined } from "@ant-design/icons";

export default function ViewDetail({ record }) {
  const [searchParams] = useSearchParams();
  const userId = searchParams.get("userId");
  useEffect(() => {
    // Call API
    console.log("userId", userId);
  }, [record]);
  return (
    <>
      <Row className="top-card">
        <Col span={3}>
          <Image
            className="avatar"
            src={require("../../assets/images/capy.jpeg")}
            width={100}
          />
        </Col>
        <Col span={17}>
          <div className="name">Nguyễn Duy Hưng</div>
          <div className="phone">
            <PhoneOutlined />
            0345664024
          </div>
          <div className="mail">
            <MailOutlined />
            hung@gmail.com
          </div>
        </Col>
        <Col span={4}>
          {" "}
          <Button type="primary" icon={<EditOutlined />}>
            Chỉnh sửa
          </Button>
        </Col>
      </Row>
    </>
  );
}
