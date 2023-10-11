import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Color buttonColor;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.iconData,
    required this.label,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: GestureDetector(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(
                  iconData,
                  size: 30.0,
                  color: buttonColor,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
