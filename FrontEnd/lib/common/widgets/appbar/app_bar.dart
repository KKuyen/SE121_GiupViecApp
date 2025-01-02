import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_info.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? color;
  final bool isHideBackButton;
  final bool isHavePadding;
  final bool isCenter;
  final bool otherBackButton;
  final bool result;
  final String type;

  const BasicAppbar(
      {this.title,
      this.result = false,
      this.isHideBackButton = false,
      this.action,
      this.color,
      this.isHavePadding = false,
      this.isCenter = false,
      this.otherBackButton = false,
      this.type = 'normal',
      super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: color ?? Colors.transparent,
      title: title ?? const Text(''),
      centerTitle: isCenter ? true : false,
      automaticallyImplyLeading: !isHideBackButton,
      actions: [
        Padding(
          padding: isHavePadding
              ? const EdgeInsets.symmetric(horizontal: 0)
              : const EdgeInsets.only(right: AppInfo.main_padding),
          child: action ?? Container(),
        )
      ],
      //elevation: 1,
      leading: isHideBackButton
          ? null
          : otherBackButton
              ? Padding(
                  padding: isHavePadding
                      ? const EdgeInsets.symmetric(horizontal: 0)
                      : const EdgeInsets.only(left: AppInfo.main_padding),
                  child: IconButton(
                    icon: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.18),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 16,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                )
              : IconButton(
                  icon: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        shape: BoxShape.circle),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 16,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    if (type != 'unnormal') {
                      Navigator.pop(context);
                    } else
                      Navigator.pop(context, result);
                  },
                ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
