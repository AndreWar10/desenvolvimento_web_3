import 'package:example_10_09/core/utils/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final Widget? sufix;
  final Function onChanged;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;

  const DefaultTextFormField(
      {super.key,
      required this.textController,
      required this.labelText,
      this.sufix,
      required this.onChanged,
      this.obscureText = false,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Container(
        height: 60,
        padding: const EdgeInsets.only(left: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey,
              width: .4,
            )),
        child: Center(
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
              TextField(
                controller: textController,
                decoration: InputDecoration(
                  labelText: null,
                  isDense: true,
                  contentPadding: const EdgeInsets.all(0),
                  border: InputBorder.none,
                  suffixIcon: sufix,
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: AppFonts.poppins400,
                ),
                onChanged: (_) => onChanged(),
                obscureText: obscureText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
