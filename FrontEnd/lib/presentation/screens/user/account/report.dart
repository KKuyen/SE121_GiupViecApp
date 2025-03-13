import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/report/report_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/report/report_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/addReport.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/reportDetail.dart';

class ReportScreen extends StatefulWidget {
  final int accountId;
  const ReportScreen({super.key, required this.accountId});
  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  void _addNewReport() {}
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ReportCubit>(context).getReport(widget.accountId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReportCubit, ReportState>(
      builder: (context, state) {
        if (state is ReportLoading) {
          return Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: const Center(
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()))),
          );
        } else if (state is ReportSuccess) {
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
              decoration: const BoxDecoration(),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state
                    .Report.length, // Replace with the actual number of taskers
                itemBuilder: (context, index) {
                  // tam thoi comment
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ReportDetailScreen(
                                  complaintId: state.Report[index].id)));
                    },
                    child: Card(
                      color: const Color.fromARGB(255, 246, 246, 246),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.Report[index].id != null
                                  ? "Khiếu nại #${state.Report[index].id}"
                                  : "",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            if (state.Report[index].taskId != 0)
                              Text("TaskId: ${state.Report[index].taskId}"),
                            if (state.Report[index].taskerId != 0)
                              Text("TaskerId: ${state.Report[index].taskerId}"),
                            if (state.Report[index].type != null ||
                                state.Report[index].status != null)
                              Text(
                                "Type: ${state.Report[index].type ?? ''}    Status: ${state.Report[index].status ?? ''}",
                              ),
                            if (state.Report[index].description != null)
                              Text(
                                  "Description: ${state.Report[index].description}"),
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateReportScreen()));
              },
              backgroundColor: AppColors.xanh_main,
              shape: const CircleBorder(),
              child: const Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
              ),
            ),
          );
        } else if (state is ReportError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
