import 'package:flutter/material.dart';
import 'package:se121_giupviec_app/core/configs/theme/app_colors.dart';

class DisableInput extends StatefulWidget {
  final String text;
  final String hintext;
  final Color color;
  final bool enabled;
  final TextEditingController? controller;

  const DisableInput({
    required this.text,
    this.hintext = '',
    this.color = AppColors.xam72,
    this.enabled = false,
    this.controller, // Allow an external controller to be passed
    super.key,
  });

  @override
  _DisableInputState createState() => _DisableInputState();
}

class _DisableInputState extends State<DisableInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.text);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose(); // Dispose only if it's not an external controller
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        cursorColor: AppColors.xanh_main,
        enabled: widget.enabled,
        controller: _controller,
        style: TextStyle(
          color: widget.color,
          fontFamily: 'Inter',
          fontSize: 15,
        ),
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            fontFamily: 'Inter',
            fontSize: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: !widget.enabled
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
      ),
    );
  }
}
