import 'package:flutter/material.dart';

import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';

import 'package:se121_giupviec_app/core/configs/constants/app_icon.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/tasker/activities/MyTaskTab.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/User.dart';
import '../../../presentation/screens/user/message/detailMessage.dart';
import '../../helpers/SecureStorage.dart';

class TaskerApproveWidget extends StatefulWidget {
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
  final String customerName;

  const TaskerApproveWidget(
      {required this.id,
      required this.createAt,
      this.ungCuVien = 0,
      required this.customerId,
      required this.accountId,
      this.daNhan = 0,
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
      required this.customerName,
      super.key});

  @override
  State<TaskerApproveWidget> createState() => TaskerWatingActivityWidgetState();
}

class TaskerWatingActivityWidgetState extends State<TaskerApproveWidget> {
  SecureStorage secureStorage = SecureStorage();
  Future<User> _fetchUserData() async {
    String name = await secureStorage.readName();
    String id = await secureStorage.readId();
    String avatar = await secureStorage.readAvatar();
    User user = User(id: int.parse(id), name: name, avatar: avatar);
    print("user" + user.id.toString());
    return user;
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Mytasktab(
                    customerId: widget.customerId,
                    accountId: widget.accountId,
                    id: widget.id,
                    numberOfTasker: widget.numberOfTasker,
                    loading: widget.loading,
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
                          onPressFun: () async {
                            User user = await _fetchUserData();
                            User targetUser = User(
                                id: widget.customerId,
                                name: widget.customerName,
                                avatar: widget.avatar);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Detailmessage(
                                        targetUser: targetUser,
                                        sourseUser: user)));
                          },
                          text: 'Nhắn tin',
                          backgroundColor: Colors.white,
                          textColor: AppColors.cam_main,
                          isStroke: true,
                          StrokeColor: AppColors.cam_main,
                          width: MediaQuery.of(context).size.width / 2 - 30,
                          height: 45,
                        ),
                        const SizedBox(width: 10),
                        Sizedbutton(
                          onPressFun: () {
                            _makePhoneCall(widget.phone);
                          },
                          text: 'Gọi điện',
                          backgroundColor: AppColors.cam_main,
                          width: MediaQuery.of(context).size.width / 2 - 30,
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
