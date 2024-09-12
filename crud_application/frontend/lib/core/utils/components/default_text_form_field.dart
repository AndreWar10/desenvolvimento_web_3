import 'package:flutter/material.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final String labelText;
  final Widget? sufix;
  final Function onChanged;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;

  const DefaultTextFormField({super.key, required this.textController, required this.labelText, this.sufix, required this.onChanged, this.obscureText = false, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: SizedBox(
        height: 48,
        child: TextField(
          controller: textController,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
            suffixIcon: sufix,
          ),
          onChanged: (_) => onChanged(),
          obscureText: obscureText,
        ),
      ),
    );
  }
}