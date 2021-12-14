import 'package:flutter/material.dart';
import 'package:wallpapernest/models/user.dart';
import 'package:wallpapernest/screens/liked_wallpaper_screen/liked_wallpaper_screen.dart';
import 'package:wallpapernest/screens/main_screen/main_screen.dart';
import 'package:wallpapernest/screens/splash_screen.dart';
import 'package:wallpapernest/screens/wallpaper_screen/wallpaper_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:wallpapernest/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
      initialData: null,
      value: AuthService().getUser,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          WallpaperScreen.routeName: (context)=> const WallpaperScreen(),
          LikedWallpaperScreen.routeName: (context)=> const LikedWallpaperScreen(),
        },
      ),
    );
  }
}


