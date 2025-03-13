// lib/domain/repository/task_repository.dart

import 'package:se121_giupviec_app/domain/entities/complaint.dart';

abstract class ReportRepository {
  Future<List<Complaint>> getAllReport(int userId);
  Future<Complaint> getAReport(int ComplaintId);
}
