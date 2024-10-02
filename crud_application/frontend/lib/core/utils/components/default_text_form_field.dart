import 'package:example_10_09/core/utils/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final Widget? sufix;
  final Function onChanged;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;
  final FocusNode _focusNode = FocusNode();

  DefaultTextFormField({
    super.key,
    required this.textController,
    required this.labelText,
    this.sufix,
    required this.onChanged,
    this.obscureText = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: () => _focusNode.requestFocus(),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: .4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    labelText,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black45,
                      fontFamily: AppFonts.poppins400,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: textController,
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                        labelText: null,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
                      cursorHeight: 16.0,
                      cursorWidth: 2,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: AppFonts.poppins400,
                      ),
                      onChanged: (_) => onChanged(),
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      obscureText: obscureText,
                    ),
                  ),
                  if (sufix != null) sufix!,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
