import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onClicked,
    required this.backgroundColor,
  });

  final String text;
  final Color backgroundColor;
  final void Function()? onClicked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
      ),
      onPressed: onClicked,
      child: Text(text),
    );
  }
}
