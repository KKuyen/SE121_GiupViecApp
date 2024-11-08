import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class DisableInputWaiting extends StatefulWidget {
  final String text;
  final int id;
  final String hintText;
  final Color color;

  const DisableInputWaiting({
    required this.id,
    this.text = 'Noi dung',
    this.hintText = '',
    this.color = AppColors.xam72,
    super.key,
  });

  @override
  _DisableInputStatew createState() => _DisableInputStatew();
}

class _DisableInputStatew extends State<DisableInputWaiting> {
  late TextEditingController _controller;
  bool enabled = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            cursorColor: AppColors.xanh_main,
            enabled: enabled,
            controller: _controller,
            style: TextStyle(
              color: widget.color,
              fontFamily: 'Inter',
              fontSize: 15,
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: !enabled
                    ? BorderSide.none
                    : const BorderSide(
                        color: AppColors.xam_vien,
                      ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(
                  color: AppColors.xanh_main,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (value) {
              setState(() {
                // Optional: store or process the input value
              });
            },
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            setState(() {
              enabled = !enabled;
            });
          },
        ),
      ],
    );
  }
}
