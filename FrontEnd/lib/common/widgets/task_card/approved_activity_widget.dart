// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowBasic.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/approveTab.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/finishTab.dart';

class ApprovedActivityWidget extends StatefulWidget {
  final bool isFinished;
  final VoidCallback onShowLabel;
  final int numberOfTasker;
  final VoidCallback loading;
  final int id;
  final String serviceName;
  final DateTime startDay;
  final DateTime createAt;
  final String ownerName;
  final String district;
  final String deltailAddress;
  final String country;
  final String province;
  final String phone;
  final int ungCuVien;
  final int daNhan;

  final String price;
  final String note;

  const ApprovedActivityWidget(
      {this.isFinished = false,
      required this.onShowLabel,
      required this.id,
      required this.createAt,
      this.ungCuVien = 0,
      this.daNhan = 0,
      required this.numberOfTasker,
      required this.serviceName,
      required this.startDay,
      required this.ownerName,
      required this.district,
      required this.deltailAddress,
      required this.country,
      required this.province,
      required this.phone,
      required this.price,
      required this.note,
      required this.loading,
      super.key});

  @override
  State<ApprovedActivityWidget> createState() => ApprovedActivityWidgetState();
}

class ApprovedActivityWidgetState extends State<ApprovedActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.isFinished == false) {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Approvetab(
                numberOfTasker: widget.numberOfTasker,
                id: widget.id,
              ),
            ),
          );

          if (result == true) {
            widget.loading();
          }
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Finishtab(
                numberOfTasker: widget.numberOfTasker,
                id: widget.id,
              ),
            ),
          );
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
                offset: Offset(0, 2), // changes position of shadow
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
                      child: SvgPicture.asset(
                        AppVectors.baby_carriage_icon,
                        height: 30,
                        width: 30,
                      ),
                    ),
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
                                color: AppColors.xanh_main,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              'DV${widget.id}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: AppColors.xanh_main,
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
                        widget.startDay.toIso8601String(),
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
                              widget.deltailAddress +
                                  ', ' +
                                  widget.district +
                                  ', ' +
                                  widget.province +
                                  ', ' +
                                  widget.country,
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
                    padding: EdgeInsets.fromLTRB(5, 2, 5, 5),
                    child: Row(
                      children: [
                        Text(
                          'Ghi chú:   ',
                          style: TextStyle(
                            color: Color(0xFF727272),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(width: 18),
                        Expanded(
                          child: Text(
                            widget.note,
                            style: TextStyle(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${widget.daNhan}/${widget.numberOfTasker} vị trí',
                              style: const TextStyle(
                                color: AppColors.xanh_main,
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Sizedbutton(
                        onPressFun: widget.onShowLabel,
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
      )),
    );
  }
}
