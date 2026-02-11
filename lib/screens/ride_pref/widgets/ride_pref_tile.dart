import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class RidePrefTile extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final IconData leftIcon;

  //for the text placeholder for the departure and arrival
  //to show the color light or not
  //show light when not input like defualt
  final bool isPlaceHolder;

  //for the swap location when the user input both departure and arrival
  //this icon will switch the location
  final IconData? rightIcon;
  final VoidCallback? onRightIcon;

  const RidePrefTile({
    super.key,
    required this.title,
    required this.onPressed,
    required this.leftIcon,
    this.rightIcon,
    this.onRightIcon,
    this.isPlaceHolder = false, //default value is false
  });

  Color get textColor =>
      isPlaceHolder ? BlaColors.textLight : BlaColors.textNormal;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      title: Text(
        title,
        style: BlaTextStyles.button.copyWith(fontSize: 14, color: textColor),
      ),
      leading: Icon(leftIcon, size: 18, color: BlaColors.iconLight),
      trailing: rightIcon != null
          ? IconButton(
              icon: Icon(rightIcon, color: BlaColors.primary),
              onPressed: onRightIcon,
            )
          : null,
    );
  }
}
