import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';

class EmptyPlaceHolder extends StatelessWidget {

  final String name;

  const EmptyPlaceHolder({Key? key,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w*0.1),
        child: Column(
          children: [
            SizedBox(
              width: w,
              height: h*0.35,
              child: Image.asset('assets/images/empty_placeholder.png'),
            ),
            SizedBox(height: h*0.03,),
            Text("Nothing to show in $name. \nCheck out Menu for Wallpapers :)",style: TextStyle(fontFamily: fontSemiBold,color: primaryBlue,fontSize: 14),textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}
