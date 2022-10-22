import 'package:flutter/cupertino.dart';

class bookCover extends StatelessWidget {
  final String coverUrl;
  bookCover(this.coverUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 20, bottom: 20),
      height: 270,
      width: 180,
      child: ClipRect(
          child: Image.network(
        coverUrl,
        width: 100,
        height: 180,
        fit: BoxFit.fill,
      )),
    );
  }
}
