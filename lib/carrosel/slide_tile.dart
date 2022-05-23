import 'package:flutter/material.dart';

class SlideTile extends StatelessWidget {
  final String image;
  final bool activePage;
  SlideTile({Key? key, required this.image, required this.activePage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double top = this.activePage ? 25 : 40;
    final double blur = this.activePage ? 20 : 5;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      margin: EdgeInsets.fromLTRB(5, top, 5, 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            blurRadius: blur,
            offset: blur == 20 ? Offset(10, 10): Offset(5, 5),
          ),
        ],
        image:
            DecorationImage(fit: BoxFit.cover, image: AssetImage(this.image)),
      ),
    );
  }
}
