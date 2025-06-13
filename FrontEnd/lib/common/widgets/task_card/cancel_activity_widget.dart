// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:se121_giupviec_app/core/configs/constants/app_icon.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/cancelTab.dart';

class CancelActivityWidget extends StatefulWidget {
  final int numberOfTasker;
  final int userId;
  final int id;
  final String taskStatus;
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
  final String cancelReason;
  final DateTime cancelAt;
  final String avatar;
  final String price;
  final String note;
  final bool isPaid;
  const CancelActivityWidget({
    required this.userId,
    required this.taskStatus,
    super.key,
    required this.avatar,
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
    this.cancelReason = 'Lý do khác',
    required this.isPaid,
    required this.cancelAt,
  });

  @override
  State<CancelActivityWidget> createState() => CancelActivityWidgetState();
}

class CancelActivityWidgetState extends State<CancelActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Canceltab(
                    userId: widget.userId,
                    cancelAt: widget.taskStatus == "TS1"
                        ? widget.startDay
                        : widget.cancelAt,
                    cancelReason: widget.taskStatus == "TS1"
                        ? 'Đã hủy vì không tìm đủ người giúp việc'
                        : widget.cancelReason,
                    cancelBy:
                        widget.taskStatus == "TS1" ? 'Hệ thống' : 'Khách hàng',
                    id: widget.id,
                  )),
        );
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: widget.avatar != null &&
                                widget.avatar.toString().isNotEmpty
                            ? Image.network(
                                AppIcon.getImageUrl(widget.avatar.toString())!,
                                width: 40, // hoặc giá trị bạn muốn, ví dụ 48
                                height: 40,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.image_not_supported,
                                        color: AppColors.xanh_main),
                              )
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
                                color: AppColors.xam72,
                                fontSize: 17,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              'DV${widget.id}',
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: AppColors.xam72,
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
                    Expanded(
                      child: Text(
                        widget.isPaid == true
                            ? 'Đã thanh toán'
                            : 'Chưa thanh toán',
                        style: TextStyle(
                          color: widget.isPaid == true
                              ? AppColors.xanh_main
                              : AppColors.do_main,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.visible,
                      ),
                    )

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
                              '${widget.deltailAddress}, ${widget.district}, ${widget.province}, ${widget.country}',
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
                SizedBox(height: 5),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Đã hủy vì lý do: ',
                              style: TextStyle(
                                color: Color(0xFF727272),
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              )),
                          SizedBox(width: 30),
                          Expanded(
                            child: Text(
                              widget.taskStatus == "TS1"
                                  ? 'Đã hủy vì không tìm đủ người giúp việc'
                                  : widget.cancelReason,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text('Đã hủy vào: ',
                              style: TextStyle(
                                color: Color(0xFF727272),
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              )),
                          Spacer(),
                          Text(
                              widget.taskStatus == "TS1"
                                  ? widget.startDay
                                      .toIso8601String()
                                      .substring(0, 10)
                                  : widget.cancelAt.toIso8601String(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.normal,
                              )),
                        ],
                      )
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
