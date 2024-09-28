import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final Function()? onTap;
  final String? text;
  final Color? textColor;
  final Color? boxColor;
  const ButtonWidget({
    super.key,
    this.onTap,
    this.text,
    this.textColor = Colors.white,
    this.boxColor = const Color.fromARGB(115, 61, 57, 57),
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: size.width * 0.24,
        height: 90,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: widget.boxColor,
        ),
        child: Center(
          child: Text(
            widget.text!,
            style: TextStyle(
              color: widget.textColor,
              fontSize: 40,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
