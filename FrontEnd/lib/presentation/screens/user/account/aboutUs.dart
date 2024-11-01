import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({super.key});

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.nen_the,
        appBar: const BasicAppbar(
          title: const Text(
            'Trợ giúp',
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
          Container(
              child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/taskmatebg.png'), // Đường dẫn đến ảnh của bạn
                fit: BoxFit.cover, // Đảm bảo ảnh bao phủ toàn bộ Container
              ),
            ),
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CÔNG TY TNHH PHÁT TRIỂN DỊCH VỤ',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'TASMATE',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Inter',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
          const SizedBox(
            height: 20,
          ),
          const row(
              text: 'Tổng đài',
              subtext: '1900 1234',
              icon: Icon(
                Icons.phone,
                color: AppColors.xanh_main,
                size: 33,
              )),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          const row(
              text: 'Email',
              subtext: 'taskmate@gmail.com',
              icon: Icon(
                Icons.email,
                color: AppColors.xanh_main,
                size: 30,
              )),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          const row(
              text: 'Website',
              subtext: 'taskmate.com.vn',
              icon: Icon(
                FontAwesomeIcons.earth,
                color: AppColors.xanh_main,
                size: 30,
              )),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          const row(
              text: 'Fanpage',
              subtext: 'https//www.facebook.com/taskmate',
              icon: Icon(
                FontAwesomeIcons.facebook,
                color: AppColors.xanh_main,
                size: 30,
              )),
          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Divider(),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: ExpansionTile(
              title: Text(
                'Chi nhánh Tp.Hồ Chí Minh',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                ),
              ),
              children: <Widget>[
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        'Địa chỉ: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('123 Đường ABC, Quận 1'),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        'Điện thoại: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('0123 456 789'),
                    ],
                  ),
                ),
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        'Email: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('hcm@taskmate.com.vn'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ])));
  }
}

class row extends StatefulWidget {
  final Icon icon;
  final String text;
  final String subtext;
  const row({
    required this.icon,
    required this.text,
    required this.subtext,
    super.key,
  });

  @override
  State<row> createState() => _RowState();
}

class _RowState extends State<row> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.text,
        style: const TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        widget.subtext,
        style: const TextStyle(
          color: AppColors.xanh_main,
          fontFamily: 'Inter',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.xanh_main, width: 2),
          ),
          child: widget.icon),
    );
  }
}
