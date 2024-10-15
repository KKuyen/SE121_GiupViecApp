import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  String? _selectedLocation;
  final List<String> _locations = ['Location 1', 'Location 2', 'Location 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: const BasicAppbar(
        isHideBackButton: false,
        isHavePadding: false,
        color: Colors.white,
        action: Icon(
          Icons.my_location_rounded,
          color: AppColors.xanh_main,
          size: 30,
        ),
        title: Text('Thêm địa chỉ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: AppInfo.main_padding),
              child: Text(
                "Thông tin liên hệ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppInfo.main_padding, vertical: 10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Họ và tên",
                        border: InputBorder.none,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Số điện thoại",
                        border: InputBorder.none,
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: AppInfo.main_padding),
              child: Text(
                "Thông tin địa chỉ",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppInfo.main_padding, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedLocation,
                        hint: const Text('Chọn tỉnh'),
                        items: _locations.map((String location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: _selectedLocation,
                        hint: const Text('Chọn quận/huyện'),
                        items: _locations.map((String location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                          });
                        },
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "Địa chỉ cụ thể",
                        border: InputBorder.none,
                      ),
                    ),
                    const Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: "Các chi tiết khác (nếu có)",
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: AppInfo.main_padding),
              child: Text(
                "Cài đặt",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppInfo.main_padding, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text("Đặt làm địa chỉ mặc định"),
                        const Spacer(),
                        Switch(
                          trackColor:
                              MaterialStateProperty.all(AppColors.xanh_main),
                          value: true,
                          onChanged: (bool value) {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
