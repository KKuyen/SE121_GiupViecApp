import React, { useState, useEffect } from "react";
import { Card, Row, Col, Select, Input } from "antd";
import { Bar } from "react-chartjs-2";
import "chart.js/auto";
import moment from "moment";
import { EditOutlined, CheckOutlined } from "@ant-design/icons";
import { getPaymentInfor } from "../../services/admnService";
import { getIncome } from "../../services/admnService";

const { Option } = Select;

const mockData = {
  "2025-02-01": 50,
  "2025-02-05": 70,
  "2025-02-10": 30,
  "2025-02-15": 90,
  "2025-02-20": 40,
};

const BankSelector = ({
  title,
  selectedBank,
  setSelectedBank,
  accountNumber,
  setAccountNumber,
}) => {
  const [isEditing, setIsEditing] = useState(false);
  const banks = ["Vietcombank", "Techcombank", "BIDV", "Agribank"];

  return (
    <Card title={title} bordered>
      {isEditing ? (
        <>
          <Input
            value={accountNumber}
            onChange={(e) => setAccountNumber(e.target.value)}
            autoFocus
            style={{ width: "80%" }}
          />
          <Select
            value={selectedBank}
            onChange={setSelectedBank}
            style={{ width: "80%", marginTop: 10 }}
          >
            {banks.map((bank) => (
              <Option key={bank} value={bank}>
                {bank}
              </Option>
            ))}
          </Select>
          <CheckOutlined
            onClick={() => setIsEditing(false)}
            style={{ cursor: "pointer", color: "green", marginLeft: 10 }}
          />
        </>
      ) : (
        <Row justify="space-between" align="middle">
          <div>
            <p style={{ margin: 0, fontWeight: "bold" }}>
              {accountNumber || "Chưa có số tài khoản"}
            </p>
            <p style={{ margin: 0 }}>{selectedBank}</p>
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
  const [phone, setPhone] = useState(null);
  const [isEditingPhone, setIsEditingPhone] = useState(false);
  const [selectedBank, setSelectedBank] = useState("Vietcombank");
  const [accountNumber, setAccountNumber] = useState("");
  const [selectedSubBank, setSelectedSubBank] = useState("Techcombank");
  const [subAccountNumber, setSubAccountNumber] = useState("");
  const [totalIncome, setTotalIncome] = useState(0);
  const [totalTask, setTotalTask] = useState(0);
  useEffect(() => {
    const fetchPaymentInfo = async () => {
      try {
        const data = await getPaymentInfor();
        setPhone(data.paymentInformation[0].momo);
        setSelectedBank(data.paymentInformation[0].bankAccountName);
        setAccountNumber(data.paymentInformation[0].bankAccount);
        setSelectedSubBank(data.paymentInformation[0].subBankAccountName);
        setSubAccountNumber(data.paymentInformation[0].subBankAccount);
      } catch (err) {
        console.error("Error fetching payment info:", err);
      }
    };
    fetchPaymentInfo();
  }, []);

  useEffect(() => {
    const fetchIncomeData = async () => {
      try {
        const res = await getIncome(selectedMonth, selectedYear);
        const mockData = res.income;
        setTotalIncome(res.totalIncome);
        setTotalTask(res.totalTasks);
        const labels = Array.from({ length: 30 }, (_, i) =>
          moment(`${selectedYear}-${selectedMonth}-01`)
            .add(i, "days")
            .format("YYYY-MM-DD")
        );
        const dataValues = labels.map((date) => mockData[date] || 0);
        setChartData({
          labels,
          datasets: [
            { label: "Income", data: dataValues, backgroundColor: "#6A5ACD" },
          ],
        });
      } catch (err) {
        console.error("Error fetching income data:", err);
      }
    };
    fetchIncomeData();
  }, [selectedMonth, selectedYear]);

  return (
    <div style={{ padding: 20 }}>
      <Row gutter={16}>
        <Col span={8}>
          <Card title="Momo" bordered>
            {isEditingPhone ? (
              <Row justify="space-between" align="middle">
                <Input
                  value={phone}
                  onChange={(e) => setPhone(e.target.value)}
                  autoFocus
                  style={{ width: "80%" }}
                />
                <CheckOutlined
                  onClick={() => setIsEditingPhone(false)}
                  style={{ cursor: "pointer", color: "green" }}
                />
              </Row>
            ) : (
              <Row justify="space-between" align="middle">
                <p style={{ margin: 0 }}>{phone}</p>
                <EditOutlined
                  onClick={() => setIsEditingPhone(true)}
                  style={{ cursor: "pointer" }}
                />
              </Row>
            )}
          </Card>
        </Col>
        <Col span={8}>
          <BankSelector
            title="Ngân hàng chính"
            selectedBank={selectedBank}
            setSelectedBank={setSelectedBank}
            accountNumber={accountNumber}
            setAccountNumber={setAccountNumber}
          />
        </Col>
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

      <Row gutter={16} style={{ marginTop: 20 }}>
        <Col span={12}>
          <Select
            value={selectedMonth}
            onChange={(v) => setSelectedMonth(v)}
            style={{ width: "100%" }}
          >
            {Array.from({ length: 12 }, (_, i) => (
              <Option key={i + 1} value={i + 1}>
                Tháng {i + 1}
              </Option>
            ))}
          </Select>
        </Col>
        <Col span={12}>
          <Select
            value={selectedYear}
            onChange={(v) => setSelectedYear(v)}
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

      <Row gutter={16} style={{ marginTop: 20 }}>
        <Col span={12}>
          <Card title="Income">
            <h2>{totalIncome} đ</h2>
          </Card>
        </Col>
        <Col span={12}>
          <Card title="Tasks">
            <h2>{totalTask}</h2>
          </Card>
        </Col>
      </Row>

      <Card title="Attendance Overview" style={{ marginTop: 20 }}>
        <Bar data={chartData} />
      </Card>
    </div>
  );
};

export default FinanceDashboard;
