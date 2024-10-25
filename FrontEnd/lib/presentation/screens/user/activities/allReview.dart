import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/review_card/review_card_widget.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class Allreview extends StatefulWidget {
  const Allreview({super.key});

  @override
  State<Allreview> createState() => _AllreviewState();
}

class _AllreviewState extends State<Allreview> {
  String selectedStar = '6';

  void updateSelectedStar(String star) {
    setState(() {
      selectedStar = star;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: BasicAppbar(
        title: const Text(
          'Tất cả đánh giá',
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        '3.4',
                        style: TextStyle(color: Colors.amber, fontSize: 30),
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.solidStar,
                            color: Colors.amber,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Icon(
                            FontAwesomeIcons.solidStar,
                            color: Colors.amber,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Icon(
                            FontAwesomeIcons.solidStar,
                            color: Colors.amber,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Icon(
                            FontAwesomeIcons.solidStar,
                            color: Colors.amber,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Icon(
                            FontAwesomeIcons.solidStar,
                            color: Colors.amber,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              updateSelectedStar('6');
                            },
                            child: AllStar(
                              star: '6',
                              review: '200',
                              sang: selectedStar,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () => updateSelectedStar('5'),
                            child: SelectStar(
                                star: '5', review: '200', sang: selectedStar),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              updateSelectedStar('4');
                            },
                            child: SelectStar(
                                star: '4', review: '200', sang: selectedStar),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                updateSelectedStar('3');
                              },
                              child: SelectStar(
                                  star: '3',
                                  review: '200',
                                  sang: selectedStar)),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              updateSelectedStar('2');
                            },
                            child: SelectStar(
                                star: '2', review: '200', sang: selectedStar),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              updateSelectedStar('1');
                            },
                            child: SelectStar(
                                star: '1', review: '200', sang: selectedStar),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                height:
                    MediaQuery.of(context).size.height, // Set a fixed height
                child: ListView.builder(
                  itemCount: 10, // Replace with the actual number of reviews
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ReviewCardWidget(),
                        const SizedBox(
                          height: 10,
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectStar extends StatefulWidget {
  final String star;
  final String review;
  final String sang;

  const SelectStar({
    this.star = '5',
    this.review = '200',
    this.sang = 'Tat ca',
    super.key,
  });

  @override
  State<SelectStar> createState() => _SelectStarState();
}

class _SelectStarState extends State<SelectStar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: 40,
      decoration: BoxDecoration(
        color: widget.sang == widget.star ? Colors.white : AppColors.nen_the,
        border: Border.all(
          color: widget.sang == widget.star ? Colors.amber : AppColors.nen_the,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.star + " ",
              style: TextStyle(
                color: widget.sang == widget.star ? Colors.amber : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              FontAwesomeIcons.solidStar,
              color: Colors.amber,
              size: 13,
            ),
            Text(
              ' (5) ',
              style: TextStyle(
                color: widget.sang == widget.star ? Colors.amber : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AllStar extends StatefulWidget {
  final String star;
  final String review;
  final String sang;

  const AllStar({
    this.star = '5',
    this.review = '200',
    this.sang = 'Tat ca',
    super.key,
  });

  @override
  State<AllStar> createState() => _allStarState();
}

class _allStarState extends State<AllStar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 95,
      height: 40,
      decoration: BoxDecoration(
        color: widget.sang == widget.star ? Colors.white : AppColors.nen_the,
        border: Border.all(
          color: widget.sang == widget.star ? Colors.amber : AppColors.nen_the,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tất cả',
              style: TextStyle(
                color: widget.sang == widget.star ? Colors.amber : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              " (" + widget.review + ")",
              style: TextStyle(
                color: widget.sang == widget.star ? Colors.amber : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
