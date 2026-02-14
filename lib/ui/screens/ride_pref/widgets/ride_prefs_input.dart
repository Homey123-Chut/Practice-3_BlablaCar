import 'package:flutter/material.dart';

import '../../../theme/theme.dart';

class RidePrefInput extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final VoidCallback onPressed;
  final IconData leftIcon;
  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;
  final bool? text;


  const RidePrefInput({
    super.key,
    required this.title,
    required this.onPressed,
    required this.leftIcon,
    this.rightIcon,
    this.onRightIconPressed,
    this.text = false,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context) {
     Color textColor = text == true ? BlaColors.textLight : BlaColors.textNormal;

    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
        style: BlaTextStyles.button.copyWith(
          fontSize: 14,
          color: textColor,
        ),
      ),
      leading: Icon(
        leftIcon,
        size: BlaSize.icon,
        color: BlaColors.iconLight,
      ),

      trailing: rightIcon != null
          ? IconButton(
              icon: Icon(
                rightIcon,
                size: BlaSize.icon,
                color: BlaColors.primary,
              ),
              onPressed: onRightIconPressed ?? () {},
            )
          : null,
    );
  }
}
