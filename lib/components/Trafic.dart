import 'package:flutter/material.dart';

class Trafict extends StatelessWidget {
  final String label;
  final IconData iconData;
  final int count;

  const Trafict({
    super.key,
    required this.label,
    required this.iconData,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      height: 90.0,
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            size: 30.0,
            color: Colors.blue,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
