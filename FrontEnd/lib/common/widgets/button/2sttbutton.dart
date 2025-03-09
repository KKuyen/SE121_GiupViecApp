import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_cubit.dart';
import 'package:se121_giupviec_app/presentation/bloc/notification/notification_cubit.dart';

class TwoSttButton extends StatefulWidget {
  final Icon icon;
  final Icon icon2;
  final bool sttkey;
  final int TaskerId;

  final int userId;
  final isLove;

  const TwoSttButton({
    required this.TaskerId,
    required this.userId,
    required this.isLove,
    super.key,
    this.sttkey = true,
    required this.icon,
    required this.icon2,
  });

  @override
  State<TwoSttButton> createState() => _TwoSttButtonState();
}

class _TwoSttButtonState extends State<TwoSttButton> {
  late String userName;
  Future<void> getUserName() async {
    var storageUserName = await SecureStorage().readName();
    setState(() {
      userName = storageUserName;
    });
  }

  late bool isStt;

  @override
  void initState() {
    super.initState();
    isStt = widget.sttkey;
    getUserName();
  }

  void toggleStt() {
    setState(() {
      isStt = !isStt;
    });
    if (isStt) {
      if (widget.isLove) {
        BlocProvider.of<LoveTaskersCubit>(context)
            .loveTaskers(widget.userId, widget.TaskerId);
        BlocProvider.of<allNotificationCubit>(context).addANotificaiton(
            widget.TaskerId,
            "Bạn đã được yêu thích",
            "Bạn đã được  khách hàng $userName yêu thích.Bây giờ bạn có thể ứng cử tự động công việc của khách hàng đó",
            "love.jpg");
      } else {
        BlocProvider.of<LoveTaskersCubit>(context)
            .blockTasker(widget.userId, widget.TaskerId);
        BlocProvider.of<allNotificationCubit>(context).addANotificaiton(
            widget.TaskerId,
            "Một khách hàng đã bỏ yêu thích",
            "Khách hàng $userName đã bỏ yêu thích bạn.",
            "unlove.jpg");
      }
    } else {
      if (widget.isLove) {
        BlocProvider.of<LoveTaskersCubit>(context)
            .unloveTasker(widget.userId, widget.TaskerId);
        BlocProvider.of<allNotificationCubit>(context).addANotificaiton(
            widget.TaskerId,
            "Bạn đã bị chặn",
            "Bạn đã bị  khách hàng $userName chặn.Bây giờ bạn không thể thấy công việc của khách hàng đó",
            "block.jpg");
      } else {
        BlocProvider.of<LoveTaskersCubit>(context)
            .unblockTasker(widget.userId, widget.TaskerId);
        BlocProvider.of<allNotificationCubit>(context).addANotificaiton(
            widget.TaskerId,
            "Một khách hàng đã bỏ chặn bạn",
            "Khách hàng $userName vừa mới bỏ chặn bạn. Bây giờ bạn có thể thấy và ứng cử công việc của khách hàng đó một cách bình thường",
            "unblock.jpg");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return isStt
        ? IconButton(onPressed: toggleStt, icon: widget.icon)
        : IconButton(onPressed: toggleStt, icon: widget.icon2);
  }
}
