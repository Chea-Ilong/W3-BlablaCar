import 'package:blabla/widgets/actions/bla_button.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlaButton(title: "test primary", onPressed: () {}),
        BlaButton(
          type: ButtonType.secondary,
          title: "test secondary",
          onPressed: () {},
        ),
        BlaButton(
          icon: Icons.access_alarm,
          title: "test primary with icon",
          onPressed: () {},
        ),
        BlaButton(
          type: ButtonType.secondary,
          icon: Icons.access_alarm,
          title: "test secondary with icon",
          onPressed: () {},
        ),
      ],
    );
  }
}
