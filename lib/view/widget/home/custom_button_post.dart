import 'package:flutter/material.dart';

class CustomPostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final void Function()? onTap;

  const CustomPostButton(
      {super.key, required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 25,
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 4,
              ),
              Text(label)
            ],
          ),
        ),
      ),
    );
  }
}