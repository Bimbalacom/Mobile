import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  final String text;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      child: RichText(
        text: TextSpan(
          children: [
            WidgetSpan(child: Icon(icon, size: 20)),
            TextSpan(
                text: text,
                style: const TextStyle(color: Colors.black45, fontSize: 17)),
          ],
        ),
      ),
    );
  }
}
