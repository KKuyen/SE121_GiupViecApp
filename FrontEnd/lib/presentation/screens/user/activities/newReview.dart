import 'dart:io'; // Import thêm để dùng File class
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart'; // Import thêm gói image_picker
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/input/textField.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowBasic.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/screens/user/activities/finishTab.dart';

class Newreview extends StatefulWidget {
  const Newreview({super.key});

  @override
  State<Newreview> createState() => _NewreviewState();
}

class _NewreviewState extends State<Newreview> {
  int Star = 5;
  List<File> images = []; // Sử dụng File để lưu hình ảnh
  final ImagePicker _picker = ImagePicker(); // Khởi tạo ImagePicker
  void _changeStar(int newStar) {
    setState(() {
      Star = newStar;
    });
  }

  // Hàm chọn ảnh từ thư viện
  Future<void> _pickImage() async {
    if (images.length < 5) {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          images.add(File(pickedFile.path)); // Thêm ảnh vào danh sách
        });
      }
    } else {
      // Hiển thị cảnh báo nếu số lượng ảnh vượt quá 5
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bạn chỉ có thể thêm tối đa 5 ảnh')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.nen_the,
      appBar: BasicAppbar(
        title: const Text(
          'Đánh giá',
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
        child: Padding(
          padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => {
                  // lỗi id nên comment lại
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const Finishtab(),
                  //   ),
                  // ),
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 2), // changes position of shadow
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
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
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Trông trẻ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      '#',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        color: Color(0xFF4AB7B6),
                                        fontSize: 17,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      'DV01',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF4AB7B6),
                                        fontSize: 17,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '9:00 20/4/2024',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF727272),
                                    fontSize: 12,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        row(
                          tieude: 'Giá:',
                          noidung: '200 000 đ / 2 cháu / 2 giờ',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        row(
                          tieude: 'Số người giúp việc:',
                          noidung: '2',
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        row(
                          tieude: 'Người giúp việc:',
                          noidung: '',
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Taskerrowbasic(
                              taskerImageLink:
                                  'https://lh3.googleusercontent.com/a/ACg8ocIbTWK1I0NcPM8SuGtujEanJwtR6OKWulhhvljuu5Td5VtEYxgD=s389-c-no',
                              taskerName: 'Nguyễn Văn A',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () => _changeStar(1),
                      child: star(nowstar: Star, starnumber: 1)),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => _changeStar(2),
                      child: star(nowstar: Star, starnumber: 2)),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => _changeStar(3),
                      child: star(nowstar: Star, starnumber: 3)),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => _changeStar(4),
                      child: star(nowstar: Star, starnumber: 4)),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                      onTap: () => _changeStar(5),
                      child: star(nowstar: Star, starnumber: 5)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Color.fromARGB(24, 0, 0, 0),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Đánh giá của bạn', style: AppTextStyle.tieudebox),
              const SizedBox(
                height: 15,
              ),
              CTextfield(
                hintText: 'Đánh giá của bạn',
              ),
              const Text('Thêm ảnh', style: AppTextStyle.tieudebox),
              SizedBox(
                height: 10,
              ),
              Wrap(
                runSpacing: 8.0,
                spacing: 8.0, // Khoảng cách giữa các phần tử
                children: [
                  // Container chứa nút chọn ảnh
                  Container(
                    height: 100,
                    width: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.xam72, width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        size: 40,
                      ),
                      onPressed: _pickImage, // Hàm chọn ảnh
                    ),
                  ),

                  // Các ảnh đã chọn
                  ...images.map((image) {
                    return Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10), // Nếu muốn bo góc
                            border: Border.all(
                                color: AppColors.xam72,
                                width: 1), // Viền bao quanh ảnh
                          ),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(5), // Bo góc cho ảnh
                            child: Image.file(
                              image,
                              height: 100,
                              width: 100,
                              fit: BoxFit
                                  .cover, // Đảm bảo ảnh bao phủ toàn bộ container
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                images.remove(image);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(127, 158, 158, 158),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Sizedbutton(
                  onPressFun: () {},
                  text: 'Gửi đánh giá',
                  width: MediaQuery.of(context).size.width),
            ],
          ),
        ),
      ),
    );
  }
}

class star extends StatelessWidget {
  final int nowstar;
  final int starnumber;
  const star({
    required this.nowstar,
    required this.starnumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      starnumber <= nowstar
          ? FontAwesomeIcons.solidStar
          : FontAwesomeIcons.star,
      color: Colors.amber,
      size: 40.0,
    );
  }
}

class row extends StatelessWidget {
  final String tieude;
  final String noidung;
  const row({
    required this.tieude,
    required this.noidung,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          tieude,
          style: TextStyle(
              fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          noidung,
        )
      ],
    );
  }
}
