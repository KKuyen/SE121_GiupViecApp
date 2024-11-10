import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/button/2sttbutton.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/task_type_mini_card/mini_tt_card_widget.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/core/firebase/firebase_image.dart';

import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/tasker/tasker_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/allReview.dart';

class Taskerprofile extends StatefulWidget {
  final int taskerId;
  final int userId;
  const Taskerprofile(
      {super.key, required this.taskerId, required this.userId});

  @override
  State<Taskerprofile> createState() => _TaskerprofileState();
}

class _TaskerprofileState extends State<Taskerprofile> {
  bool isLove = false;
  bool isBlock = false;

  void toggleLove() {
    setState(() {
      isLove = !isLove;
    });
  }

  void toggleBlock() {
    setState(() {
      isBlock = !isBlock;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskerCubit>(context)
        .getATasker(widget.userId, widget.taskerId);
  }

  FirebaseImageService _firebaseImageService = FirebaseImageService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskerCubit, TaskerState>(
      builder: (context, state) {
        if (state is TaskerLoading) {
          return Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: const Center(
                    child: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()))),
          );
        } else if (state is TaskerSuccess) {
          final tasker = state.tasker;
          isLove = state.tasker.isLove ?? false;
          isBlock = state.tasker.isBlock ?? false;
          var totalStar = 0;
          var totalReviews = 0;
          for (var review in tasker.reviewList ?? []) {
            totalStar += (review?['star'] ?? 0) as int;
            totalReviews++;
          }
          return SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 250,
                      decoration: const BoxDecoration(color: Colors.blue),
                    ),
                    Container(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height - 250),
                      decoration: const BoxDecoration(color: AppColors.nen_the),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            AppInfor1.horizontal_padding,
                            65,
                            AppInfor1.horizontal_padding,
                            0),
                        child: Column(
                          children: [
                            Text(
                              (tasker.tasker
                                      as Map<String, dynamic>?)?['name'] ??
                                  '',
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 23),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              (tasker.taskerInfo as Map<String, dynamic>?)?[
                                      'introduction'] ??
                                  '',
                              style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
                                  color: AppColors.xam72,
                                  fontSize: 14),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TwoSttButton(
                                  userId: widget.userId,
                                  isLove: false,
                                  TaskerId: (state.tasker.tasker
                                          as Map<String, dynamic>?)?['id'] ??
                                      '',
                                  sttkey: isBlock,
                                  icon: const Icon(
                                    Icons.block,
                                    color: AppColors.do_main,
                                    size: 33,
                                  ),
                                  icon2: const Icon(
                                    Icons.block,
                                    color: AppColors.xam72,
                                    size: 33,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                TwoSttButton(
                                  userId: widget.userId,
                                  isLove: true,
                                  TaskerId: (state.tasker.tasker
                                          as Map<String, dynamic>?)?['id'] ??
                                      '',
                                  sttkey: isLove,
                                  icon: const Icon(
                                    FontAwesomeIcons.solidHeart,
                                    color: AppColors.xanh_main,
                                    size: 32,
                                  ),
                                  icon2: const Icon(
                                    FontAwesomeIcons.heart,
                                    color: AppColors.xam72,
                                    size: 32,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    FontAwesomeIcons.solidMessage,
                                    color: AppColors.xam72,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    AppInfor1.horizontal_padding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Thông tin cá nhân',
                                      style: AppTextStyle.tieudebox,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Họ và Tên: ',
                                            style: AppTextStyle.textthuong),
                                        const SizedBox(width: 25),
                                        Expanded(
                                          child: Text(
                                            (tasker.tasker as Map<String,
                                                    dynamic>?)?['name'] ??
                                                '',
                                            softWrap: true,
                                            style: AppTextStyle.textthuong,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Email: ',
                                            style: AppTextStyle.textthuong),
                                        const SizedBox(width: 25),
                                        Expanded(
                                          child: Text(
                                            (tasker.tasker as Map<String,
                                                    dynamic>?)?['email'] ??
                                                '',
                                            softWrap: true,
                                            style: AppTextStyle.textthuong,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        const Text('Số điện thoại: ',
                                            style: AppTextStyle.textthuong),
                                        const SizedBox(width: 25),
                                        Expanded(
                                          child: Text(
                                            (tasker.tasker as Map<String,
                                                        dynamic>?)?[
                                                    'phoneNumber'] ??
                                                '',
                                            softWrap: true,
                                            style: AppTextStyle.textthuong,
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text('Công việc: ',
                                        style: AppTextStyle.textthuong),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Wrap(
                                      spacing: 10,
                                      runSpacing: 5,
                                      children: List.generate(
                                        state.taskTypeList.length,
                                        (index) {
                                          // Convert 'taskList' from tasker.taskerInfo into a list of integers
                                          String taskList = (tasker.taskerInfo
                                                  as Map<String,
                                                      dynamic>?)?['taskList'] ??
                                              '';

                                          List<int> taskListIds = [];
                                          if (taskList.isNotEmpty) {
                                            try {
                                              taskListIds = taskList
                                                  .split('_')
                                                  .map((e) => int.parse(e))
                                                  .toList();
                                            } catch (e) {
                                              print(
                                                  'Error parsing taskList: $e');
                                            }
                                          }

                                          // Check if taskTypeList[index].id exists in taskListIds
                                          bool containsId =
                                              taskListIds.contains(
                                                  state.taskTypeList[index].id);

                                          if (containsId) {
                                            return MiniTtCardWidget(
                                              taskType: state
                                                  .taskTypeList[index].name,
                                            );
                                          } else {
                                            return Container();
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(
                                    AppInfor1.horizontal_padding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Đánh giá',
                                      style: AppTextStyle.tieudebox,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          totalReviews > 0
                                              ? '${(totalStar / totalReviews).toStringAsFixed(1)}/5'
                                              : '0/5',
                                          style: const TextStyle(
                                              color: Colors.amber,
                                              fontSize: 22,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          FontAwesomeIcons.solidStar,
                                          color: Colors.amber,
                                          size: 20,
                                        ),
                                        const Spacer(),
                                        Text(
                                          'Từ $totalReviews lượt đánh giá',
                                          style: AppTextStyle.textthuongxam,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Sizedbutton(
                                      onPressFun: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Allreview(
                                                    taskerId: widget.taskerId,
                                                  )),
                                        );
                                      },
                                      height: 45,
                                      width: MediaQuery.of(context).size.width,
                                      text: 'Xem tất cả',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          AppInfor1.horizontal_padding,
                          182,
                          AppInfor1.horizontal_padding,
                          0),
                      child: Center(
                        child: Column(
                          children: [
                            FutureBuilder<String>(
                              future: _firebaseImageService.loadImage(
                                (state.tasker.tasker
                                        as Map<String, dynamic>?)?['avatar'] ??
                                    '',
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Container(
                                    width: 120.0,
                                    height: 120.0,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey,
                                    ),
                                    child: const Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.white,
                                    ),
                                  );
                                } else if (snapshot.hasData) {
                                  return CachedNetworkImage(
                                    imageUrl: snapshot.data!,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 120.0,
                                      height: 120.0,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: const Icon(
                                        Icons.person,
                                        size: 60,
                                        color: Colors.white,
                                      ),
                                    ),
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      width: 120.0,
                                      height: 120.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Colors.white, width: 6),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Icon(Icons.error);
                                }
                              },
                            ),

                            const SizedBox(
                              height: 15,
                            ),
                            // ignore: prefer_const_constructors
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(93, 0, 0, 0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 4,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (state is TaskerError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
