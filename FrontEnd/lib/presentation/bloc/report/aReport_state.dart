import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/complaint.dart';

abstract class AReportState extends Equatable {
  const AReportState();

  @override
  List<Object> get props => [];
}

class AReportInitial extends AReportState {}

class AReportLoading extends AReportState {}

class AReportSuccess extends AReportState {
  final Complaint report;

  const AReportSuccess(this.report);

  @override
  List<Object> get props => [report];
}

class AReportError extends AReportState {
  final String message;

  const AReportError(this.message);

  @override
  List<Object> get props => [message];
}
