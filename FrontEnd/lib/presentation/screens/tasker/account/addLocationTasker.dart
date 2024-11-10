import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/presentation/screens/user/account/chooseLocation2.dart';

import '../../../../common/helpers/SecureStorage.dart';
import '../../../bloc/Location/add_location_cubit.dart';
import '../../../bloc/Location/location_state.dart';
import 'locationTasker.dart';

class AddLocationTaskerPage extends StatefulWidget {
  const AddLocationTaskerPage({super.key});

  @override
  State<AddLocationTaskerPage> createState() => _AddLocationTaskerPageState();
}

class _AddLocationTaskerPageState extends State<AddLocationTaskerPage> {
  String? selectedProvince;
  String? selectedDistrict;
  String? selectedWard;
  String? selectedProvinceName;
  String? selectedDistrictName;
  String? selectedWardName;
  final TextEditingController _chitiet = TextEditingController();
  bool _isDefault = false;

  List<Map<String, dynamic>> provinces = [];
  List<Map<String, dynamic>> districts = [];
  List<Map<String, dynamic>> wards = [];
  SecureStorage secureStorage = SecureStorage();
  Future<String> _fetchUserId() async {
    String id = await secureStorage.readId();
    return id;
  }

  int userId = 0;
  @override
  void initState() {
    super.initState();
    fetchProvinces();
    _fetchUserId().then((value) {
      userId = (int.parse(value));
    });
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
      appBar: const BasicAppbar(
        isHideBackButton: false,
        isHavePadding: false,
        color: Colors.white,
        title: Text(
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
            if (_chitiet.text.isEmpty ||
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
                    null,
                    null,
                    "Việt Nam",
                    selectedProvinceName!,
                    selectedDistrictName!,
                    selectedWardName!,
                    _chitiet.text,
                    userId,
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
                MaterialPageRoute(
                    builder: (context) => const LocationTaskerPage()),
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
                      const SizedBox(height: 10),
                      TextField(
                        controller: _chitiet,
                        decoration: InputDecoration(
                          hintText: "Địa chỉ chi tiết ",
                          suffixIcon: GestureDetector(
                            onTap: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChooseLocationPage2()),
                              );
                              if (result != null) {
                                print("neeeeeeeeeeee" + result);
                                setState(() {
                                  _chitiet.text = result;
                                });
                              }
                            },
                            child: const Icon(
                              Icons.my_location_rounded,
                              color: AppColors.xanh_main,
                              size: 30,
                            ),
                          ),
                          border: InputBorder.none,
                        ),
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
