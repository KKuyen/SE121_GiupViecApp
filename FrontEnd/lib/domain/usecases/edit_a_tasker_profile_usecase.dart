import 'package:se121_giupviec_app/domain/entities/response.dart';
import 'package:se121_giupviec_app/domain/repository/tasker_repository.dart';

class EditATaskerProfileUsecase {
  final TaskerRepository repository;

  EditATaskerProfileUsecase(this.repository);

  Future<Response> execute(
      int taskerId,
      String name,
      String email,
      String phoneNumber,
      String avatar,
      String introduction,
      String taskList) async {
    return await repository.editATasker(
        taskerId, name, email, phoneNumber, avatar, introduction, taskList);
  }
}
