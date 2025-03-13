import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/complaint.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportSuccess extends ReportState {
  final List<Complaint> Report;

  const ReportSuccess(this.Report);

  @override
  List<Object> get props => [Report];
}

class ReportError extends ReportState {
  final String message;

  const ReportError(this.message);

  @override
  List<Object> get props => [message];
}
