import 'package:example_10_09/core/utils/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String textButton;
  final double height;
  final double width;
  final bool loading;
  final VoidCallback? onTap;

  const DefaultButton({
    super.key, 
    required this.height, 
    required this.width, 
    required this.onTap, 
    required this.loading, 
    required this.textButton,
  });

  @override
  Widget build(BuildContext context) {
    bool buttonIsDisabled = onTap == null;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Material(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: buttonIsDisabled ? Colors.grey[300] : null,
            gradient: buttonIsDisabled ? null : const LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [Color.fromARGB(255, 247, 163, 255), Color.fromARGB(255, 57, 19, 225)],
            ),
          ),
          child: InkWell(
            splashColor: const Color.fromARGB(255, 246, 201, 255).withOpacity(.2),
            borderRadius: BorderRadius.circular(12), // Aplique o borderRadius no InkWell também
            onTap: onTap,
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: Center(
                child: loading 
                ? SizedBox(
                  height: height * .5,
                  width: height * .5,
                  child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
                )
                : Text(
                  textButton,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: AppFonts.poppins600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}