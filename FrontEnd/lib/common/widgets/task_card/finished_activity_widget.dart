// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_icon.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/approveTab.dart';

class FinishedActivityWidget extends StatefulWidget {
  final VoidCallback onShowLabel;
  final int userId;
  final int numberOfTasker;
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
  final String avatar;
  final VoidCallback loading;

  final String price;
  final String note;
  final bool isPaid;

  const FinishedActivityWidget(
      {required this.onShowLabel,
      required this.userId,
      this.id = 1,
      required this.loading,
      required this.createAt,
      required this.avatar,
      this.ungCuVien = 0,
      required this.daNhan,
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
      required this.isPaid,
      super.key});

  @override
  State<FinishedActivityWidget> createState() => _FinishedActivityWidgetState();
}

class _FinishedActivityWidgetState extends State<FinishedActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Approvetab(
              userId: widget.userId,
              numberOfTasker: widget.numberOfTasker,
              id: widget.id,
            ),
          ),
        );
        widget.loading();
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
                    Text(
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
                    ),
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
