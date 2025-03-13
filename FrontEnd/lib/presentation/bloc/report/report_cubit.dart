// lib/presentation/cubit/task_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:se121_giupviec_app/domain/entities/complaint.dart';
import 'package:se121_giupviec_app/domain/usecases/get_all_report_usecase.dart';

import 'package:se121_giupviec_app/presentation/bloc/report/report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final GetAllReportUsecase getReportsUsercase;

  ReportCubit({required this.getReportsUsercase}) : super(ReportInitial());

  Future<void> getReport(int userId) async {
    emit(ReportLoading());
    try {
      print("chay vao Reportcubit");

      final List<Complaint> reportList =
          (await getReportsUsercase.execute(userId));

      emit(ReportSuccess(reportList));
    } catch (e) {
      emit(ReportError(e.toString()));
    }
  }
}
