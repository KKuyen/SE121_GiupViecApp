import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class TwoSttButton extends StatefulWidget {
  final Icon icon;
  final Icon icon2;
  final bool sttkey;

  const TwoSttButton({
    super.key,
    this.sttkey = true,
    required this.icon,
    required this.icon2,
  });

  @override
  State<TwoSttButton> createState() => _TwoSttButtonState();
}

class _TwoSttButtonState extends State<TwoSttButton> {
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
  }

  @override
  Widget build(BuildContext context) {
    return isStt
        ? IconButton(onPressed: toggleStt, icon: widget.icon)
        : IconButton(onPressed: toggleStt, icon: widget.icon2);
  }
}
