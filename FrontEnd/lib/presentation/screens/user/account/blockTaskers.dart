import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/app_bar.dart';
import 'package:se121_giupviec_app/common/widgets/appbar/header.dart';
import 'package:se121_giupviec_app/common/widgets/button/2sttbutton.dart';
import 'package:se121_giupviec_app/common/widgets/tasker_row/taskerRowAbutton.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';
import 'package:se121_giupviec_app/presentation/bloc/blockTasker/blockTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/blockTasker/blockTaskers_state.dart';
import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_state.dart';

class Blocktaskers extends StatefulWidget {
  const Blocktaskers({super.key});

  @override
  State<Blocktaskers> createState() => _blocktaskersState();
}

class _blocktaskersState extends State<Blocktaskers> {
  bool isBlock = false;
  void toggleLove() {
    setState(() {
      isBlock = !isBlock;
    });
  }

  @override
  void initState() {
    super.initState();
    final TaskerList =
        BlocProvider.of<LoveTaskersCubit>(context).getLoveTaskers(2);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoveTaskersCubit, LoveTaskersState>(
      builder: (context, state) {
        if (state is LoveTaskersLoading) {
          return Center(
            child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
                child: Center(
                    child: Container(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator()))),
          );
        } else if (state is LoveTaskersSuccess) {
          return Scaffold(
            backgroundColor: AppColors.nen_the,
            appBar: const BasicAppbar(
              title: Text(
                'Danh sách chặn',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  const Header(
                    color: AppColors.do_main,
                    text1: "Bạn đã chặn 2 tasker",
                    text2:
                        "Những tasker bị hạn chế không thể ứng cử công việc của bạn",
                    icon: Icon(
                      Icons.block,
                      color: Colors.white,
                      size: 47,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppInfor1.horizontal_padding),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.blockTaskers
                          .length, // Replace with the actual number of taskers
                      itemBuilder: (context, index) {
                        // tam thoi comment
                        return Taskerrowabutton(
                            taskerId: (state.blockTaskers[index].tasker
                                as Map<String, dynamic>)['id'],
                            taskerName: (state.blockTaskers[index].tasker
                                as Map<String, dynamic>)['name'],
                            iconButton: const TwoSttButton(
                              sttkey: true,
                              icon: Icon(
                                Icons.block,
                                color: AppColors.do_main,
                                size: 33,
                              ),
                              icon2: Icon(
                                Icons.block,
                                color: AppColors.xam72,
                                size: 33,
                              ),
                            ));
                      },
                    ),
                  )
                ])),
          );
        } else if (state is LoveTaskersError) {
          return Center(child: Text('Error: ${state.message}'));
        } else {
          return const Center(child: Text('No tasks found'));
        }
      },
    );
  }
}
