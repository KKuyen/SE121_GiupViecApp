import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:se121_giupviec_app/common/widgets/addPrice/addPrice.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton2text.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_icon.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask1/newTask1_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/newTask1/newTask1_state.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/newTaskStep2.dart';

class Newtaskstep1 extends StatefulWidget {
  final int taskTypeId;
  final int userId;
  const Newtaskstep1(
      {super.key, required this.taskTypeId, required this.userId});

  @override
  State<Newtaskstep1> createState() => _Newtaskstep1State();
}

class _Newtaskstep1State extends State<Newtaskstep1> {
  int sumMoney = 0;

  List<Map<String, dynamic>> xValues = [];
  void updateXValue(
    int index,
    int quantity,
    int id,
  ) {
    setState(() {
      if (index < xValues.length) {
        xValues[index] = {'addPriceDetailId': id, 'quantity': quantity};
        print(xValues[index].toString() + index.toString());
      } else {
        // Add new values if necessary
        xValues.add({'addPriceDetailId': id, 'quantity': quantity});
        print(xValues[index].toString() + index.toString());
      }
    });
  }

  void updateMoney(int amount) {
    print("vao day 2 $sumMoney");
    setState(() {
      sumMoney += amount;
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewTask1Cubit>(context).getTaskType(widget.taskTypeId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewTask1Cubit, NewTask1State>(
      builder: (context, state) {
        if (state is NewTask1Loading) {
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
        } else if (state is NewTask1Success) {
          final taskType = state.taskType;
          if (sumMoney == 0) {
            sumMoney = taskType.originalPrice;
          }

          return Scaffold(
              backgroundColor: AppColors.nen_the,
              appBar: const BasicAppbar(
                title: Text(
                  'Đặt dịch vụ',
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 0, 15),
                      child: Row(
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColors.xanh_main, width: 2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: taskType.avatar != null &&
                                      taskType.avatar.toString().isNotEmpty
                                  ? Image.network(
                                      AppIcon.getImageUrl(
                                          taskType.avatar.toString())!,
                                      width:
                                          48, // hoặc giá trị bạn muốn, ví dụ 48
                                      height: 48,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error,
                                              stackTrace) =>
                                          const Icon(Icons.image_not_supported,
                                              color: AppColors.xanh_main),
                                    )
                                  : const Icon(Icons.image,
                                      color: AppColors.xanh_main),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(taskType.name,
                                  style: AppTextStyle.tieudebox20),
                              const SizedBox(
                                  height:
                                      5), // Khoảng cách giữa tiêu đề và văn bản mô tả
                              SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    110, // Giới hạn chiều rộng của văn bản để wrap
                                child: Text(
                                  taskType.description ?? '',
                                  style: const TextStyle(
                                      fontSize: 14, color: AppColors.xam72),
                                  softWrap:
                                      true, // Đảm bảo rằng văn bản sẽ tự động xuống dòng
                                  overflow: TextOverflow
                                      .visible, // Cho phép văn bản hiển thị đầy đủ
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15), // Padding hai bên
                      child: SizedBox(
                        height: 65,
                        child: Stack(
                          children: [
                            // Các đường dashed viền trên
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Dash(
                                direction: Axis.horizontal,
                                length: MediaQuery.of(context).size.width -
                                    30, // Chiều dài trừ đi padding
                                dashLength: 5,
                                dashColor: AppColors.xanh_main,
                                dashThickness: 2,
                              ),
                            ),
                            // Các đường dashed viền dưới
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Dash(
                                direction: Axis.horizontal,
                                length: MediaQuery.of(context).size.width -
                                    30, // Chiều dài trừ đi padding
                                dashLength: 5,
                                dashColor: AppColors.xanh_main,
                                dashThickness: 2,
                              ),
                            ),
                            // Các đường dashed viền bên trái
                            const Positioned(
                              top: 0,
                              bottom: 0,
                              left: 0,
                              child: Dash(
                                direction: Axis.vertical,
                                length: 65,
                                dashLength: 5,
                                dashColor: AppColors.xanh_main,
                                dashThickness: 2,
                              ),
                            ),
                            // Các đường dashed viền bên phải
                            const Positioned(
                              top: 0,
                              bottom: 0,
                              right: 0,
                              child: Dash(
                                direction: Axis.vertical,
                                length: 65,
                                dashLength: 5,
                                dashColor: AppColors.xanh_main,
                                dashThickness: 2,
                              ),
                            ),

                            // Row ở giữa container
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'Giá gốc dịch vụ:',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.xanh_main,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${taskType.originalPrice} đ',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.xanh_main,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.taskType.addPriceDetails
                          ?.length, // Số lượng phần tử trong danh sách
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppInfor1.horizontal_padding,
                              vertical: 10), // Padding hai bên),
                          child: Addprice(
                            id: (state.taskType.addPriceDetails?[index]
                                as Map<String, dynamic>)['id'],
                            onPriceUpdate: (amount) {
                              updateMoney(amount);
                            },
                            index: index,
                            onXUpdate: (index, quantity, id) {
                              updateXValue(index, quantity,
                                  id); // Update x value in the list
                            },
                            name: (state.taskType.addPriceDetails?[index]
                                as Map<String, dynamic>)['name'],
                            unit: (state.taskType.addPriceDetails?[index]
                                as Map<String, dynamic>)['unit'],
                            stepValue: (state.taskType.addPriceDetails?[index]
                                as Map<String, dynamic>)['stepValue'],
                            beginValue: (state.taskType.addPriceDetails?[index]
                                as Map<String, dynamic>)['beginValue'],
                            stepPrice: (state.taskType.addPriceDetails?[index]
                                as Map<String, dynamic>)['stepPrice'],
                          ),
                        );
                      },
                    ),
                    // ignore: prefer_is_empty
                    const SizedBox(
                      height: 20,
                    ),

                    Container(), // Đẩy nút xuống dưới cùng
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15), // Padding hai bên),
                      child: Sizedbutton2(
                        onPressFun: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Newtaskstep2(
                                      userId: widget.userId,
                                      firstPrice: sumMoney,
                                      taskTypeId: widget.taskTypeId,
                                      addPriceDetail: xValues,
                                    )),
                          );
                          if (result == true) {
                            print("pop thanh cong lan 1");
                            Navigator.pop(
                                context, true); // Pass true up to ActivityPage
                          }

                          // Pass true up to ActivityPage
                        },
                        width: double.infinity,
                        height: 50,
                        text1:
                            '$sumMoney đ / ${List.generate(state.taskType.addPriceDetails?.length ?? 0, (index) {
                          final unit = (state.taskType.addPriceDetails?[index]
                              as Map<String, dynamic>)['unit'];
                          if (index < xValues.length) {
                            final beginValue =
                                (state.taskType.addPriceDetails?[index]
                                    as Map<String, dynamic>)['beginValue'];
                            final stepValue =
                                (state.taskType.addPriceDetails?[index]
                                    as Map<String, dynamic>)['stepValue'];
                            return '${(xValues[index]['quantity'] - 1) * stepValue + beginValue} $unit';
                          } else {
                            final beginValue =
                                (state.taskType.addPriceDetails?[index]
                                    as Map<String, dynamic>)['beginValue'];
                            final id = (state.taskType.addPriceDetails?[index]
                                as Map<String, dynamic>)['id'];

                            xValues
                                .add({'addPriceDetailId': id, 'quantity': 1});
                            return '$beginValue $unit';
                          }
                        }).join(' / ')}',
                        text2: 'Tiếp theo',
                      ),
                    ),
                  ],
                ),
              ));
        } else if (state is NewTask1Error) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
