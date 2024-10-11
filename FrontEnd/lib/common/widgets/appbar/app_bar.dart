import 'package:flutter/material.dart';

class BasicAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final Color? color;
  final bool isHideBackButton;
  final bool isHavePadding;
  const BasicAppbar(
      {this.title,
      this.isHideBackButton = false,
      this.action,
      this.color,
      this.isHavePadding = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isHavePadding
          ? const EdgeInsets.symmetric(horizontal: 0)
          : const EdgeInsets.symmetric(horizontal: 13),
      child: AppBar(
        backgroundColor: color ?? Colors.transparent,
        title: title ?? const Text(''),
        centerTitle: false,
        automaticallyImplyLeading: !isHideBackButton,
        actions: [action ?? Container()],
        leading: isHideBackButton
            ? null
            : IconButton(
                icon: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.05),
                      shape: BoxShape.circle),
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 15,
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
