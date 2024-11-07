// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/header.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/input/disableInput.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowBasic.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/domain/entities/location.dart';

import 'package:se121_giupviec_app/presentation/bloc/task/a_task_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/task/a_task_state.dart';

import 'package:se121_giupviec_app/presentation/screens/user/activities/taskerList.dart';
// import statements here

class Waitingtab extends StatefulWidget {
  final int id;
  const Waitingtab({super.key, required this.id});

  @override
  State<Waitingtab> createState() => _WaitingtabState();
}

class _WaitingtabState extends State<Waitingtab> {
  bool _isLabelVisible = false;
  bool firstTime = true;
  bool _isEditableNote = false;
  final TextEditingController _noteController = TextEditingController();
  DateTime time = DateTime.now();
  String location1 = '';
  String location2 = '';
  String location3 = '';
  int locationId = 0;
  void setLocationId(int id) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        locationId = id;
      });
    });
  }

  void setNewLocationId(int newlocationId) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        locationId = newlocationId;
      });
    });
  }

  void setFalse() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        firstTime = false;
      });
    });
  }

  void setLocation(String ownerName, String detailAddress, String district) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        location1 = ownerName;
        location2 = detailAddress;
        location3 = district;
      });
    });
  }

  void setNewLocation(Location newlocation) async {
    await BlocProvider.of<ATaskCubit>(context)
        .editTask(widget.id, null, newlocation.id, null);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        location1 = newlocation.ownerName;
        location2 =
            '${newlocation.detailAddress}, ${newlocation.district}, ${newlocation.province}, ${newlocation.country}';
        location3 = newlocation.ownerPhoneNumber;
      });
    });
  }

  void setDateTime(DateTime gettime) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        time = gettime;
      });
    });
  }

  void setNewDattime(DateTime newtime) async {
    // Kiem tra dịnh dạng thời gian
    if (newtime.isBefore(time.add(Duration(days: 1))) ||
        newtime.isAfter(time.add(Duration(days: 7)))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Chỉ có thể thay đổi so với thời gian gốc trong vòng 7 ngày tiếp theo'),
          backgroundColor: AppColors.do_main,
        ),
      );
      return;
    } else {
      await BlocProvider.of<ATaskCubit>(context)
          .editTask(widget.id, newtime, null, null);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          time = newtime;
        });
      });
    }
  }

  void _showLabel() {
    setState(() {
      _isLabelVisible = true;
    });
  }

  void _hideLabel() {
    setState(() {
      _isLabelVisible = false;
    });
  }

  void _toggleEditableNote() async {
    if (_isEditableNote) {
      await BlocProvider.of<ATaskCubit>(context).editTask(widget.id, null, null,
          _noteController.text); // Call the editTask function here
      // Call the updateTaskerStatus function here
    }
    setState(() {
      _isEditableNote =
          !_isEditableNote; // Chuyển trạng thái từ có thể chỉnh sửa sang không và ngược lại
    });
  }

  Future<void> _reload() async {
    setState(() {
      final st = BlocProvider.of<ATaskCubit>(context).getATasks(widget.id, 1);
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<ATaskCubit>(context).getATasks(widget.id, 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ATaskCubit, ATaskState>(
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
          print(task.id);
          if (firstTime) {
            _noteController.text = task.note ?? '';
            setDateTime(task.time);

            setLocationId((task.location as Map<String, dynamic>)['id']);
            setLocation(
                (task.location as Map<String, dynamic>)['ownerName'] ?? '',
                ((task.location as Map<String, dynamic>)['detailAddress'] +
                        ', ' +
                        (task.location as Map<String, dynamic>)['district'] +
                        ', ' +
                        (task.location as Map<String, dynamic>)['province'] +
                        ', ' +
                        (task.location as Map<String, dynamic>)['country']) ??
                    '',
                (task.location as Map<String, dynamic>)['ownerPhoneNumber'] ??
                    '');

            setFalse();
          }

          final taskerList = state.taskerList;
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
          return Stack(children: [
            Scaffold(
                backgroundColor: AppColors.nen_the,
                appBar: BasicAppbar(
                  result: true,
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
                          onPressFun: () async {
                            bool? confirmDelete = await showDialog<bool>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Xác nhận'),
                                  content: Text(
                                      'Bạn có chắc chắn muốn xóa công việc này không?'),
                                  actions: <Widget>[
                                    Sizedbutton(
                                      onPressFun: () {
                                        Navigator.of(context).pop(
                                            true); // Return false if not confirmed
                                      },
                                      text: 'Hủy',
                                      backgroundColor: AppColors.xanh_main,
                                      height: 45,
                                    ),
                                    Spacer(),
                                    Sizedbutton(
                                      onPressFun: () {
                                        Navigator.of(context).pop(
                                            true); // Return true if confirmed
                                      },
                                      text: 'Xóa',
                                      backgroundColor: AppColors.do_main,
                                      height: 45,
                                    ),
                                  ],
                                );
                              },
                            );

                            if (confirmDelete == true) {
                              // Show a second dialog to select an integer cancelCode
                              int? cancelCode = await showDialog<int>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Lý do hủy',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: Text(
                                              'Tôi không có nhu cầu  nữa',
                                              style: AppTextStyle.textthuong),
                                          onTap: () =>
                                              Navigator.of(context).pop(0),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'Tôi có công việc đột xuất',
                                              style: AppTextStyle.textthuong),
                                          onTap: () =>
                                              Navigator.of(context).pop(1),
                                        ),
                                        ListTile(
                                          title: Text(
                                              'Tôi muốn đặt công việc khác',
                                              style: AppTextStyle.textthuong),
                                          onTap: () =>
                                              Navigator.of(context).pop(2),
                                        ),
                                        ListTile(
                                          title: Text('Lý do khác',
                                              style: AppTextStyle.textthuong),
                                          onTap: () =>
                                              Navigator.of(context).pop(3),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );

                              if (cancelCode != null) {
                                await BlocProvider.of<ATaskCubit>(context)
                                    .deleteTask(widget.id, cancelCode);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Đã hủy công việc '),
                                    backgroundColor: AppColors.do_main,
                                  ),
                                );
                                Navigator.pop(context, true);
                              }
                            }
                          },
                          text: 'Xác nhận hủy',
                          StrokeColor: AppColors.cam_main,
                          isStroke: true,
                          textColor: AppColors.cam_main,
                          backgroundColor: Colors.white,
                          width: MediaQuery.of(context).size.width - 20,
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
                      text1: 'Đang tuyển chọn ứng cử viên',
                      text2:
                          'Chú ý thời gian làm việc, nếu bạn không tuyển chọn đủ ứng cử viên thì tới thời hạn công việc sẽ tự hủy.',
                      icon: Icon(
                        Icons.approval,
                        color: Colors.white, // Màu của icon
                        size: 50, // Kích thước của icon
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
                            Row(
                              children: [
                                const Text(
                                  'Người giúp việc',
                                  style: AppTextStyle.tieudebox,
                                ),
                                const Spacer(),
                                Text(
                                  '$appTasker/${task.numberOfTasker} vị trí',
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.xanh_main),
                                ),
                                const SizedBox(width: 8)
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Column(
                                children: taskerList.map<Widget>((atasker) {
                                  if (atasker.status == "S2") {
                                    return Taskerrowbasic(
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: Text(
                                            '$maxTasker ứng cử viên ',
                                            style: TextStyle(
                                              color: AppColors.cam_main,
                                              fontSize: 16,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  ),
                                  const Spacer(),
                                  Sizedbutton(
                                    onPressFun: _showLabel,
                                    text: 'Danh sách',
                                    width: 80,
                                    height: 40,
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
                                            color: AppColors.xanh_main,
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
                                          time.toIso8601String(),
                                          softWrap: true,
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: time,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                            builder: (BuildContext context,
                                                Widget? child) {
                                              return Theme(
                                                data:
                                                    ThemeData.light().copyWith(
                                                  primaryColor: AppColors
                                                      .xanh_main, // Header background color
                                                  highlightColor: AppColors
                                                      .xanh_main, // Selected date color
                                                  colorScheme:
                                                      ColorScheme.light(
                                                    primary: AppColors
                                                        .xanh_main, // Header background color
                                                    onPrimary: Colors
                                                        .white, // Header text color
                                                    onSurface: Colors
                                                        .black, // Body text color
                                                  ),
                                                  dialogBackgroundColor: Colors
                                                      .white, // Background color
                                                ),
                                                child: child!,
                                              );
                                            },
                                          ).then((selectedDate) {
                                            if (selectedDate != null) {
                                              showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now(),
                                                builder: (BuildContext context,
                                                    Widget? child) {
                                                  return Theme(
                                                    data: ThemeData.light()
                                                        .copyWith(
                                                      primaryColor: AppColors
                                                          .xanh_main, // Header background color
                                                      hintColor: AppColors
                                                          .xanh_main, // Selected time color
                                                      colorScheme:
                                                          ColorScheme.light(
                                                        primary: AppColors
                                                            .xanh_main, // Header background color
                                                        onPrimary: Colors
                                                            .white, // Header text color
                                                        onSurface: Colors
                                                            .black, // Body text color
                                                      ),
                                                      dialogBackgroundColor: Colors
                                                          .white, // Background color
                                                    ),
                                                    child: child!,
                                                  );
                                                },
                                              ).then((selectedTime) {
                                                if (selectedTime != null) {
                                                  setNewDattime(DateTime(
                                                      selectedDate.year,
                                                      selectedDate.month,
                                                      selectedDate.day,
                                                      selectedTime.hour,
                                                      selectedTime.minute));
                                                }
                                              });
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          Icons.calendar_today_rounded,
                                          size: 25,
                                        ),
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
                                      const Text('Địa chỉ: ',
                                          style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal)),
                                      const SizedBox(width: 26),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              location1,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              location2,
                                              softWrap: true,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              location3,
                                              style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          print(state.dfLocation);
                                          print(
                                              "________________________________");

                                          print(state.Mylocations);

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                    minHeight: 300,
                                                    maxHeight: 500,
                                                  ),
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Text(
                                                            'Chọn địa chỉ',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: AppColors
                                                                  .xanh_main,
                                                            ),
                                                          ),
                                                          const Spacer(),
                                                          IconButton(
                                                            icon: const Icon(
                                                              Icons.close,
                                                              color: AppColors
                                                                  .xam72,
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Expanded(
                                                        child: ListView.builder(
                                                          itemCount: state
                                                              .Mylocations
                                                              .length,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final location =
                                                                state.Mylocations[
                                                                    index];
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .fromLTRB(
                                                                      0,
                                                                      0,
                                                                      0,
                                                                      5),
                                                              child:
                                                                  GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  //
                                                                  setNewLocation(
                                                                      location);
                                                                  setNewLocationId(
                                                                      location
                                                                          .id);

                                                                  Navigator.pop(
                                                                      context);
                                                                  _reload();
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: location.id ==
                                                                                locationId
                                                                            ? AppColors
                                                                                .xanh_main
                                                                            : const Color.fromARGB(
                                                                                255,
                                                                                202,
                                                                                202,
                                                                                202)),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(5),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10.0),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        if (location.isDefault ==
                                                                            true)
                                                                          const Text(
                                                                            'Địa chỉ mặc định',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'Inter',
                                                                              fontSize: 15,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: AppColors.xanh_main,
                                                                            ),
                                                                          ),
                                                                        Text(
                                                                          location
                                                                              .ownerName,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                2),
                                                                        Text(
                                                                          '${location.detailAddress}, ${location.district}, ${location.province}, ${location.country}',
                                                                          style:
                                                                              const TextStyle(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                2),
                                                                        Text(
                                                                          location
                                                                              .ownerPhoneNumber,
                                                                          style:
                                                                              const TextStyle(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.location_on,
                                          size: 30,
                                        ),
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
                                        controller: _noteController,
                                        text: task.note ?? '',
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      IconButton(
                                          onPressed: _toggleEditableNote,
                                          icon: !_isEditableNote
                                              ? Icon(Icons.edit)
                                              : Icon(
                                                  Icons.check,
                                                  color: AppColors.xanh_main,
                                                ))
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
                                      const SizedBox(width: 25),
                                      Expanded(
                                        child: Text(
                                          task.createdAt.toString(),
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
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ))),
            if (_isLabelVisible)
              Container(
                color: Colors.black.withOpacity(0.5),
              ),
            if (_isLabelVisible)
              Center(
                child: Taskerlist(
                  callBackFunforTab: () => _reload(),
                  id: widget.id,
                  numberOfTasker: task.numberOfTasker,
                  cancel: _hideLabel,
                  taskStatus: 'TS1',
                ),
              ),
          ]);
        } else if (state is ATaskError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
