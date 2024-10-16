import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/button/2sttbutton.dart';
import 'package:se121_giupviec_app/common/widgets/button/sizedbutton.dart';
import 'package:se121_giupviec_app/common/widgets/review_card/review_card_widget.dart';
import 'package:se121_giupviec_app/common/widgets/task_type_mini_card/mini_tt_card_widget.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/text/app_text_style.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/user/activities/allReview.dart';

class Taskerprofile extends StatefulWidget {
  const Taskerprofile({super.key});

  @override
  State<Taskerprofile> createState() => _TaskerprofileState();
}

class _TaskerprofileState extends State<Taskerprofile> {
  bool isLove = false;

  bool isBlock = false;
  void toggleLove() {
    setState(() {
      isLove = !isLove;
    });
  }

  void toggleBlock() {
    setState(() {
      isBlock = !isBlock;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 250,
                decoration: const BoxDecoration(color: Colors.blue),
              ),
              Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 250),
                decoration: const BoxDecoration(color: AppColors.nen_the),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppInfor1.horizontal_padding,
                      65,
                      AppInfor1.horizontal_padding,
                      0),
                  child: Column(
                    children: [
                      Text(
                        'Trịnh Trần Phương Tuấn  ',
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                            color: Colors.black,
                            fontSize: 23),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Châm ngôn của chúng tôi khách hàng là thượng đế, sẵn sàng phục vụ khách hàng, mọi lúc, mọi nơi.',
                        style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                            color: AppColors.xam72,
                            fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TwoSttButton(
                            sttkey: isBlock,
                            icon: const Icon(
                              Icons.block,
                              color: AppColors.do_main,
                              size: 33,
                            ),
                            icon2: const Icon(
                              Icons.block,
                              color: AppColors.xam72,
                              size: 33,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          TwoSttButton(
                            sttkey: isLove,
                            icon: const Icon(
                              FontAwesomeIcons.solidHeart,
                              color: AppColors.xanh_main,
                              size: 32,
                            ),
                            icon2: const Icon(
                              FontAwesomeIcons.heart,
                              color: AppColors.xam72,
                              size: 32,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.solidMessage,
                              color: AppColors.xam72,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              AppInfor1.horizontal_padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Thông tin cá nhân',
                                style: AppTextStyle.tieudebox,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text('Họ và Tên: ',
                                      style: AppTextStyle.textthuong),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Text(
                                      'Trịnh Trần Phương Tuấn',
                                      softWrap: true,
                                      style: AppTextStyle.textthuong,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  const Text('Email: ',
                                      style: AppTextStyle.textthuong),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Text(
                                      'Trịnh Trần Phương Tuấn',
                                      softWrap: true,
                                      style: AppTextStyle.textthuong,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  const Text('Số điện thoại: ',
                                      style: AppTextStyle.textthuong),
                                  const SizedBox(width: 25),
                                  Expanded(
                                    child: Text(
                                      'Trịnh Trần Phương Tuấn',
                                      softWrap: true,
                                      style: AppTextStyle.textthuong,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const Text('Công việc: ',
                                  style: AppTextStyle.textthuong),
                              const SizedBox(
                                height: 15,
                              ),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: List.generate(
                                  6, // Replace with the number of items you want
                                  (index) => MiniTtCardWidget(
                                    taskType: 'Title $index',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(
                              AppInfor1.horizontal_padding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Đánh giá',
                                style: AppTextStyle.tieudebox,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '2,4/5',
                                    style: TextStyle(
                                        color: Colors.amber,
                                        fontSize: 22,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  const Icon(
                                    FontAwesomeIcons.solidStar,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  Spacer(),
                                  Text(
                                    'Từ 200 lượt đánh giá',
                                    style: AppTextStyle.textthuongxam,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Column(
                                children: List.generate(
                                  2,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ReviewCardWidget(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Sizedbutton(
                                onPressFun: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Allreview()),
                                  );
                                },
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                text: 'Xem tất cả',
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(AppInfor1.horizontal_padding,
                    182, AppInfor1.horizontal_padding, 0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 171, 28, 28),
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // ignore: prefer_const_constructors
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 35,
            left: 10,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                height: 50,
                width: 50,
                child: Center(
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(93, 0, 0, 0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
