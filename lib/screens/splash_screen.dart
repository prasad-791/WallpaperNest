import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wallpapernest/screens/wrapper.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
          ),
        ),
        child: AnimatedSplashScreen(
          splash: Column(
            children: const [
              Center(child: Text('Wallpaper Nest',style: TextStyle(fontSize:30,fontFamily: fontSansitaBold,color: Colors.white),)),
              SizedBox(height: 10,),
              Center(child: Text('Beautiful Photos',style: TextStyle(fontSize:16,fontFamily: fontBold,color: Colors.white),))
            ],
          ),
          nextScreen: const Wrapper(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
          backgroundColor: Colors.transparent,
          duration: 1500,
        ),
      ),
    );
  }
}
