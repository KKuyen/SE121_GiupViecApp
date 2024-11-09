import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/search/search.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/tasker_find_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_card/tasker_waiting_activity_widget.dart';
import 'package:se121_giupviec_app/common/widgets/voucher/voucherList.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:se121_giupviec_app/presentation/bloc/TaskType/get_all_tasktype_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/TaskType/get_all_tasktype_state.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_find_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/tasker/tasker_find_task_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/location.dart';
import 'package:se121_giupviec_app/presentation/screens/user/home/discovery.dart';

import '../../../../common/widgets/location/default_location.dart';

class TaskerHomePage extends StatefulWidget {
  const TaskerHomePage({super.key});

  @override
  State<TaskerHomePage> createState() => _TaskerHomePagState();
}

class _TaskerHomePagState extends State<TaskerHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  DateTime? startDate = DateTime.now();
  DateTime? endDate;
  String? taskType;
  List<String> selectedTasks = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    final taskTypeCubit =
        BlocProvider.of<TaskerFindTaskCubit>(context).getFindTasks(3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _isFilterEnabled = false;
  void setFilterEnabled(bool isEnabled) {
    setState(() {
      _isFilterEnabled = isEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskerFindTaskCubit, TaskerFindTaskState>(
      builder: (context, state) {
        if (state is TaskerFindTaskLoading) {
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
        } else if (state is TaskerFindTaskSuccess) {
          print(state.findTasks?.length.toString());
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: BasicAppbar(
              title: SvgPicture.asset(
                AppVectors.logo,
                height: 20,
              ),
              isHideBackButton: true,
              action: IconButton(
                icon: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      shape: BoxShape.circle),
                  child: const Icon(
                    FontAwesomeIcons.solidBell,
                    size: 25,
                    color: AppColors.cam_main,
                  ),
                ),
                onPressed: () {},
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(162, 241, 241, 241),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 27.0, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('Tìm kiếm công việc',
                                  style: AppTextStyle.tieudebox25),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    isScrollControlled:
                                        true, // Allows modal to fit content height
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context,
                                            StateSetter setState) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0,
                                                vertical: 8.0),
                                            child: SingleChildScrollView(
                                              child: IntrinsicHeight(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          const Text(
                                                              'Bật bộ lọc',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16)),
                                                          Switch(
                                                            activeColor:
                                                                AppColors
                                                                    .cam_main,
                                                            value:
                                                                _isFilterEnabled,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _isFilterEnabled =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      const Divider(
                                                        color: Colors.grey,
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Row(
                                                        children: [
                                                          const Text('Từ ngày:',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16)),
                                                          const SizedBox(
                                                              width: 25),
                                                          Expanded(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () async {
                                                                final pickedDate =
                                                                    await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      startDate ??
                                                                          DateTime
                                                                              .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2000),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2101),
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return Theme(
                                                                      data: Theme.of(
                                                                              context)
                                                                          .copyWith(
                                                                        colorScheme:
                                                                            ColorScheme.light(
                                                                          primary:
                                                                              AppColors.cam_main, // header background color
                                                                        ),
                                                                        textButtonTheme:
                                                                            TextButtonThemeData(
                                                                          style:
                                                                              TextButton.styleFrom(
                                                                            foregroundColor:
                                                                                AppColors.cam_main, // button text color
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  },
                                                                );
                                                                if (pickedDate!
                                                                    .isBefore(
                                                                        DateTime
                                                                            .now())) {
                                                                  // Handle the case where the picked date is before the current date
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text(
                                                                          'Chọn ngày lớn hơn ngày hiện tại'),
                                                                    ),
                                                                  );
                                                                } else {
                                                                  if (pickedDate !=
                                                                      null) {
                                                                    setState(
                                                                        () {
                                                                      startDate =
                                                                          pickedDate;
                                                                    });
                                                                  }
                                                                }
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        12),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Text(
                                                                  startDate !=
                                                                          null
                                                                      ? '${startDate!.day}/${startDate!.month}/${startDate!.year}'
                                                                      : 'Chọn ngày',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'Đến ngày:',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      16)),
                                                          const SizedBox(
                                                              width: 25),
                                                          Expanded(
                                                            child:
                                                                GestureDetector(
                                                              onTap: () async {
                                                                final pickedDate =
                                                                    await await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  initialDate:
                                                                      startDate ??
                                                                          DateTime
                                                                              .now(),
                                                                  firstDate:
                                                                      DateTime(
                                                                          2000),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2101),
                                                                  builder:
                                                                      (context,
                                                                          child) {
                                                                    return Theme(
                                                                      data: Theme.of(
                                                                              context)
                                                                          .copyWith(
                                                                        colorScheme:
                                                                            ColorScheme.light(
                                                                          primary:
                                                                              AppColors.cam_main, // header background color
                                                                        ),
                                                                        textButtonTheme:
                                                                            TextButtonThemeData(
                                                                          style:
                                                                              TextButton.styleFrom(
                                                                            foregroundColor:
                                                                                AppColors.cam_main, // button text color
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          child!,
                                                                    );
                                                                  },
                                                                );

                                                                if (startDate!
                                                                        .isAfter(
                                                                            pickedDate!) &&
                                                                    startDate !=
                                                                        null) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    const SnackBar(
                                                                      content: Text(
                                                                          'Chọn ngày lớn hơn ngày bắt đầu'),
                                                                    ),
                                                                  );
                                                                } else if (pickedDate !=
                                                                    null) {
                                                                  setState(() {
                                                                    endDate =
                                                                        pickedDate;
                                                                  });
                                                                }
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 8,
                                                                    horizontal:
                                                                        12),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Text(
                                                                  endDate !=
                                                                          null
                                                                      ? '${endDate!.day}/${endDate!.month}/${endDate!.year}'
                                                                      : 'Chọn ngày',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      const Text(
                                                          'Loại công việc:',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16)),
                                                      const SizedBox(height: 8),
                                                      Wrap(
                                                        spacing: 8.0,
                                                        runSpacing: 4.0,
                                                        children: List<
                                                            Widget>.generate(
                                                          state.taskTypeList!
                                                              .length,
                                                          (int index) {
                                                            String str = state
                                                                .taskTypeList![
                                                                    index]
                                                                .name;
                                                            bool isSelected =
                                                                !selectedTasks
                                                                    .contains(
                                                                        str);

                                                            return ChoiceChip(
                                                              label: Text(
                                                                  str), // Display task name on the chip
                                                              selected:
                                                                  isSelected,
                                                              onSelected: (bool
                                                                  selected) {
                                                                setState(() {
                                                                  if (!selected) {
                                                                    selectedTasks
                                                                        .add(
                                                                            str);
                                                                  } else {
                                                                    selectedTasks
                                                                        .remove(
                                                                            str);
                                                                  }
                                                                });
                                                              },
                                                              selectedColor:
                                                                  AppColors
                                                                      .cam_main, // Color when chip is selected
                                                              backgroundColor:
                                                                  Colors.grey[
                                                                      200], // Color when chip is not selected
                                                              labelStyle:
                                                                  TextStyle(
                                                                color: isSelected
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black,
                                                              ),
                                                            );
                                                          },
                                                        ).toList(),
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      SizedBox(
                                                          width:
                                                              double.infinity,
                                                          child: Sizedbutton(
                                                            onPressFun: () {},
                                                            backgroundColor:
                                                                AppColors
                                                                    .xanh_main,
                                                            height: 45,
                                                            text: 'Tìm kiếm ',
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.filter,
                                  color: AppColors.cam_main,
                                  size: 24,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          if (state.findTasks!.isEmpty)
                            const Center(
                              child: Text(
                                'Không có công việc nào phù hợp',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                    color: AppColors.xam72),
                              ),
                            ),
                          Expanded(
                            // Add this here
                            child: ListView.builder(
                              itemCount: state.findTasks!.length,
                              itemBuilder: (context, index) {
                                var task = state.findTasks![index];

                                return TaskerFindActivityWidget(
                                  avatar: (task.taskType
                                          as Map<String, dynamic>)['avatar'] ??
                                      '',
                                  ungCuVien: task.taskerLists
                                          ?.where((tasker) =>
                                              (tasker as Map<String, dynamic>)[
                                                  'status'] ==
                                              'S1')
                                          .length ??
                                      0,
                                  loading: () async {
                                    BlocProvider.of<TaskerFindTaskCubit>(
                                            context)
                                        .getFindTasks(3);
                                  },
                                  daNhan: task.taskerLists
                                          ?.where((tasker) =>
                                              (tasker as Map<String, dynamic>)[
                                                  'status'] ==
                                              'S2')
                                          .length ??
                                      0,
                                  createAt: task.createdAt,
                                  numberOfTasker: task.numberOfTasker ?? 0,
                                  id: task.id,
                                  startDay: task.time,
                                  price: task.price ?? '',
                                  note: task.note ?? '',
                                  ownerName: (task.location as Map<String,
                                          dynamic>?)?['ownerName'] ??
                                      '',
                                  phone: (task.location as Map<String,
                                          dynamic>?)?['ownerPhoneNumber'] ??
                                      '',
                                  detailAddress: (task.location as Map<String,
                                          dynamic>?)?['detailAddress'] ??
                                      '',
                                  province: (task.location as Map<String,
                                          dynamic>?)?['province'] ??
                                      '',
                                  district: (task.location as Map<String,
                                          dynamic>?)?['district'] ??
                                      '',
                                  country: (task.location as Map<String,
                                          dynamic>?)?['country'] ??
                                      '',
                                  serviceName: (task.taskType
                                          as Map<String, dynamic>?)?['name'] ??
                                      '',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (state is TaskerFindTaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
