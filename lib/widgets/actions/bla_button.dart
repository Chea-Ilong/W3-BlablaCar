import 'package:flutter/material.dart';
import '../../theme/theme.dart';


enum ButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final ButtonType type;
  final String title;
  final IconData? icon;
  final VoidCallback? onPressed;

  const BlaButton({
    super.key,
    this.type = ButtonType.primary,
    this.icon,
    required this.title,
    this.onPressed,
  }); 
  
  //checking the buttontype 
  bool get isPrimary => type == ButtonType.primary;

  Color get backgroundColor =>
      isPrimary ? BlaColors.backGroundColor : BlaColors.white;

  //border only for the secondary button (optional for the primary button) 
  BorderSide? get borderSide =>
      isPrimary ? null : BorderSide(color: BlaColors.disabled, width: 2);

  Color get textColor => isPrimary ? BlaColors.white : BlaColors.primary;

  Color get iconColor => isPrimary ? BlaColors.white : BlaColors.primary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        side: borderSide,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BlaSpacings.radius),
        ),
        padding: EdgeInsets.symmetric(
          vertical: BlaSpacings.m,
          horizontal: BlaSpacings.m,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: BlaSpacings.s,
        children: [
          if (icon != null) Icon(icon, size: 18, color: iconColor),
          Text(title, style: BlaTextStyles.button.copyWith(color: textColor)),
        ],
      ),
    );
  }
}
