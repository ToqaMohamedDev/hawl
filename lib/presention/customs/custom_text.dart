import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String name;
  final GestureTapCallback? onPressed;
  final AlignmentGeometry? alignmentGeometry;
  final FontWeight fontWeight;
  final double font;
  final double? height;
  final String? fontFa;
  final double? width;
  final Color? color;
  final int? maxLines;
  final TextAlign? textAlign;
  CustomText(
      {Key? key,
        required this.name,
        this.onPressed,
        this.alignmentGeometry,
        required this.fontWeight,
        this.height,
        this.width,
        required this.font,
        this.fontFa,
        this.color,
        this.maxLines,
        this.textAlign,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        alignment: alignmentGeometry,
        child: Text(
          name,
          maxLines: maxLines??1,
          textAlign:textAlign?? TextAlign.right,
          textDirection: TextDirection.rtl,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              decoration:name=="All Widget"?
              TextDecoration.underline:null,
              color: color,
              fontFamily:fontFa?? "Cairo",
              fontSize: font,
              fontWeight: fontWeight
          ),
        ),
      ),
    );
  }
}




