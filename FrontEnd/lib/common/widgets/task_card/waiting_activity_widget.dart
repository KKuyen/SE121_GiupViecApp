// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:se121_giupviec_app/core/configs/assets/app_vectors.dart';

class WatingActivityWidget extends StatefulWidget {
  const WatingActivityWidget({super.key});

  @override
  State<WatingActivityWidget> createState() => WatingActivityWidgetState();
}

class WatingActivityWidgetState extends State<WatingActivityWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
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
                    padding: const EdgeInsets.fromLTRB(10, 15, 15, 10),
                    child: SvgPicture.asset(
                      AppVectors.baby_carriage_icon,
                      height: 30,
                      width: 30,
                    ),
                  ),
                  Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // Align children to the left
                    children: [
                      Row(
                        children: [
                          Text(
                            'Trông trẻ',
                            textAlign: TextAlign.left, // Align text to the left
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            '#',
                            textAlign: TextAlign.left, // Align text to the left
                            style: TextStyle(
                              fontFamily: 'Inter',
                              color: Color(0xFF4AB7B6),
                              fontSize: 17,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'DV01',
                            textAlign: TextAlign.left, // Align text to the left
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
                        'Đã đăng 20 phút trước',
                        textAlign: TextAlign.left, // Align text to the left
                        style: TextStyle(
                          color: Color(0xFF727272),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Icon(
                    Icons.more_vert,
                    color: Colors.black,
                    size: 28.0,
                  )
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 1,
                color: Color(0xFFE0E0E0),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
