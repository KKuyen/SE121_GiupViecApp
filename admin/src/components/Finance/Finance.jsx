import React, { useState, useEffect } from "react";
import { Card, Row, Col, Select, Input } from "antd";
import { Bar } from "react-chartjs-2";
import "chart.js/auto";
import moment from "moment";
import { EditOutlined, CheckOutlined } from "@ant-design/icons";

const { Option } = Select;

const mockData = {
  "2025-02-01": 50,
  "2025-02-05": 70,
  "2025-02-10": 30,
  "2025-02-15": 90,
  "2025-02-20": 40,
};

// Component chọn ngân hàng + nhập số tài khoản (dùng chung 1 nút sửa)
const BankSelector = ({
  title,
  selectedBank,
  setSelectedBank,
  accountNumber,
  setAccountNumber,
}) => {
  const [isEditing, setIsEditing] = useState(false);

  const banks = [
    { name: "Vietcombank", logo: "https://logo.vietcombank.com" },
    { name: "Techcombank", logo: "https://logo.techcombank.com" },
    { name: "BIDV", logo: "https://logo.bidv.com" },
    { name: "Agribank", logo: "https://logo.agribank.com" },
  ];

  const saveChanges = () => {
    setIsEditing(false);
  };

  return (
    <Card title={title} bordered>
      {isEditing ? (
        <>
          {/* Chọn ngân hàng */}
          <Row
            style={{
              display: "flex",
              justifyContent: "space-between",
              alignItems: "center",
              marginBottom: 10,
            }}
          >
            <Select
              value={selectedBank}
              onChange={setSelectedBank}
              style={{ width: "80%" }}
            >
              {banks.map((bank) => (
                <Option key={bank.name} value={bank.name}>
                  <img
                    src={bank.logo}
                    alt={bank.name}
                    style={{ width: 20, marginRight: 10 }}
                  />
                  {bank.name}
                </Option>
              ))}
            </Select>
          </Row>

          {/* Nhập số tài khoản */}
          <Row
            style={{
              display: "flex",
              justifyContent: "space-between",
              alignItems: "center",
            }}
          >
            <Input
              value={accountNumber}
              onChange={(e) => setAccountNumber(e.target.value)}
              autoFocus
              style={{ width: "80%" }}
            />
            <CheckOutlined
              onClick={saveChanges}
              style={{ cursor: "pointer", color: "green" }}
            />
          </Row>
        </>
      ) : (
        <Row
          style={{
            display: "flex",
            justifyContent: "space-between",
            alignItems: "center",
          }}
        >
          <div>
            <p style={{ margin: 0, fontWeight: "bold" }}>{selectedBank}</p>
            <p style={{ margin: 0 }}>
              {accountNumber || "Chưa có số tài khoản"}
            </p>
          </div>
          <EditOutlined
            onClick={() => setIsEditing(true)}
            style={{ cursor: "pointer" }}
          />
        </Row>
      )}
    </Card>
  );
};

const FinanceDashboard = () => {
  const [selectedMonth, setSelectedMonth] = useState(moment().month() + 1);
  const [selectedYear, setSelectedYear] = useState(moment().year());
  const [chartData, setChartData] = useState({ labels: [], datasets: [] });
  const [phone, setPhone] = useState("03992342133");
  const [isEditingPhone, setIsEditingPhone] = useState(false);

  const [selectedBank, setSelectedBank] = useState("Vietcombank");
  const [accountNumber, setAccountNumber] = useState(""); // Số tài khoản ngân hàng chính

  const [selectedSubBank, setSelectedSubBank] = useState("Techcombank");
  const [subAccountNumber, setSubAccountNumber] = useState(""); // Số tài khoản ngân hàng phụ

  // Cập nhật biểu đồ khi tháng/năm thay đổi
  useEffect(() => {
    const daysInMonth = 30;
    const labels = Array.from({ length: daysInMonth }, (_, i) =>
      moment(
        `${selectedYear}-${
          selectedMonth < 10 ? `0${selectedMonth}` : selectedMonth
        }-01`
      )
        .add(i, "days")
        .format("YYYY-MM-DD")
    );

    const dataValues = labels.map((date) => mockData[date] || 0);

    setChartData({
      labels,
      datasets: [
        {
          label: "Attendance",
          data: dataValues,
          backgroundColor: "#6A5ACD",
        },
      ],
    });
  }, [selectedMonth, selectedYear]);

  const handleSavePhone = () => {
    setIsEditingPhone(false);
  };
  const handleDateChange = (month, year) => {
    setSelectedMonth(month);
    setSelectedYear(year);
  };

  return (
    <div style={{ padding: 20 }}>
      <Row gutter={16}>
        {/* Số điện thoại Momo */}
        <Col span={8}>
          <Card title="Momo" bordered>
            {isEditingPhone ? (
              <Row
                style={{
                  display: "flex",
                  justifyContent: "space-between",
                  alignItems: "center",
                }}
              >
                <Input
                  value={phone}
                  onChange={(e) => setPhone(e.target.value)}
                  onPressEnter={handleSavePhone}
                  onBlur={handleSavePhone}
                  autoFocus
                  style={{ width: "80%" }}
                />
                <CheckOutlined
                  onClick={handleSavePhone}
                  style={{ cursor: "pointer", color: "green" }}
                />
              </Row>
            ) : (
              <Row
                style={{
                  display: "flex",
                  justifyContent: "space-between",
                  alignItems: "center",
                }}
              >
                <p style={{ margin: 0 }}>{phone}</p>
                <EditOutlined
                  onClick={() => setIsEditingPhone(true)}
                  style={{ cursor: "pointer" }}
                />
              </Row>
            )}
          </Card>
        </Col>

        {/* Chọn ngân hàng chính */}
        <Col span={8}>
          <BankSelector
            title="Ngân hàng chính"
            selectedBank={selectedBank}
            setSelectedBank={setSelectedBank}
            accountNumber={accountNumber}
            setAccountNumber={setAccountNumber}
          />
        </Col>

        {/* Chọn ngân hàng phụ */}
        <Col span={8}>
          <BankSelector
            title="Ngân hàng phụ"
            selectedBank={selectedSubBank}
            setSelectedBank={setSelectedSubBank}
            accountNumber={subAccountNumber}
            setAccountNumber={setSubAccountNumber}
          />
        </Col>
      </Row>

      {/* Chọn tháng & năm */}
      <Row gutter={16} style={{ marginTop: 20 }}>
        <Col span={12}>
          <Select
            value={selectedMonth}
            onChange={(value) => handleDateChange(value, selectedYear)}
            style={{ width: "100%" }}
          >
            {Array.from({ length: 12 }, (_, i) => (
              <Option key={i + 1} value={i + 1}>{`Tháng ${i + 1}`}</Option>
            ))}
          </Select>
        </Col>
        <Col span={12}>
          <Select
            value={selectedYear}
            onChange={(value) => handleDateChange(selectedMonth, value)}
            style={{ width: "100%" }}
          >
            {Array.from({ length: 5 }, (_, i) => (
              <Option key={2023 + i} value={2023 + i}>
                {2023 + i}
              </Option>
            ))}
          </Select>
        </Col>
      </Row>

      {/* Thống kê tổng quan */}
      <Row gutter={16} style={{ marginTop: 20 }}>
        <Col span={12}>
          <Card title="Income">
            <p>03992342133 đ</p>
          </Card>
        </Col>
        <Col span={12}>
          <Card title="Tasks">
            <p>220</p>
          </Card>
        </Col>
      </Row>

      {/* Biểu đồ */}
      <Card title="Attendance Overview" style={{ marginTop: 20 }}>
        <Bar data={chartData} />
      </Card>
    </div>
  );
};

export default FinanceDashboard;
