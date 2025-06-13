import React, { useEffect, useState } from "react";
import {
  Button,
  Col,
  Input,
  InputNumber,
  Modal,
  Row,
  Space,
  Table,
  DatePicker,
  Popconfirm,
  Checkbox,
  message,
} from "antd";
import {
  DeleteOutlined,
  EditOutlined,
  PlusCircleOutlined,
} from "@ant-design/icons";
import axios from "../../untils/axiosCustomize";
import moment from "moment";
import Upload from "antd/es/upload/Upload";
import ImgCrop from "antd-img-crop";

const Vouchers = () => {
  const [openResponsive, setOpenResponsive] = useState(false);
  const [openEditResponsive, setOpenEditResponsive] = useState(false);
  const [selectedVoucher, setSelectedVoucher] = useState(null); // State để lưu trữ voucher được chọn
  const [name, setName] = useState("");
  const [description, setDescription] = useState("");
  const [Rpoint, setRpoint] = useState(null);
  const [quantity, setQuantity] = useState(null);
  const [value, setValue] = useState(null);
  const [startDate, setStartDate] = useState(null);
  const [endDate, setEndDate] = useState(null);

  const { RangePicker } = DatePicker;
  const [data, setData] = useState([]);
  useEffect(() => {
    axios.get("/api/v1/get-all-vouchers").then((res) => {
      setData(res?.vouchers);
    });
  }, []);
  const [messageApi, contextHolder] = message.useMessage();

  const handleEditClick = (record) => {
    setSelectedVoucher(record); // Cập nhật state với dữ liệu của voucher được chọn
    setName(record.header);
    setDescription(record.content);
    setRpoint(record.RpointCost);
    setQuantity(record.quantity);
    setValue(record.value);
    setStartDate(moment(record.startDate));
    setEndDate(moment(record.endDate));
    setOpenEditResponsive(true); // Mở modal chỉnh sửa
  };

  const columns = [
    {
      title: "Tên voucher",
      dataIndex: "header",
      key: "header",
    },
    {
      title: "Mô tả",
      dataIndex: "content",
      key: "content",
    },
    {
      title: "Rpoint",
      dataIndex: "RpointCost",
      key: "RpointCost",
    },
    {
      title: "Số lượng",
      dataIndex: "quantity",
      key: "quantity",
    },
    {
      title: "Tỉ lệ giảm giá",
      dataIndex: "value",
      key: "value",
    },
    {
      title: "Ngày bắt đầu",
      key: "startDate",
      dataIndex: "startDate",
      render: (text) => moment(text).format("HH:mm  DD-MM-YYYY"), // Chuyển đổi định dạng ngày
    },
    {
      title: "Ngày kết thúc",
      key: "endDate",
      dataIndex: "endDate",
      render: (text) => moment(text).format("HH:mm  DD-MM-YYYY"), // Chuyển đổi định dạng ngày
    },
    {
      title: "Action",
      key: "action",
      render: (_, record) => (
        <Space size="middle">
          <EditOutlined onClick={() => handleEditClick(record)} />
          <Popconfirm
            title="Xóa voucher"
            description="Bạn có chắc chắn muốn xóa voucher này không?"
            onConfirm={() => confirmDeleteVoucher(record)}
            okText="Xóa"
            cancelText="Hủy">
            <DeleteOutlined style={{ color: "#ff4d4f" }} />
          </Popconfirm>
        </Space>
      ),
    },
  ];

  const confirmDeleteVoucher = (record) => {
    axios.delete(`/api/v1/delete-voucher?id=${record.id}`).then((res) => {
      if (res?.errCode === 0) {
        setData(data.filter((item) => item.id !== record.id));
        messageApi.open({
          type: "success",
          content: "Xóa voucher thành công!",
        });
      }
    });
  };

  const handelSaveVoucher = () => {
    // Xử lý thêm voucher
    const voucher = {
      header: name,
      content: description,
      RpointCost: Rpoint,
      quantity: quantity,
      value: value,
      startDate: startDate,
      endDate: endDate,
      isInfinity: false,
      image: "temp image",
      applyTasks: "ALL",
    };
    console.log("data", data);
    axios.post("/api/v1/add-voucher", voucher).then((res) => {
      if (res?.errCode === 0) {
        setOpenResponsive(false);
        setData([...data, voucher]);
        messageApi.open({
          type: "success",
          content: "Thêm voucher thành công!",
        });
      }
    });
  };

  const handelUpdateVoucher = () => {
    // Xử lý cập nhật voucher
    const updatedVoucher = {
      ...selectedVoucher,
      header: name,
      content: description,
      RpointCost: Rpoint,
      quantity: quantity,
      value: value,
      startDate: startDate,
      endDate: endDate,
    };
    console.log("updatedVoucher", updatedVoucher);
    axios.put(`/api/v1/edit-voucher`, updatedVoucher).then((res) => {
      if (res?.errCode === 0) {
        setOpenEditResponsive(false);
        setData(
          data.map((item) =>
            item.id === selectedVoucher.id ? updatedVoucher : item
          )
        );
        messageApi.open({
          type: "success",
          content: "Cập nhật voucher thành công!",
        });
      }
    });
  };

  const [fileList, setFileList] = useState([]);
  const onChange = ({ fileList: newFileList }) => {
    setFileList(newFileList);
  };
  const onPreview = async (file) => {
    let src = file.url;
    if (!src) {
      src = await new Promise((resolve) => {
        const reader = new FileReader();
        reader.readAsDataURL(file.originFileObj);
        reader.onload = () => resolve(reader.result);
      });
    }
    const image = new Image();
    image.src = src;
    const imgWindow = window.open(src);
    imgWindow?.document.write(image.outerHTML);
  };
  const CheckboxGroup = Checkbox.Group;
  const plainOptions = ["Dọn nhà", "Làm vườn", "Đi chợ", "Nấu ăn", "Giặt ủi"];
  const defaultCheckedList = [];
  const [checkedList, setCheckedList] = useState(defaultCheckedList);
  const checkAll = plainOptions.length === checkedList.length;
  const indeterminate =
    checkedList.length > 0 && checkedList.length < plainOptions.length;
  const onCheckChange = (list) => {
    setCheckedList(list);
  };
  const onCheckAllChange = (e) => {
    setCheckedList(e.target.checked ? plainOptions : []);
  };

  return (
    <div>
      <Row justify="space-between">
        <Col md={3}>
          <Button
            onClick={() => setOpenResponsive(true)}
            style={{
              backgroundColor: "#4AB7B6",
              color: "white",
              fontSize: "15px",
            }}>
            <Space>
              <PlusCircleOutlined />
              <span>Thêm ưu đãi</span>
            </Space>
          </Button>
        </Col>
      </Row>
      <Table
        columns={columns}
        pagination={{
          position: ["bottomCenter"],
          pageSize: 8,
        }}
        dataSource={data}
      />
      <Modal
        title="Thêm ưu đãi"
        centered
        open={openResponsive}
        onOk={handelSaveVoucher}
        onCancel={() => setOpenResponsive(false)}
        width="450px">
        <Space direction="vertical" style={{ width: "100%" }}>
          <Input
            placeholder="Tên voucher"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
          <Input
            placeholder="Mô tả"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
          />
          <InputNumber
            min={1}
            max={100}
            placeholder="Rpoint"
            value={Rpoint}
            onChange={(value) => setRpoint(value)}
          />
          <InputNumber
            min={1}
            max={100}
            placeholder="Số lượng"
            value={quantity}
            onChange={(value) => setQuantity(value)}
          />
          <InputNumber
            min={1}
            max={100}
            placeholder="Tỉ lệ ưu đãi"
            value={value}
            onChange={(value) => setValue(value)}
          />
          <RangePicker
            showTime
            value={[startDate, endDate]}
            onChange={(dates) => {
              setStartDate(dates[0]);
              setEndDate(dates[1]);
            }}
          />
          <Checkbox
            indeterminate={indeterminate}
            onChange={onCheckAllChange}
            checked={checkAll}>
            Check all
          </Checkbox>
          <CheckboxGroup
            options={plainOptions}
            value={checkedList}
            onChange={onCheckChange}
          />
          <ImgCrop rotationSlider>
            <Upload
              action="https://660d2bd96ddfa2943b33731c.mockapi.io/api/upload"
              listType="picture-card"
              fileList={fileList}
              onChange={onChange}
              onPreview={onPreview}>
              {fileList.length < 1 && "+ Upload"}
            </Upload>
          </ImgCrop>
        </Space>
      </Modal>
      <Modal
        title="Sửa ưu đãi"
        centered
        open={openEditResponsive}
        onOk={handelUpdateVoucher}
        onCancel={() => setOpenEditResponsive(false)}
        width="450px">
        <Space direction="vertical" style={{ width: "100%" }}>
          <Input
            placeholder="Tên voucher"
            value={name}
            onChange={(e) => setName(e.target.value)}
          />
          <Input
            placeholder="Mô tả"
            value={description}
            onChange={(e) => setDescription(e.target.value)}
          />
          <InputNumber
            min={1}
            max={100}
            placeholder="Rpoint"
            value={Rpoint}
            onChange={(value) => setRpoint(value)}
          />
          <InputNumber
            min={1}
            max={100}
            placeholder="Số lượng"
            value={quantity}
            onChange={(value) => setQuantity(value)}
          />
          <InputNumber
            min={1}
            max={100}
            placeholder="Tỉ lệ ưu đãi"
            value={value}
            onChange={(value) => setValue(value)}
          />
          <RangePicker
            showTime
            value={[startDate, endDate]}
            onChange={(dates) => {
              setStartDate(dates[0]);
              setEndDate(dates[1]);
            }}
          />
          <Checkbox
            indeterminate={indeterminate}
            onChange={onCheckAllChange}
            checked={checkAll}>
            Check all
          </Checkbox>
          <CheckboxGroup
            options={plainOptions}
            value={checkedList}
            onChange={onCheckChange}
          />
          <ImgCrop rotationSlider>
            <Upload
              action="https://660d2bd96ddfa2943b33731c.mockapi.io/api/upload"
              listType="picture-card"
              fileList={fileList}
              onChange={onChange}
              onPreview={onPreview}>
              {fileList.length < 1 && "+ Upload"}
            </Upload>
          </ImgCrop>
        </Space>
      </Modal>
    </div>
  );
};

export default Vouchers;
