// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/header.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/input/disableInput.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/isuTaskerRow.dart';

import 'package:se121_giupviec_app/common/widgets/userRow/userRow.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/reviewView.dart';
// import statements here

class Finishtasktab extends StatefulWidget {
  final int id;
  final int customerId;
  final int accountId;
  final int numberOfTasker;

  const Finishtasktab({
    super.key,
    required this.accountId,
    required this.customerId,
    required this.id,
    required this.numberOfTasker,
  });

  @override
  State<Finishtasktab> createState() => _FinishtasktabState();
}

class _FinishtasktabState extends State<Finishtasktab> {
  bool _isLabelVisible = false;

  final bool _isEditableNote = false;
  bool isToTime = false;

  void _hideLabel() {
    setState(() {
      _isLabelVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ATaskCubit>(context)
        .getATasks2(widget.id, widget.customerId);
  }

  int star = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BlocBuilder<ATaskCubit, ATaskState>(
        builder: (context, state) {
          if (state is ATaskLoading) {
            return Center(
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Center(
                      child: SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator()))),
            );
          } else if (state is ATaskSuccess) {
            final task = state.task;
            final taskerList = state.taskerList;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              for (var tasker in taskerList) {
                if (tasker.taskerId == 3 && tasker.status == 'S5') {
                  setState(() {
                    star = tasker.reviewStar ?? 0;
                  });
                  break;
                }
              }
            });
            int maxTasker = 0;
            int appTasker = 0;
            for (var tasker in task.taskerLists ?? []) {
              if ((tasker as Map<String, dynamic>)['status'] == 'S1') {
                maxTasker++;
              }
              if ((tasker)['status'] == 'S2') {
                appTasker++;
              }
            }
            return Scaffold(
                backgroundColor: AppColors.nen_the,
                appBar: BasicAppbar(
                  title: const Text(
                    'Thông tin',
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
                bottomNavigationBar: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Sizedbutton(
                          onPressFun: () {
                            // Add your logic here
                          },
                          text: 'Xác nhận hủy',
                          StrokeColor: AppColors.cam_main,
                          isStroke: true,
                          textColor: AppColors.cam_main,
                          backgroundColor: Colors.white,
                          width: MediaQuery.of(context).size.width - 15,
                          height: 45,
                        ),
                      ],
                    ),
                  ),
                ),

                //noi dung
                body: SingleChildScrollView(
                    child: Column(
                  children: [
                    Header(
                      color: AppColors.cam_main,
                      text1: 'Công việc đã hoàn thành',
                      text2: "Bạn đã hoàn thành xong công việc",
                      icon: Icon(
                        Icons.check, // Icon kiểu hình tròn
                        color: Colors.white, // Màu của icon
                        size: 40, // Kích thước của icon
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppInfor1.horizontal_padding),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Khách hàng',
                                style: AppTextStyle.tieudebox,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(children: [
                                Userrow(
                                    taskerImageLink: (task.user as Map<String,
                                            dynamic>)?['avatar'] ??
                                        '',
                                    isContact: true,
                                    isCall: true,
                                    userId: task.userId,
                                    userName: (task.user
                                            as Map<String, dynamic>)['name'] ??
                                        '',
                                    userPhone: (task.user as Map<String,
                                            dynamic>)['phoneNumber'] ??
                                        '',
                                    userImageLink: (task.user
                                            as Map<String, dynamic>)['avatar'] ??
                                        "")
                              ]),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppInfor1.horizontal_padding),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Đánh giá',
                                style: AppTextStyle.tieudebox,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (star != 0)
                              Center(
                                child: Row(
                                  children: [
                                    Row(
                                      children: List.generate(5, (index) {
                                        return Row(
                                          children: [
                                            Icon(
                                              index < star
                                                  ? FontAwesomeIcons.solidStar
                                                  : FontAwesomeIcons.star,
                                              color: Colors.amber,
                                              size: 27,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.amber,
                                        size: 27,
                                      ),
                                      onPressed: () async {
                                        final avatar =
                                            await SecureStorage().readAvatar();
                                        final phone = await SecureStorage()
                                            .readPhoneNumber();
                                        final name =
                                            await SecureStorage().readName();

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Reviewview(
                                              taskId: widget.id,
                                              taskerId: widget.accountId,
                                              taskerName: name,
                                              taskerImageLink: avatar,
                                              taskerPhone: phone,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                ),
                              ),
                            if (star == 0)
                              Text(
                                'Chưa có đánh giá',
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    color: AppColors.xam72,
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic),
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppInfor1.horizontal_padding),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Thông tin chi tiết',
                                style: AppTextStyle.tieudebox,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Divider(),
                                      const Text('Mã đơn hàng: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 24),
                                      Text(
                                        '#DV${task.id}',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: AppColors.cam_main,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Tên dịch vụ: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 38),
                                      Text(
                                        (task.taskType as Map<String, dynamic>)[
                                                'name'] ??
                                            '',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Ngày bắt đầu: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 25),
                                      Expanded(
                                        child: Text(
                                          task.time.toString(),
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Địa chỉ: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 26),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (task.location as Map<String,
                                                          dynamic>)['ownerName']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              softWrap: true,
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '${(task.location as Map<String, dynamic>)['detailAddress'] ?? ""}, ${(task.location as Map<String, dynamic>)['district'] ?? ""}, ${(task.location as Map<String, dynamic>)['province'] ?? ''}, ${(task.location as Map<String, dynamic>)['country'] ?? ''}',
                                              softWrap: true,
                                              maxLines:
                                                  3, // Số dòng tối đa, có thể tăng tùy ý
                                              overflow: TextOverflow
                                                  .ellipsis, // Hiển thị dấu "..." nếu vượt quá
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              (task.location as Map<String,
                                                              dynamic>)[
                                                          'ownerPhoneNumber']
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.black,
                                                fontSize: 15,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              softWrap: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Giá: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 52),
                                      Text(
                                        '${task.price} VNĐ',
                                        style: TextStyle(
                                            fontFamily: 'Inter',
                                            color: Colors.black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Ghi chú: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 9),
                                      DisableInput(
                                        enabled: _isEditableNote,
                                        text: task.note ?? '',
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppInfor1.horizontal_padding),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Người giúp việc',
                                style: AppTextStyle.tieudebox,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: taskerList.map<Widget>((atasker) {
                                  if (atasker.status == "S5") {
                                    return Isutaskerrow(
                                      accountId: widget.accountId,
                                      taskerId: (atasker.tasker
                                          as Map<String, dynamic>)['id'],
                                      taskerName: (atasker.tasker as Map<String,
                                              dynamic>)['name'] ??
                                          '',
                                      taskerImageLink: (atasker.tasker as Map<
                                              String, dynamic>)['avatar'] ??
                                          '',
                                      taskerPhone: (atasker.tasker as Map<
                                              String,
                                              dynamic>)['phoneNumber'] ??
                                          '',
                                    );
                                  } else {
                                    return Container(); // Return an empty container if the status is not "S1"
                                  }
                                }).toList(),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(AppInfor1.horizontal_padding),
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Lịch sử',
                                style: AppTextStyle.tieudebox,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Ngày đặt: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 87),
                                      Expanded(
                                        child: Text(
                                          task.createdAt.toIso8601String(),
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: AppColors.xam72,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Ngày xác nhận: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 42),
                                      Expanded(
                                        child: Text(
                                          task.approvedAt?.toIso8601String() ??
                                              '',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: AppColors.xam72,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      const Text('Ngày hoàn thành: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 25),
                                      Expanded(
                                        child: Text(
                                          task.finishedAt?.toIso8601String() ??
                                              '',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: AppColors.xam72,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )));
          } else if (state is ATaskError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No tasks found'));
          }
        },
      ),
      if (_isLabelVisible)
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
      if (_isLabelVisible) Center(),
    ]);
  }
}
