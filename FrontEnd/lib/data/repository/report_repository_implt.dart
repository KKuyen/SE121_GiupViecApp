import 'package:se121_giupviec_app/data/datasources/allReport_remote_datasource.dart';

import 'package:se121_giupviec_app/domain/entities/complaint.dart';

import 'package:se121_giupviec_app/domain/repository/all_repoort_repository.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDatasource remoteDataSource;

  ReportRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Complaint>> getAllReport(int userId) async {
    return await remoteDataSource.getAllReport(userId);
  }

  @override
  Future<Complaint> getAReport(int ComplaintId) async {
    return await remoteDataSource.getAReport(ComplaintId);
  }
}
