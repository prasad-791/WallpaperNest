import 'package:flutter/material.dart';
import 'package:wallpapernest/screens/liked_wallpaper_screen/liked_wallpaper_screen.dart';
import 'package:wallpapernest/screens/main_screen/main_screen.dart';
import 'package:wallpapernest/screens/splash_screen.dart';
import 'package:wallpapernest/screens/wallpaper_screen/wallpaper_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        MainScreen.routeName: (context)=> const MainScreen(),
        WallpaperScreen.routeName: (context)=> const WallpaperScreen(),
        LikedWallpaperScreen.routeName: (context)=> const LikedWallpaperScreen(),
      },
    );
  }
}


