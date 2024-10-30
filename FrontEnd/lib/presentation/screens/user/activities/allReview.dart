import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/review_card/review_card_widget.dart';

import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/allReview_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/allReview_state.dart';

class Allreview extends StatefulWidget {
  final int taskerId;
  const Allreview({super.key, required this.taskerId});

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
  void initState() {
    super.initState();
    context.read<allReviewCubit>().getAllReviews(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<allReviewCubit, AllReviewState>(
      builder: (context, state) {
        if (state is AllReviewLoading) {
          return Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
              ),
              child: const Center(
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        } else if (state is AllReviewSuccess) {
          final reviewLs = state.reviewLs;
          List<int> starCount = [0, 0, 0, 0, 0];
          int totalStar = 0;

          for (var review in reviewLs) {
            if (review.star >= 1 && review.star <= 5) {
              starCount[review.star - 1]++;
              totalStar += review.star;
            }
          }

          double avgStar =
              reviewLs.isNotEmpty ? totalStar / reviewLs.length : 0.0;

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: BasicAppbar(
              title: Text(
                'Tất cả đánh giá',
                style: const TextStyle(
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
                              avgStar.toStringAsFixed(1),
                              style: const TextStyle(
                                  color: Colors.amber, fontSize: 30),
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < avgStar
                                      ? FontAwesomeIcons.solidStar
                                      : FontAwesomeIcons.star,
                                  color: Colors.amber,
                                  size: 12,
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(width: 15),
                        Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => updateSelectedStar('6'),
                                  child: AllStar(
                                    star: '6',
                                    review: reviewLs.length.toString(),
                                    sang: selectedStar,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () => updateSelectedStar('5'),
                                  child: SelectStar(
                                    star: '5',
                                    review: starCount[4].toString(),
                                    sang: selectedStar,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () => updateSelectedStar('4'),
                                  child: SelectStar(
                                    star: '4',
                                    review: starCount[3].toString(),
                                    sang: selectedStar,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => updateSelectedStar('3'),
                                  child: SelectStar(
                                    star: '3',
                                    review: starCount[2].toString(),
                                    sang: selectedStar,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () => updateSelectedStar('2'),
                                  child: SelectStar(
                                    star: '2',
                                    review: starCount[1].toString(),
                                    sang: selectedStar,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () => updateSelectedStar('1'),
                                  child: SelectStar(
                                    star: '1',
                                    review: starCount[0].toString(),
                                    sang: selectedStar,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: reviewLs.length,
                        itemBuilder: (context, index) {
                          if (selectedStar == '6' ||
                              reviewLs[index].star.toString() == selectedStar) {
                            return Column(
                              children: [
                                ReviewCardWidget(
                                  taskTypeImage: (reviewLs[index].taskType
                                          as Map<String, dynamic>)['image'] ??
                                      '',
                                  taskTypeName: (reviewLs[index].taskType
                                          as Map<String, dynamic>)['name'] ??
                                      '',
                                  time: (reviewLs[index].task
                                          as Map<String, dynamic>)['time'] ??
                                      '',
                                  userAvatar: reviewLs[index].userAvatar ?? '',
                                  userName: reviewLs[index].userName ?? '',
                                  content: reviewLs[index].content ?? '',
                                  image1: reviewLs[index].image1,
                                  image2: reviewLs[index].image2,
                                  image3: reviewLs[index].image3,
                                  image4: reviewLs[index].image4,
                                  star: reviewLs[index].star ?? 0,
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                              ],
                            );
                          }
                          return SizedBox
                              .shrink(); // Return an empty widget if the condition is not met.
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is AllReviewError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
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
              "${widget.star} ",
              style: TextStyle(
                color: widget.sang == widget.star ? Colors.amber : Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Icon(
              FontAwesomeIcons.solidStar,
              color: Colors.amber,
              size: 13,
            ),
            Text(
              ' (${widget.review})',
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
