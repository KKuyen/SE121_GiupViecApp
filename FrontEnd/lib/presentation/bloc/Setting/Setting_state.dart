import 'package:equatable/equatable.dart';
import 'package:se121_giupviec_app/data/models/setting_model.dart';

abstract class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

class SettingInitial extends SettingState {}

class SettingLoading extends SettingState {}

class SettingSuccess extends SettingState {
  final SettingModel? setting;

  const SettingSuccess(this.setting);

  @override
  List<Object> get props => [];
}

class SettingError extends SettingState {
  final String message;

  const SettingError(this.message);

  @override
  List<Object> get props => [message];
}
