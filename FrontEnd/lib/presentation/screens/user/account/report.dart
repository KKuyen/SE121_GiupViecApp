import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/addReport.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/reportDetail.dart';

class ReportScreen extends StatefulWidget {
  final int accountId;
  const ReportScreen({super.key, required this.accountId});
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<Map<String, dynamic>> reports = [
    {"id": 1, "type": "Pending", "status": "Pending", "description": "Pending"},
    {"id": 2, "type": "Resolved", "status": "Done", "description": "Resolved"},
  ];

  void _addNewReport() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        title: Text(
          'Khiếu nại',
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
        child: ListView.builder(
          itemCount: reports.length,
          itemBuilder: (context, index) {
            final report = reports[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReportDetailScreen()));
              },
              child: Card(
                color: const Color.fromARGB(255, 246, 246, 246),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Khiếu nại #${report['id']}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text("TaskId: ${report['id']}"),
                      Text(
                          "Type: ${report['type']}    Status: ${report['status']}"),
                      Text("Description: ${report['description']}"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateReportScreen()));
        },
        backgroundColor: AppColors.xanh_main,
        shape: const CircleBorder(),
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
      ),
    );
  }
}
