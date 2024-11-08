import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:se121_giupviec_app/presentation/bloc/loveTasker/loveTaskers_cubit.dart';

class TwoSttButton extends StatefulWidget {
  final Icon icon;
  final Icon icon2;
  final bool sttkey;
  final int TaskerId;
  final isLove;

  const TwoSttButton({
    required this.TaskerId,
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
  int userId = 2;
  late bool isStt;

  @override
  void initState() {
    super.initState();
    isStt = widget.sttkey;
  }

  void toggleStt() {
    setState(() {
      isStt = !isStt;
    });
    if (isStt) {
      if (widget.isLove) {
        BlocProvider.of<LoveTaskersCubit>(context)
            .loveTaskers(userId, widget.TaskerId);
      } else {
        BlocProvider.of<LoveTaskersCubit>(context)
            .blockTasker(userId, widget.TaskerId);
      }
    } else {
      if (widget.isLove) {
        BlocProvider.of<LoveTaskersCubit>(context)
            .unloveTasker(userId, widget.TaskerId);
      } else {
        BlocProvider.of<LoveTaskersCubit>(context)
            .unblockTasker(userId, widget.TaskerId);
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
