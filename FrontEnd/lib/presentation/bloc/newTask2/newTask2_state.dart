import 'package:equatable/equatable.dart';

import 'package:se121_giupviec_app/domain/entities/location.dart';
import 'package:se121_giupviec_app/domain/entities/voucher.dart';

abstract class NewTask2State extends Equatable {
  const NewTask2State();

  @override
  List<Object> get props => [];
}

class NewTask2Initial extends NewTask2State {}

class NewTask2Loading extends NewTask2State {}

class NewTask2Success extends NewTask2State {
  final Location? dfLocation;
  final List<Location>? Mylocations;
  final List<Voucher>? vouchers;

  const NewTask2Success(this.dfLocation, this.Mylocations, this.vouchers);

  @override
  List<Object> get props => [];
}

class NewTask2Error extends NewTask2State {
  final String message;

  const NewTask2Error(this.message);

  @override
  List<Object> get props => [message];
}
