import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool enabled;

  const SignUpButton({super.key, required this.onTap, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: enabled ? onTap : null,
        child: const Text(
          "Create Account",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
