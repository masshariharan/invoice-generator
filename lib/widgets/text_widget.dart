import 'package:flutter/material.dart';
import 'package:invoice_generator/utils/style.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: headingBoldTextStyle,
    );
  }
}

class SubHeadingText extends StatelessWidget {
  const SubHeadingText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: subHeadingBoldTextStyle);
  }
}

class AppText extends StatelessWidget {
  const AppText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle);
  }
}

class ButtonText extends StatelessWidget {
  const ButtonText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: buttonTextStyle);
  }
}
