import 'package:blabla/model/ride/locations.dart';
import 'package:flutter/material.dart';
import '../../../theme/theme.dart';

class LocationTile extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;

  const LocationTile({super.key, required this.location, required this.onTap});

  String get title => location.name;

  String get subTitle => location.country.name;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),
      subtitle: Text(
        subTitle,
        style: BlaTextStyles.label.copyWith(color: BlaColors.textLight),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: BlaColors.iconLight,
        size: 18,
      ),
    );
  }
}
