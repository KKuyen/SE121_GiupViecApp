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

  const BasicAppbar(
      {this.title,
      this.isHideBackButton = false,
      this.action,
      this.color,
      this.isHavePadding = false,
      this.isCenter = false,
      this.otherBackButton = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isHavePadding
          ? const EdgeInsets.symmetric(horizontal: 0)
          : const EdgeInsets.symmetric(horizontal: AppInfo.main_padding),
      child: AppBar(
        backgroundColor: color ?? Colors.transparent,
        title: title ?? const Text(''),
        centerTitle: isCenter ? true : false,
        automaticallyImplyLeading: !isHideBackButton,
        actions: [action ?? Container()],
        leading: isHideBackButton
            ? null
            : otherBackButton
                ? IconButton(
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
                      Navigator.of(context).pop();
                    },
                  ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
