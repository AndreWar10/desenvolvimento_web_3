import 'package:flutter/material.dart';

class DefaultSnackBar {
  static void snackBarOf({required String text, required bool isSucess, required BuildContext context, int? duration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: !isSucess ? Colors.red : const Color(0xFF2E7D32),
        duration: Duration(seconds: duration ?? 4),
      ),
    );
  }

}
