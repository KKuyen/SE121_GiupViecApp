import React, { useState } from "react";
import { Card, Table, Avatar, Input, Button, List } from "antd";

const { TextArea } = Input;

const ReportDetail = () => {
  const [messages, setMessages] = useState([
    { id: 1, text: "Hello!", sender: "customer" },
    { id: 2, text: "Hi, how can I help you?", sender: "tasker" },
  ]);
  const [newMessage, setNewMessage] = useState("");

  const sendMessage = () => {
    if (newMessage.trim() === "") return;

    const newMsg = { id: Date.now(), text: newMessage, sender: "customer" };
    setMessages([...messages, newMsg]);
    setNewMessage("");
  };

  const taskData = [
    {
      key: "1",
      ID: "2123",
      TaskID: "2123",
      Type: "2123",
      Status: "12",
    },
  ];

  const columns = [
    { title: "ID", dataIndex: "ID", key: "ID" },
    { title: "TaskID", dataIndex: "TaskID", key: "TaskID" },
    { title: "Type", dataIndex: "Type", key: "Type" },
    { title: "Status", dataIndex: "Status", key: "Status" },
  ];

  return (
    <div>
      {/* Thông tin Task */}
      <Card title="Information">
        <Table
          columns={columns}
          dataSource={taskData}
          pagination={false}
          size="small"
        />

        <div
          style={{
            display: "flex",

            marginTop: 20,
            gap: 400,
          }}
        >
          <div>
            <strong>Customer</strong>
            <div
              style={{ display: "flex", alignItems: "center", marginTop: 10 }}
            >
              <Avatar size={40} />
              <div style={{ marginLeft: 30 }}>
                <div>ID: 123</div>
                <div>Name: John Doe</div>
              </div>
            </div>
          </div>

          <div style={{ marginLeft: 100 }}>
            <strong>Tasker</strong>
            <div
              style={{
                display: "flex",
                alignItems: "center",
                marginTop: 10,
              }}
            >
              <Avatar size={40} />
              <div style={{ marginLeft: 30 }}>
                <div>ID: 456</div>
                <div>Name: Jane Smith</div>
              </div>
            </div>
          </div>
        </div>
      </Card>

      {/* Khung chat */}
      <Card title="Chat" style={{ marginTop: 20 }}>
        <div
          style={{
            height: 400,
            overflowY: "auto",
            padding: 10,
            borderBottom: "1px solid #ddd",
          }}
        >
          <List
            dataSource={messages}
            renderItem={(msg) => (
              <List.Item
                style={{
                  display: "flex",
                  justifyContent:
                    msg.sender === "customer" ? "flex-end" : "flex-start",
                }}
              >
                {msg.sender === "tasker" && (
                  <Avatar style={{ marginRight: 10 }}>T</Avatar>
                )}
                <div
                  style={{
                    padding: "8px 12px",
                    borderRadius: 8,
                    background:
                      msg.sender === "customer" ? "#1890ff" : "#f0f0f0",
                    color: msg.sender === "customer" ? "#fff" : "#000",
                    maxWidth: "70%", // Giới hạn chiều rộng để đảm bảo tin nhắn không quá dài
                    wordBreak: "break-word", // Tự động xuống dòng nếu quá dài
                    whiteSpace: "pre-wrap", // Giữ nguyên định dạng xuống dòng (nếu có)
                  }}
                >
                  {msg.text}
                </div>
                {msg.sender === "customer" && (
                  <Avatar style={{ marginLeft: 10 }}>C</Avatar>
                )}
              </List.Item>
            )}
          />
        </div>

        <div style={{ display: "flex", paddingTop: 10 }}>
          <TextArea
            rows={1}
            value={newMessage}
            onChange={(e) => setNewMessage(e.target.value)}
            placeholder="Type a message..."
          />
          <Button
            type="primary"
            onClick={sendMessage}
            style={{ marginLeft: 10 }}
          >
            Send
          </Button>
        </div>
      </Card>
    </div>
  );
};

export default ReportDetail;
