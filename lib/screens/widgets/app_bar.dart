import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: height*0.03,horizontal: width*0.08),
      color: Colors.white,
      child: Text(
        title,
        style: TextStyle(
          color: primaryBlue,
          fontSize: 26,
          fontFamily: fontExtraBold,
        ),
      ),
    );
  }
}
