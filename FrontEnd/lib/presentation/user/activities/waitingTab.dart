// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowBasic.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/user/activities/taskerList.dart';

class Waitingtab extends StatefulWidget {
  const Waitingtab({super.key});

  @override
  State<Waitingtab> createState() => _WaitingtabState();
}

class _WaitingtabState extends State<Waitingtab> {
  bool _isLabelVisible = false;

  void _showLabel() {
    setState(() {
      _isLabelVisible = true;
    });
  }

  void _hideLabel() {
    setState(() {
      _isLabelVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
          backgroundColor: AppColors.nen_the,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              'Thông tin',
              style: TextStyle(
                color: Colors.black,
                fontSize: 26,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          //noi dung
          body: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(color: AppColors.cam_main),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 22, horizontal: AppInfor1.horizontal_padding),
                    child: Row(
                      children: [
                        // Sử dụng Expanded để văn bản chiếm hết không gian có thể
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Đang tuyển chọn ứng cử viên',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                  height: 5), // Khoảng cách giữa các đoạn text
                              Text(
                                'Chú ý thời gian làm việc, nếu bạn không tuyển chọn đủ ứng cử viên thì tới thời hạn công việc sẽ tự hủy',
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Inter',
                                  color: Colors.white,
                                  // Màu chữ nhạt hơn cho phần mô tả
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                            width: 20), // Khoảng cách giữa văn bản và icon
                        // Icon cố định ở ngoài cùng bên phải
                        Icon(
                          Icons.approval,
                          color: Colors.white, // Màu của icon
                          size: 50, // Kích thước của icon
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Tasker',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '1/4 vị trí',
                            style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.xanh_main),
                          ),
                          SizedBox(width: 8)
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 4, // Số lượng tasker
                          itemBuilder: (context, index) {
                            return Taskerrowbasic(
                              taskerImageLink:
                                  'https://storage.googleapis.com/se100-af7bc.appspot.com/images/1728630023846-ANIME-PICTURES.NET_-_801133-1197x674-elden_ring-malenia_blade_of_miquella-agong-single-long_hair-wide_image-transformed.jpeg?GoogleAccessId=firebase-adminsdk-6avlp%40se100-af7bc.iam.gserviceaccount.com&Expires=1729234829&Signature=F2pTBMS10pYiDfqBskF7NyLlITUEOwhOQqOPvxmEcCkjBPTV8Lf8KvIu53UV6LNy2s6suCNU0qq97rFaXy%2FKYAquOHeG9%2F%2BstlPmPwViM1mhHF0q12ptEJAwfXbXycND%2FuyaAhNm35zNTBNy%2BdAy%2FZQR4J0CO6lXKLlYLzqP8%2BKuwI4o711lsxSYUVRv1S4%2Fi58Gm%2FF8RDTg%2Fy%2BsP2BGfV71VF44bWcvkwtwjGOkGXWMCmRjmmaDjPiJhxQX9rGDuCyi89Sh9er%2FPWD2lrg6WIh2r14XJjnMnNK8a9tNvH8F5xNDUnohHo2qqOHzWtsOzULdoUUx%2B2USosN9Y79VxQ%3D%3D',
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '5 ứng cử viên ',
                                    style: TextStyle(
                                      color: AppColors.cam_main,
                                      fontSize: 16,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            ),
                            Spacer(),
                            Sizedbutton(
                              onPressFun: _showLabel,
                              text: 'Danh sách',
                              width: 80,
                              height: 45,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Thông tin chi tiết',
                          style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Mã đơn hàng: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(width: 22),
                                disableInput(
                                  text: '#DV01',
                                  color: AppColors.xanh_main,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Tên dịch vụ: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(width: 33),
                                disableInput(
                                  text: 'Trông trẻ',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Ngày bắt đầu: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(width: 20),
                                disableInput(
                                  text: '2:00 PM Tomorrow, 16/7/2024',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Địa chỉ: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(width: 63),
                                disableInput(),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Giá: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(width: 85),
                                disableInput(
                                  text: '100.000 VND',
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Ghi chú: ',
                                    style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal)),
                                SizedBox(width: 55),
                                disableInput(
                                  text:
                                      'Nhân viên hổ trợ mang theo dụng cụ, đến sớm 15 phút',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Sizedbutton(
                        textColor: AppColors.xanh_main,
                        backgroundColor: Colors.white,
                        isStroke: true,
                        StrokeColor: AppColors.xanh_main,
                        onPressFun: () {},
                        text: 'Chỉnh sửa',
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ))),
      if (_isLabelVisible)
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
      if (_isLabelVisible)
        Center(
          child: Taskerlist(
            cancel: _hideLabel,
          ),
        ),
    ]);
  }
}

class disableInput extends StatelessWidget {
  final String text;
  final String hintext;
  final Color color;
  const disableInput({
    this.text = 'Noi dung',
    this.hintext = 'hintext',
    this.color = AppColors.xam72,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        enabled: false, // Không cho phép chỉnh sửa
        style: TextStyle(
          color: this.color,
          fontFamily: 'Inter',
          fontSize: 15,
        ),
        controller: TextEditingController(text: this.text), // Nội dung mặc định

        maxLines: null, // Cho phép nhiều dòng
        keyboardType: TextInputType.multiline, // Hỗ trợ nhiều dòng
        decoration: InputDecoration(
          hintText: this.hintext, // Hiển thị khi không có nội dung
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white, // Nền trắng
        ),
      ),
    );
  }
}
