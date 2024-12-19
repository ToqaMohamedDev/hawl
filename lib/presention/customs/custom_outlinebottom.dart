import 'package:flutter/material.dart';
import 'custom_text.dart';



class CustomOutLineWithIcon extends StatelessWidget {
  final String name;
  final IconData iconData;
  final GestureTapCallback onPressed;
  final Color color;
  final double? width;
  final Color? colorr;
  final double? height;
  const CustomOutLineWithIcon({super.key,
    required this.name,
    required this.iconData,
    required this.onPressed,
    required this.color,  this.height,this.colorr, this.width,});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        height: height,
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            backgroundColor: colorr,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide( // Add border customization here
                color:  colorr!, // Default to color if borderColor is not provided
                width: 2.0, // Set border width
              ),
            ),
          ),
          label: CustomText(name: name, fontWeight: FontWeight.bold, font: 14,color: color,),
          onPressed:onPressed,
          icon: Icon(iconData,color: color,size: 15),
        ),
      ),
    );
  }
}



