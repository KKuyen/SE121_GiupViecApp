import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/Auth/auth_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/Auth/auth_state.dart';
import 'package:se121_giupviec_app/presentation/screens/tasker/account/account.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../../core/configs/assets/app_images.dart';
import '../../../../domain/entities/taskType.dart';
import '../../../../domain/entities/tasker_info.dart';
import '../../../bloc/TaskType/get_all_tasktype_cubit.dart';
import '../../../bloc/TaskType/get_all_tasktype_state.dart';
import '../../../bloc/tasker/tasker_cubit.dart';
import '../../../bloc/tasker/tasker_state.dart';

class EditAccountTaskerPage extends StatefulWidget {
  final AccountTaskerPage parrent;
  final TaskerInfo tasker;
  final List<TaskType> taskTypeList;
  EditAccountTaskerPage(
      {required this.parrent,
      required this.tasker,
      required this.taskTypeList,
      super.key});

  @override
  State<EditAccountTaskerPage> createState() => _EditAccountTaskerPageState();
}

class _EditAccountTaskerPageState extends State<EditAccountTaskerPage> {
  final List<TaskType> taskTypeList = [];
  SecureStorage secureStorage = SecureStorage();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _gioiThieuController = TextEditingController();

  TextEditingController _emailController = TextEditingController();
  String? _imagePath;
  int? userId;
  String taskListString = '';
  List<TaskType> tasksTypeOfTasker = [];
  File? image;
  //"assets/images/avatar.png"
  String pushImages = "";
  final ImagePicker _picker = ImagePicker(); // Khởi tạo ImagePicker

// Hàm chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        image = (File(pickedFile.path)); // Thêm ảnh vào danh sách
      });
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskTypeCubit>(context).getAllTypeTasks();
    _nameController.text =
        (widget.tasker.tasker as Map<String, dynamic>)['name'];
    _phoneNumberController.text =
        (widget.tasker.tasker as Map<String, dynamic>)['phoneNumber'];
    _emailController.text =
        (widget.tasker.tasker as Map<String, dynamic>)['email'];
    _gioiThieuController.text =
        (widget.tasker.taskerInfo as Map<String, dynamic>)['introduction'];
    taskTypeList.addAll(widget.taskTypeList);

    taskListString =
        (widget.tasker.taskerInfo as Map<String, dynamic>)['taskList'];
    List<String> taskIds = taskListString.trim().split('_');
    for (var taskId in taskIds) {
      TaskType? taskType = widget.taskTypeList
          .firstWhere((task) => task.id.toString() == taskId);
      if (taskType != null) {
        tasksTypeOfTasker.add(taskType);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbar(
        isHideBackButton: false,
        isHavePadding: false,
        title: Text('Cập nhật hồ sơ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              width:
                                  130, // Kích thước của Container bao quanh CircleAvatar
                              height: 130,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey, // Màu viền
                                  width: 3.0, // Độ dày của viền
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    500), // Bo góc cho ảnh
                                child: image != null
                                    ? Image.file(
                                        image!,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit
                                            .cover, // Đảm bảo ảnh bao phủ toàn bộ container
                                      )
                                    : Image.asset(
                                        AppImages.avatar, // Placeholder image
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                              ),
                            ),
                          ),
                          Positioned(
                              child: Container(
                            margin: const EdgeInsets.only(top: 90, left: 90),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey, // Màu viền
                                    width: 1.0, // Độ dày của viền
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: AppColors.xanh_main,
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Giới thiệu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Giới thiệu",
                        border: InputBorder.none,
                      ),
                      controller: _gioiThieuController,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Họ và tên',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Họ và tên",
                        border: InputBorder.none,
                      ),
                      controller: _nameController,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Số điện thoại',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Số điện thoại",
                        border: InputBorder.none,
                      ),
                      controller: _phoneNumberController,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
                      controller: _emailController,
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'Công việc',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Chọn công việc'),
                                    content: StatefulBuilder(
                                      builder: (BuildContext context,
                                          StateSetter setStatee) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            children: taskTypeList.map((task) {
                                              String name = task.name;
                                              bool isCheck = tasksTypeOfTasker
                                                  .contains(task);
                                              return CheckboxListTile(
                                                title: Text(name),
                                                activeColor: AppColors.cam_main,
                                                value: isCheck,
                                                onChanged: (bool? value) {
                                                  setStatee(() {
                                                    if (value == true) {
                                                      tasksTypeOfTasker
                                                          .add(task);
                                                    } else {
                                                      tasksTypeOfTasker
                                                          .remove(task);
                                                    }
                                                  });
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
                                    ),
                                    actions: <Widget>[
                                      Sizedbutton(
                                        onPressFun: () {
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        },
                                        text: "Xác nhận",
                                        backgroundColor: AppColors.cam_main,
                                        textColor: Colors.white,
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text(
                              'Chỉnh sửa',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.cam_main),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _congViecList(
                      tasksTypeOfTasker: tasksTypeOfTasker,
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthResponseSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Cập nhật thành công'),
                          backgroundColor: AppColors.xanh_main,
                        ),
                      );
                      secureStorage.writeName(_nameController.text);
                      secureStorage
                          .writePhoneNumber(_phoneNumberController.text);
                      secureStorage.writeEmail(_emailController.text);
                    } else if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.message),
                          backgroundColor: AppColors.do_main,
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.cam_main,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<TaskerCubit>(context)
                            .editATaskerProfile(
                                (widget.tasker.tasker
                                    as Map<String, dynamic>)['id'],
                                _nameController.text,
                                _emailController.text,
                                _phoneNumberController.text,
                                _imagePath ?? 'temp avt',
                                _gioiThieuController.text,
                                tasksTypeOfTasker
                                    .map((e) => e.id.toString())
                                    .join('_'));
                      },
                      child: const Text(
                        'Cập nhật',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _congViecList extends StatefulWidget {
  final List<TaskType> tasksTypeOfTasker;

  const _congViecList({
    required this.tasksTypeOfTasker,
    super.key,
  });

  @override
  State<_congViecList> createState() => _congViecListState();
}

class _congViecListState extends State<_congViecList> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...widget.tasksTypeOfTasker
            .map((taskType) => _congViecCard(title: taskType.name))
            .toList(),
      ],
    );
  }
}

class _congViecCard extends StatelessWidget {
  final String title;
  const _congViecCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 6, bottom: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.cam_main),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(title,
              style: const TextStyle(fontSize: 16, color: AppColors.cam_main)),
        ),
      ),
    );
  }
}
