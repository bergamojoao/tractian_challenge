import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final Widget? icon;
  final Widget label;
  final bool isSelected;
  final void Function()? onPressed;

  const FilterButton({
    super.key,
    this.icon,
    required this.label,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        shape: WidgetStateProperty.resolveWith(
          (_) {
            if (isSelected) {
              return RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(3),
              );
            }

            return RoundedRectangleBorder(
              side: const BorderSide(
                color: Color(0xFFD8DFE6),
              ),
              borderRadius: BorderRadius.circular(3),
            );
          },
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (_) {
            if (isSelected) {
              return Colors.blue;
            }

            return Colors.transparent;
          },
        ),
        iconColor: WidgetStateProperty.resolveWith(
          (_) {
            if (isSelected) {
              return Colors.white;
            }

            return const Color(0xFF77818C);
          },
        ),
        foregroundColor: WidgetStateProperty.resolveWith(
          (_) {
            if (isSelected) {
              return Colors.white;
            }

            return const Color(0xFF77818C);
          },
        ),
      ),
      onPressed: onPressed,
      icon: icon,
      label: label,
    );
  }
}
