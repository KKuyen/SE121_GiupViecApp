import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/review_card/review_card_widget.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/aReview_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/review/aReview_state.dart';

class Reviewview extends StatefulWidget {
  final int taskId;
  final int taskerId;
  final String taskerName;
  final String taskerPhone;
  final String taskerImageLink;

  const Reviewview(
      {super.key,
      required this.taskId,
      required this.taskerId,
      required this.taskerName,
      required this.taskerPhone,
      required this.taskerImageLink});

  @override
  State<Reviewview> createState() => _ReviewviewState();
}

class _ReviewviewState extends State<Reviewview> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AReviewCubit>(context)
        .getAReviews(widget.taskerId, widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AReviewCubit, AReviewState>(
      builder: (context, state) {
        if (state is AReviewLoading) {
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
                        child: CircularProgressIndicator()))),
          );
        } else if (state is AReviewSuccess) {
          return Scaffold(
            appBar: const BasicAppbar(
              title: Text(
                'Review của bạn',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              isHideBackButton: false,
              isHavePadding: true,
              color: Colors.white,
              result: false,
              type: 'unnormal',
            ),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.all(AppInfo.main_padding),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: ReviewCardWidget(
                        userName: state.review.userName ?? '',
                        taskTypeImage: widget.taskerImageLink ?? '',
                        taskTypeName: widget.taskerName ?? '',
                        userAvatar: state.review.userAvatar ?? '',
                        star: state.review.star ?? 0,
                        time: state.review.createdAt.toIso8601String(),
                        content: state.review.content ?? '',
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          );
        } else if (state is AReviewError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
