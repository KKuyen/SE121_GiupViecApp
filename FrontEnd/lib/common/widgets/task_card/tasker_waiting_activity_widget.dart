import 'package:flutter/material.dart';

import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';

import 'package:se121_giupviec_app/core/configs/constants/app_icon.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

import 'package:se121_giupviec_app/presentation/screens/tasker/activities/ApplyTaskTab.dart';

class TaskerWatingActivityWidget extends StatefulWidget {
  final VoidCallback loading;
  final int numberOfTasker;
  final int id;
  final String serviceName;
  final DateTime startDay;
  final DateTime createAt;
  final String ownerName;
  final String district;
  final String detailAddress;
  final String country;
  final String province;
  final String phone;
  final int ungCuVien;
  final int daNhan;
  final String avatar;
  final String price;
  final String note;
  final int customerId;
  final int accountId;

  const TaskerWatingActivityWidget(
      {required this.id,
      required this.createAt,
      this.ungCuVien = 0,
      this.daNhan = 0,
      required this.customerId,
      required this.accountId,
      required this.numberOfTasker,
      required this.serviceName,
      required this.startDay,
      required this.ownerName,
      required this.district,
      required this.detailAddress,
      required this.country,
      required this.province,
      required this.phone,
      required this.price,
      required this.note,
      required this.avatar,
      required this.loading,
      super.key});

  @override
  State<TaskerWatingActivityWidget> createState() =>
      TaskerWatingActivityWidgetState();
}

class TaskerWatingActivityWidgetState
    extends State<TaskerWatingActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ApplyTaskTab(
                    customerId: widget.customerId,
                    accountId: widget.accountId,
                    loading: widget.loading,
                    numberOfTasker: widget.numberOfTasker,
                    id: widget.id,
                  )),
        );
        if (result == true) {
          print("pop thanh cong lan 1");
          widget.loading();
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 15, 5),
                          child: AppIcon.getIconCamMain(widget.avatar)),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.serviceName,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              const Text(
                                '#',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  color: AppColors.cam_main,
                                  fontSize: 17,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                'DV${widget.id}',
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: AppColors.cam_main,
                                  fontSize: 17,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            widget.createAt.toIso8601String(),
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
                      const Spacer(),
                      // const Icon(
                      //   Icons.more_vert,
                      //   color: Colors.black,
                      //   size: 25.0,
                      // )
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                    child: Row(
                      children: [
                        const Text(
                          'Ngày bắt đầu:   ',
                          style: TextStyle(
                            color: Color(0xFF727272),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          widget.startDay.toIso8601String().substring(0, 10),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Địa chỉ:   ',
                          style: TextStyle(
                            color: Color(0xFF727272),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.ownerName,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                '${widget.detailAddress}, ${widget.district}, ${widget.province}, ${widget.country}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.normal,
                                ),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                              ),
                              Text(
                                widget.phone,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                    child: Row(
                      children: [
                        const Text(
                          'Giá:   ',
                          style: TextStyle(
                            color: Color(0xFF727272),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 48),
                        Text(
                          widget.price,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (widget.note != '')
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 5),
                      child: Row(
                        children: [
                          const Text(
                            'Ghi chú:   ',
                            style: TextStyle(
                              color: Color(0xFF727272),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Text(
                              widget.note,
                              style: const TextStyle(
                                color: AppColors.xam72,
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 0),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Sizedbutton(
                          isEnabled: false,
                          onPressFun: () {},
                          text: 'Chờ khách hàng liên hệ',
                          backgroundColor: Colors.white,
                          textColor: AppColors.xam72,
                          isStroke: true,
                          StrokeColor: AppColors.xam72,
                          width: MediaQuery.of(context).size.width - 50,
                          height: 45,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
