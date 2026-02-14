import 'package:flutter/material.dart';
import '../../theme/theme.dart';

class BlaButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isPrimary;
  final VoidCallback onPressed;

  const BlaButton({
    super.key,
    required this.text,
    this.icon,
    this.isPrimary = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = isPrimary ? BlaColors.primary : BlaColors.white;
    final Color textColor = isPrimary ? BlaColors.white : BlaColors.primary;
    final Color iconColor = isPrimary ? BlaColors.white : BlaColors.primary;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(BlaSpacings.radius),
          ),
          ),
          onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 20, color: iconColor),
          SizedBox(width: BlaSpacings.s),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: BlaTextStyles.button.fontSize,
              fontWeight: BlaTextStyles.button.fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
