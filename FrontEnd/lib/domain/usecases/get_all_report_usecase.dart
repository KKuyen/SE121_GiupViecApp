// lib/domain/usecases/get_all_tasks_usecase.dart

import 'package:se121_giupviec_app/domain/entities/complaint.dart';
import 'package:se121_giupviec_app/domain/entities/loveTasker.dart';
import 'package:se121_giupviec_app/domain/repository/all_repoort_repository.dart';

class GetAllReportUsecase {
  final ReportRepository repository;

  GetAllReportUsecase(this.repository);

  Future<List<Complaint>> execute(int userId) async {
    return await repository.getAllReport(userId);
  }

  Future<Complaint> execute2(int ComplanitId) async {
    return await repository.getAReport(ComplanitId);
  }

  Future<void> execute3(int taskId, String type, String description,
      int customerId, int taskerId) async {
    await repository.createReport(
        taskId, type, description, customerId, taskerId);
  }
}
