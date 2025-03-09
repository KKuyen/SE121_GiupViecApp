import React, { useEffect, useState } from "react";
import { Card, Table, Avatar, Input, Button, List } from "antd";
import { getAcomplaint, getUser } from "../../services/admnService";
import { EyeOutlined } from "@ant-design/icons";
const { TextArea } = Input;

const ReportDetail = () => {
  const [taskData, setTaskData] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [user, setUser] = useState(null);
  const [tasker, setTasker] = useState(null);
  const [messages, setMessages] = useState([
    { id: 1, text: "Hello!", sender: "customer" },
    { id: 2, text: "Hi, how can I help you?", sender: "tasker" },
  ]);
  const [newMessage, setNewMessage] = useState("");

  useEffect(() => {
    const fetchTaskData = async () => {
      try {
        const idd = window.location.pathname.split("/")[2];
        const response = await getAcomplaint(idd);
        const uresponse = await getUser(response.complaint.customerId);
        const tresponse = await getUser(response.complaint.taskerId);
        const uuser = uresponse.user;
        const ttasker = tresponse.user;
        setUser(uuser);
        setTasker(ttasker);

        if (response?.complaint) {
          setTaskData([response.complaint]);
        } else {
          setTaskData([]);
        }
      } catch (error) {
        console.error("Failed to fetch task detail:", error);
        setError("Failed to load task data");
      } finally {
        setLoading(false);
      }
    };

    fetchTaskData();
  }, []);

  const sendMessage = () => {
    if (newMessage.trim() === "") return;

    const newMsg = { id: Date.now(), text: newMessage, sender: "customer" };
    setMessages([...messages, newMsg]);
    setNewMessage("");
  };

  const columns = [
    { title: "ID", dataIndex: "id", key: "ID" },
    { title: "TaskID", dataIndex: "taskId", key: "TaskID" },
    { title: "Type", dataIndex: "type", key: "Type" },
    { title: "Status", dataIndex: "status", key: "Status" },
  ];

  return (
    <div>
      {/* Thông tin Task */}
      <Card title="Information">
        {loading ? (
          <p>Loading...</p>
        ) : error ? (
          <p style={{ color: "red" }}>{error}</p>
        ) : (
          <>
            <Table
              columns={columns}
              dataSource={taskData}
              pagination={false}
              size="small"
              rowKey="id"
            />
            <h4>Description</h4>
            <div>{taskData.length > 0 ? taskData[0].description : "N/A"}</div>
          </>
        )}
        <div
          style={{
            display: "flex",
            flexWrap: "wrap",
            justifyContent: "space-between",
            gap: 50, // Khoảng cách giữa 2 phần
            marginTop: 20,
          }}
        >
          <div
            style={{
              flex: "1 1 300px", // Chiếm 1 phần, co dãn, tối thiểu 300px
              maxWidth: "50%", // Không vượt quá 50%
            }}
          >
            <strong>Customer</strong>
            <div
              style={{ display: "flex", alignItems: "center", marginTop: 10 }}
            >
              <Avatar size={40} />
              <div style={{ marginLeft: 20 }}>
                <div>
                  ID: {taskData.length > 0 ? taskData[0].taskerId : "N/A"}
                </div>
                {user && tasker && <div>Name: {user.name}</div>}
              </div>
              <EyeOutlined style={{ marginLeft: "auto" }} />
            </div>
          </div>

          <div
            style={{
              flex: "1 1 300px",
              maxWidth: "50%",
            }}
          >
            <strong>Tasker</strong>
            <div
              style={{ display: "flex", alignItems: "center", marginTop: 10 }}
            >
              <Avatar size={40} />
              <div style={{ marginLeft: 20 }}>
                <div>
                  ID: {taskData.length > 0 ? taskData[0].taskerId : "N/A"}
                </div>
                {user && tasker && <div>Name: {tasker.name}</div>}
              </div>
              <EyeOutlined style={{ marginLeft: "auto" }} />
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
                    maxWidth: "70%",
                    wordBreak: "break-word",
                    whiteSpace: "pre-wrap",
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
