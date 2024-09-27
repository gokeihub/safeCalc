import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Offset _offset = const Offset(130, 300);

class CrushMedha extends StatefulWidget {
  const CrushMedha({super.key});

  @override
  State<CrushMedha> createState() => _CrushMedhaState();
}

class _CrushMedhaState extends State<CrushMedha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
              'https://i.postimg.cc/Z53hd6d4/bg.jpg',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: const Stack(
          alignment: Alignment.center,
          children: [
            ImageDrag(
              image: 'https://i.postimg.cc/nhSKmS6Q/1.png',
              rotate: 0.2,
            ),
           
            ImageDrag(
              image: 'https://i.postimg.cc/2S1bskKV/2.png',
              rotate: -0.5,
            ),
            ImageDrag(
              image: 'https://i.postimg.cc/63pNP3MP/3.png',
              rotate: 0,
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDrag extends StatefulWidget {
  final String image;
  final double? rotate;
  final String? message;

  const ImageDrag({
    super.key,
    required this.image,
    this.rotate,
    this.message = 'hello Tushin',
  });

  @override
  State<ImageDrag> createState() => _ImageDragState();
}

class _ImageDragState extends State<ImageDrag> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: [
          Positioned(
            left: _offset.dx,
            top: _offset.dy,
            child: Draggable(
              feedback: CachedNetworkImage(
                color: Colors.orange,
                colorBlendMode: BlendMode.colorBurn,
                height: 300,
                imageUrl: widget.image,
              ),
              child: Container(
                transform: Matrix4.rotationZ(widget.rotate!),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CachedNetworkImage(
                      height: 300,
                      width: 250,
                      imageUrl: widget.image,
                    ),
                    SizedBox(
                      width: 150,
                      height: 250,
                      child: Text(
                        widget.message!,
                        style: GoogleFonts.lato(
                          textStyle: const TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              onDragEnd: (details) {
                setState(() {
                  double adjustment = MediaQuery.of(context).size.height -
                      constraints.maxHeight;

                  _offset =
                      Offset(details.offset.dx, details.offset.dy - adjustment);
                });
              },
            ),
          )
        ],
      );
    });
  }
}
