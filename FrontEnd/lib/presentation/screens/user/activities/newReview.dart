import 'dart:io'; // Import thêm để dùng File class
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart'; // Import thêm gói image_picker
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';

import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowBasic.dart';

import 'package:se121_giupviec_app/core/configs/constants/app_icon.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/core/firebase/firebase_image.dart';
import 'package:se121_giupviec_app/domain/entities/task.dart';
import 'package:se121_giupviec_app/presentation/bloc/notification/notification_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';

class Newreview extends StatefulWidget {
  final Task task;
  final int userId;

  final String taskerName;
  final String taskerPhone;
  final String taskerImageLink;
  final String userName;

  final String taskTypeAvatar;
  final String taskTypeName;
  final int taskTypeId;

  final int taskerId;

  const Newreview(
      {super.key,
      required this.userId,
      required this.taskerId,
      required this.userName,
      required this.task,
      required this.taskTypeAvatar,
      required this.taskTypeName,
      required this.taskerName,
      required this.taskerPhone,
      required this.taskerImageLink,
      required this.taskTypeId});

  @override
  State<Newreview> createState() => _NewreviewState();
}

class _NewreviewState extends State<Newreview> {
  int Star = 5;
  final TextEditingController _reviewController = TextEditingController();
  List<File> images = []; // Sử dụng File để lưu hình ảnh
  List<String> pushImages = [];
  final ImagePicker _picker = ImagePicker(); // Khởi tạo ImagePicker
  void _changeStar(int newStar) {
    setState(() {
      Star = newStar;
    });
  }

  // Hàm chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    if (images.length < 4) {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          images.add(File(pickedFile.path)); // Thêm ảnh vào danh sách
        });
      }
    } else {
      // Hiển thị cảnh báo nếu số lượng ảnh vượt quá 5
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Bạn chỉ có thể thêm tối đa 4 ảnh'),
            backgroundColor: AppColors.cam_main),
      );
    }
  }

  Future<void> convertToLink() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nen_the,
      appBar: const BasicAppbar(
        title: Text(
          'Đánh giá',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        isHideBackButton: false,
        isHavePadding: true,
        color: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => {
                  // lỗi id nên comment lại
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Finishtab(),
                  //   ),
                  // ),
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 15, 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: widget.taskTypeAvatar != null &&
                                        widget.taskTypeAvatar
                                            .toString()
                                            .isNotEmpty
                                    ? ColorFiltered(
                                        colorFilter: const ColorFilter.mode(
                                          Color(0xff4AB7B6),
                                          BlendMode
                                              .modulate, // hoặc try BlendMode.overlay, srcIn, multiply
                                        ),
                                        child: Image.network(
                                          AppIcon.getImageUrl(widget
                                              .taskTypeAvatar
                                              .toString())!,
                                          width:
                                              40, // hoặc giá trị bạn muốn, ví dụ 48
                                          height: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error,
                                                  stackTrace) =>
                                              const Icon(
                                                  Icons.image_not_supported,
                                                  color: AppColors.xanh_main),
                                        ))
                                    : const Icon(Icons.image,
                                        color: AppColors.xanh_main),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      widget.taskTypeName,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    const Text(
                                      '#DV',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF4AB7B6),
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      widget.task.id.toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: Color(0xFF4AB7B6),
                                        fontSize: 17,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.task.finishedAt.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Color(0xFF727272),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        row(
                          tieude: 'Giá:',
                          noidung: widget.task.price.toString(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const row(
                          tieude: 'Người giúp việc:',
                          noidung: '',
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Taskerrowbasic(
                            userId: widget.userId,
                            taskerPhone: widget.taskerPhone,
                            taskerId: widget.taskerId,
                            taskerImageLink: widget.taskerImageLink,
                            taskerName: widget.taskerName,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () => _changeStar(1),
                      child: star(nowstar: Star, starnumber: 1)),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => _changeStar(2),
                      child: star(nowstar: Star, starnumber: 2)),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => _changeStar(3),
                      child: star(nowstar: Star, starnumber: 3)),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => _changeStar(4),
                      child: star(nowstar: Star, starnumber: 4)),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => _changeStar(5),
                      child: star(nowstar: Star, starnumber: 5)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Color.fromARGB(24, 0, 0, 0),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Đánh giá của bạn', style: AppTextStyle.tieudebox),
              const SizedBox(
                height: 15,
              ),
              TextField(
                  controller: _reviewController,
                  maxLength: 200,
                  cursorColor: AppColors.xanh_main,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: "Nhập đánh giá của bạn",
                    hintStyle: TextStyle(
                        color: AppColors.xam72, fontWeight: FontWeight.normal),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.xanh_main),
                    ),
                    labelStyle: TextStyle(color: Colors.black),
                    floatingLabelStyle: TextStyle(color: AppColors.xanh_main),
                  )),
              const Text('Thêm ảnh', style: AppTextStyle.tieudebox),
              const SizedBox(
                height: 10,
              ),
              Wrap(
                runSpacing: 8.0,
                spacing: 8.0, // Khoảng cách giữa các phần tử
                children: [
                  // Container chứa nút chọn ảnh
                  Container(
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.xam72, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_a_photo,
                        size: 40,
                      ),
                      onPressed: _pickImage, // Hàm chọn ảnh
                    ),
                  ),

                  // Các ảnh đã chọn
                  ...images.map((image) {
                    return Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // Nếu muốn bo góc
                            border: Border.all(
                                color: AppColors.xam72,
                                width: 1), // Viền bao quanh ảnh
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(5), // Bo góc cho ảnh
                            child: Image.file(
                              image,
                              height: 100,
                              width: 100,
                              fit: BoxFit
                                  .cover, // Đảm bảo ảnh bao phủ toàn bộ container
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                images.remove(image);
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(127, 158, 158, 158),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Sizedbutton(
                  onPressFun: () async {
                    for (int i = 0; i < images.length; i++) {
                      final imageUrl =
                          await FirebaseImageService().uploadImage(images[i]);
                      if (imageUrl != null) {
                        pushImages.add(imageUrl); // Upload ảnh lên Firebase
                      }
                    }
                    for (int i = 0; i < pushImages.length; i++) {
                      print(pushImages[i]);
                    }

                    await context.read<ATaskCubit>().review(
                        widget.task.id,
                        widget.taskerId,
                        Star,
                        widget.userId,
                        widget.taskTypeId,
                        _reviewController.text,
                        pushImages.isNotEmpty ? pushImages[0] : null,
                        pushImages.length > 1 ? pushImages[1] : null,
                        pushImages.length > 2 ? pushImages[2] : null,
                        pushImages.length > 3 ? pushImages[3] : null);
                    await BlocProvider.of<allNotificationCubit>(context)
                        .addANotificaiton(
                            widget.taskerId,
                            "Bạn đã được một khách hàng đánh giá",
                            "Khách hàng ${widget.userName} vừa mới đánh giá bạn ${Star} sao.",
                            "review.jpg");

                    Navigator.pop(context, Star);
                  },
                  text: 'Gửi đánh giá',
                  width: MediaQuery.of(context).size.width),
            ],
          ),
        ),
      ),
    );
  }
}

class star extends StatelessWidget {
  final int nowstar;
  final int starnumber;
  const star({
    required this.nowstar,
    required this.starnumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      starnumber <= nowstar
          ? FontAwesomeIcons.solidStar
          : FontAwesomeIcons.star,
      color: Colors.amber,
      size: 40.0,
    );
  }
}

class row extends StatelessWidget {
  final String tieude;
  final String noidung;
  const row({
    required this.tieude,
    required this.noidung,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          tieude,
          style: const TextStyle(
              fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          noidung,
        )
      ],
    );
  }
}
