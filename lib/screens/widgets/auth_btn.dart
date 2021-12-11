import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';

class AuthButton extends StatelessWidget {
  final String value;
  final Function function;
  const AuthButton({Key? key,required this.value,required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        function();
      },
      child: Container(
        width: w,
        // margin: EdgeInsets.symmetric(vertical: h*0.03,horizontal: w*0.01),
        padding: EdgeInsets.symmetric(vertical: h*0.02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text( value ,style: const TextStyle(color: Colors.black,fontSize:16,fontFamily: fontExtraBold),)),
      ),
    );
  }
}
