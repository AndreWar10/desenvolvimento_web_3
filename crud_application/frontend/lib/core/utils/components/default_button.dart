import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String textButton;
  final VoidCallback? onTap;

  const DefaultButton({super.key, required this.textButton, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12)
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        onPressed: onTap,
        child: Text(
          textButton, 
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}