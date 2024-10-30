import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/user/account/chooseLocation.dart';
import 'package:http/http.dart' as http;

import '../../../bloc/Location/add_location_cubit.dart';
import '../../../bloc/Location/location_state.dart';
import 'location.dart';

class AddLocationPage extends StatefulWidget {
  const AddLocationPage({super.key});

  @override
  State<AddLocationPage> createState() => _AddLocationPageState();
}

class _AddLocationPageState extends State<AddLocationPage> {
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedWard;
  String? selectedProvinceName;
  String? selectedDistrictName;
  String? selectedWardName;
  final TextEditingController _hovaten = TextEditingController();
  final TextEditingController _sdt = TextEditingController();
  final TextEditingController _chitiet = TextEditingController();
  bool _isDefault = false;

  List<Map<String, dynamic>> provinces = [];
  List<Map<String, dynamic>> districts = [];
  List<Map<String, dynamic>> wards = [];

  @override
  void initState() {
    super.initState();
    fetchProvinces();
  }

  Future<void> fetchProvinces() async {
    try {
      final response =
          await http.get(Uri.parse("https://esgoo.net/api-tinhthanh/1/0.htm"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data["error"] == 0) {
          setState(() {
            provinces = data["data"]
                .map<Map<String, dynamic>>((province) => {
                      "id": province["id"].toString(),
                      "name": province["name"],
                    })
                .toList();
          });
        } else {
          print("Error fetching provinces: ${data["error_text"]}");
        }
      }
    } catch (e) {
      print("Error fetching provinces: $e");
    }
  }

  Future<void> fetchDistricts(String provinceId) async {
    try {
      final response = await http
          .get(Uri.parse("https://esgoo.net/api-tinhthanh/2/$provinceId.htm"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data["error"] == 0) {
          setState(() {
            districts = data["data"]
                .map<Map<String, dynamic>>((district) => {
                      "id": district["id"].toString(),
                      "name": district["name"],
                    })
                .toList();
            selectedDistrict = null;
            wards = [];
          });
        } else {
          print("Error fetching districts: ${data["error_text"]}");
        }
      }
    } catch (e) {
      print("Error fetching districts: $e");
    }
  }

  Future<void> fetchWards(String districtId) async {
    try {
      final response = await http
          .get(Uri.parse("https://esgoo.net/api-tinhthanh/3/$districtId.htm"));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data["error"] == 0) {
          setState(() {
            wards = data["data"]
                .map<Map<String, dynamic>>((ward) => {
                      "id": ward["id"].toString(),
                      "name": ward["name"],
                    })
                .toList();
            selectedWard = null;
          });
        } else {
          print("Error fetching wards: ${data["error_text"]}");
        }
      }
    } catch (e) {
      print("Error fetching wards: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: BasicAppbar(
        isHideBackButton: false,
        isHavePadding: false,
        color: Colors.white,
        action: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ChooseLocationPage()),
            );
          },
          child: const Icon(
            Icons.my_location_rounded,
            color: AppColors.xanh_main,
            size: 30,
          ),
        ),
        title: const Text(
          'Thêm địa chỉ',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppInfo.main_padding,
          vertical: 10,
        ),
        child: Sizedbutton(
          onPressFun: () {
            if (_hovaten.text.isEmpty ||
                _sdt.text.isEmpty ||
                _chitiet.text.isEmpty ||
                selectedProvinceName == null ||
                selectedDistrictName == null ||
                selectedWardName == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Vui lòng điền đầy đủ thông tin")),
              );
              return;
            }
            if (selectedProvinceName != null &&
                selectedDistrictName != null &&
                selectedWardName != null) {
              context.read<AddLocationCubit>().addNewLocation(
                    _hovaten.text,
                    _sdt.text,
                    "Việt Nam",
                    selectedProvinceName!,
                    selectedDistrictName!,
                    "${_chitiet.text}, $selectedWardName",
                    "xxooxxooxxooxx",
                    1,
                    _isDefault,
                  );
            }
          },
          text: "Lưu",
          width: double.infinity,
        ),
      ),
      body: BlocListener<AddLocationCubit, LocationState>(
        listener: (context, state) {
          if (state is LocationLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            Navigator.of(context).pop();
            if (state is LocationResponseSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Thành công")),
              );

              Navigator.of(context).pop();
              Navigator.of(context).pop();

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LocationPage()),
              );
            } else if (state is LocationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: AppInfo.main_padding,
                ),
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppInfo.main_padding,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _hovaten,
                        decoration: const InputDecoration(
                          hintText: "Họ và tên",
                          border: InputBorder.none,
                        ),
                      ),
                      const Divider(height: 1, thickness: 1),
                      TextField(
                        controller: _sdt,
                        decoration: const InputDecoration(
                          hintText: "Số điện thoại",
                          border: InputBorder.none,
                        ),
                      ),
                      const Divider(height: 1, thickness: 1),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: AppInfo.main_padding,
                ),
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
                    horizontal: AppInfo.main_padding,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      DropdownButtonFormField<String>(
                        value: selectedProvince,
                        hint: const Text("Chọn Tỉnh/Thành phố"),
                        items: provinces.map((province) {
                          return DropdownMenuItem<String>(
                            value: province["id"],
                            child: Text(province["name"]),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedProvince = value;
                            selectedProvinceName = provinces.firstWhere(
                                (element) => element["id"] == value)["name"];
                            fetchDistricts(value!);
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedDistrict,
                        hint: const Text("Chọn Quận/Huyện"),
                        items: districts.map((district) {
                          return DropdownMenuItem<String>(
                            value: district["id"],
                            child: Text(district["name"]),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value;
                            selectedDistrictName = districts.firstWhere(
                                (element) => element["id"] == value)["name"];
                            fetchWards(value!);
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedWard,
                        hint: const Text("Chọn Phường/Xã"),
                        items: wards.map((ward) {
                          return DropdownMenuItem<String>(
                            value: ward["id"],
                            child: Text(ward["name"]),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedWard = value;
                            selectedWardName = wards.firstWhere(
                                (element) => element["id"] == value)["name"];
                          });
                        },
                      ),
                      const Divider(height: 1, thickness: 1),
                      TextField(
                        controller: _chitiet,
                        decoration: const InputDecoration(
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
                  vertical: 8.0,
                  horizontal: AppInfo.main_padding,
                ),
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
                    horizontal: AppInfo.main_padding,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      const Text("Đặt làm địa chỉ mặc định"),
                      const Spacer(),
                      Switch(
                        activeTrackColor: AppColors.xanh_main,
                        inactiveTrackColor: Colors.white,
                        value: _isDefault,
                        onChanged: (bool value) {
                          setState(() {
                            _isDefault = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
