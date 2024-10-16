import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isExpanded = false;
  int _selectedRadio = 1; // Biến lưu trạng thái của radio button
  int _selectedNumber = 1; // Biến lưu giá trị số từ 1 đến 5
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: BasicAppbar(
          title: const Text(
            'Cài đặt',
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ExpansionTile(
              title: Row(
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.xanh_main, width: 1.5),
                      ),
                      child: Icon(
                        Icons.key,
                        color: AppColors.xanh_main,
                        size: 30,
                      )),
                  const SizedBox(width: 10),
                  Text(
                    'Đổi mật khẩu',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Mật khẩu cũ',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), // Bo góc viền
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey, // Màu viền khi chưa focus
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.xanh_main, // Màu viền khi focus
                              width: 2.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey, // Màu nhãn khi chưa focus
                          ),
                          floatingLabelStyle: TextStyle(
                            color: AppColors.xanh_main, // Màu nhãn khi focus
                          ),
                          focusColor: AppColors
                              .xanh_main, // Màu của TextField khi focus
                        ),
                        cursorColor:
                            AppColors.xanh_main, // Màu con trỏ khi nhập
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'mật khẩu mới',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), // Bo góc viền
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey, // Màu viền khi chưa focus
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.xanh_main, // Màu viền khi focus
                              width: 2.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey, // Màu nhãn khi chưa focus
                          ),
                          floatingLabelStyle: TextStyle(
                            color: AppColors.xanh_main, // Màu nhãn khi focus
                          ),
                          focusColor: AppColors
                              .xanh_main, // Màu của TextField khi focus
                        ),
                        cursorColor:
                            AppColors.xanh_main, // Màu con trỏ khi nhập
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Nhập lại mạt khẩu mới',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(8.0), // Bo góc viền
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey, // Màu viền khi chưa focus
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.xanh_main, // Màu viền khi focus
                              width: 2.0,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.grey, // Màu nhãn khi chưa focus
                          ),
                          floatingLabelStyle: TextStyle(
                            color: AppColors.xanh_main, // Màu nhãn khi focus
                          ),
                          focusColor: AppColors
                              .xanh_main, // Màu của TextField khi focus
                        ),
                        cursorColor:
                            AppColors.xanh_main, // Màu con trỏ khi nhập
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Sizedbutton(
                        onPressFun: () {},
                        height: 45,
                        text: 'Đổi mật khẩu',
                        width: MediaQuery.of(context).size.width,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: const Divider(),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.xanh_main, width: 1.5),
                        ),
                        child: Icon(
                          Icons.auto_awesome,
                          color: AppColors.xanh_main,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Tự động duyệt',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(), // Đẩy `Switch` về bên phải
                      Switch(
                        value: isExpanded,
                        activeColor: AppColors.xanh_main, // Màu xanh khi bật
                        activeTrackColor: AppColors.xanh_main
                            .withOpacity(0.5), // Track khi bật
                        inactiveThumbColor:
                            AppColors.xam72, // Nền trắng khi tắt
                        inactiveTrackColor:
                            Colors.transparent, // Viền đen khi tắt
                        onChanged: (value) {
                          setState(() {
                            isExpanded = value; // Bật/tắt nội dung con
                          });
                        },
                      ),
                    ],
                  ),
                  if (isExpanded)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          RadioListTile(
                            activeColor: AppColors.xanh_main,
                            title: const Text('Chỉ nhận tasker yêu thích'),
                            value: 1,
                            groupValue: _selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadio = value!;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(),
                          ),
                          RadioListTile(
                            activeColor: AppColors.xanh_main,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Chỉ nhận trên'),
                                // Slider để chọn số từ 1 đến 5
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(FontAwesomeIcons.angleUp),
                                          iconSize: 15,
                                          onPressed: () {
                                            setState(() {
                                              if (_selectedNumber < 5) {
                                                _selectedNumber++;
                                              }
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(FontAwesomeIcons.angleDown,
                                              size: 15),
                                          onPressed: () {
                                            setState(() {
                                              if (_selectedNumber > 1) {
                                                _selectedNumber--;
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: AppColors.xam72,
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 1,
                                        ),
                                        child: Row(
                                          children: [
                                            Text(_selectedNumber.toString()),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Icon(
                                              FontAwesomeIcons.solidStar,
                                              color: Colors.amber,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ), // Hiển thị số đã chọn
                                  ],
                                ),
                              ],
                            ),
                            value: 2,
                            groupValue: _selectedRadio,
                            onChanged: (value) {
                              setState(() {
                                _selectedRadio = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )
          ]),
        ));
  }
}
