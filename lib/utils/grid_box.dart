import 'package:flutter/material.dart';

class GridBox extends StatefulWidget {
  final Function()? onTap;
  final String boxName;
  final IconData boxIcon;
  const GridBox({
    super.key,
     this.onTap,
    required this.boxName,
    required this.boxIcon,
  });

  @override
  State<GridBox> createState() => _GridBoxState();
}

class _GridBoxState extends State<GridBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 140,
        width: 170,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            )),
        child: Column(
          children: [
            Icon(
              widget.boxIcon,
              size: 100,
            ),
            Container(
              height: 40,
              width: 170,
              decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Text(
                  widget.boxName,
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
