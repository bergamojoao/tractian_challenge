import 'package:flutter/material.dart';

class CompanyButton extends StatelessWidget {
  final void Function()? onPressed;
  final String title;

  const CompanyButton({
    super.key,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(Colors.blue),
        iconColor: const WidgetStatePropertyAll(Colors.white),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        side: const WidgetStatePropertyAll(BorderSide.none),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          Image.asset(
            'assets/images/company.png',
            width: 24,
          ),
          const SizedBox(width: 18),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
