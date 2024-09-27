import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Function()? onTap;
  final String? text;
  final Color? textColor;
  final Color? boxColor;
  const Button({
    super.key,
    this.onTap,
    this.text,
    this.textColor = Colors.white,
    this.boxColor = const Color.fromARGB(115, 61, 57, 57),
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
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
