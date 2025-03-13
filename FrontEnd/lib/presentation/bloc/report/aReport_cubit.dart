// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:se121_giupviec_app/domain/entities/complaint.dart';
import 'package:se121_giupviec_app/domain/usecases/get_all_report_usecase.dart';
import 'package:se121_giupviec_app/presentation/bloc/report/aReport_state.dart';

import 'package:se121_giupviec_app/presentation/bloc/report/report_state.dart';

class AReportCubit extends Cubit<AReportState> {
  final GetAllReportUsecase getReportsUsercase;

  AReportCubit({required this.getReportsUsercase}) : super(AReportInitial());

  Future<void> getAReport(int complaintId) async {
    emit(AReportLoading());
    try {
      print("chay vao Reportcubit");

      final Complaint reportList =
          (await getReportsUsercase.execute2(complaintId));

      emit(AReportSuccess(reportList));
    } catch (e) {
      emit(AReportError(e.toString()));
    }
  }

  Future<void> createReport(int taskId, String type, String description,
      int customerId, int taskerId) async {
    try {
      print("Chạy vào ReportCubit");

      await getReportsUsercase.execute3(
          taskId, type, description, customerId, taskerId);

      print("Tạo báo cáo thành công");
    } catch (e, stackTrace) {
      print("Lỗi trong createReport: $e");
      print(stackTrace);
    }
  }
}
