// lib/presentation/cubit/task_state.dart
import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/domain/entities/response.dart';

import '../../../domain/entities/voucher.dart';

abstract class VoucherState extends Equatable {
  const VoucherState();

  @override
  List<Object> get props => [];
  Object get prop => {};
}

class VoucherInitial extends VoucherState {}

class VoucherLoading extends VoucherState {}

class VoucherSuccess extends VoucherState {
  final List<Voucher> vouchers;

  const VoucherSuccess(this.vouchers);

  @override
  List<Object> get props => [vouchers];
}

class ResponseVoucherSuccess extends VoucherState {
  final Response response;

  const ResponseVoucherSuccess(this.response);

  @override
  Object get prop => response;
}

class VoucherError extends VoucherState {
  final String message;

  const VoucherError(this.message);

  @override
  List<Object> get props => [message];
}
