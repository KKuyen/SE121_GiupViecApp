import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/report/aReport_cubit.dart';

class CreateReportScreen extends StatefulWidget {
  final int? taskId;
  final int? userId;
  const CreateReportScreen({super.key, this.taskId, this.userId});

  @override
  _CreateReportScreenState createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  late final TextEditingController _taskIdController;
  late final TextEditingController _userIdController;
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _issueTypes = [
    "Người giúp việc",
    "Thanh toán",
    "Chất lượng dịch vụ",
    "Thời gian làm việc",
    "Thái độ phục vụ",
    "Ứng dụng/Giao diện",
    "Khác"
  ];
  String _selectedType = "Người giúp việc"; // Giá trị mặc định

  @override
  void initState() {
    super.initState();
    _taskIdController = TextEditingController(
        text: widget.taskId != null ? widget.taskId.toString() : '');
    _userIdController = TextEditingController(
        text: widget.userId != null ? widget.userId.toString() : '');
  }

  void _submitReport() {
    if (_taskIdController.text.isEmpty ||
        _userIdController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng điền đầy đủ thông tin!")),
      );
      return;
    }

    int taskId = int.tryParse(_taskIdController.text) ?? 0;
    int userId = int.tryParse(_userIdController.text) ?? 0;
    String description = _descriptionController.text;

    context.read<AReportCubit>().createReport(
          taskId,
          _selectedType,
          description,
          1, // customerId (giả định)
          userId,
        );

    Navigator.pop(context); // Đóng màn hình sau khi gửi
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const BasicAppbar(
        title: Text(
          'Tạo khiếu nại',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        isHideBackButton: false,
        isHavePadding: true,
        color: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text("Vấn đề: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: _selectedType,
                    items: _issueTypes
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedType = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _taskIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "ID dịch vụ (nếu có)",
                  border: OutlineInputBorder(),
                  prefixText: "#DV ",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _userIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "ID Tasker (nếu có)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text("Mô tả",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitReport,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.xanh_main,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("Tạo",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
