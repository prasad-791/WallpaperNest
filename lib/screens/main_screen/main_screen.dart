import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/screens/downloads_screen/downloads_screen.dart';
import 'package:wallpapernest/screens/menu_screen/menu_screen.dart';
import 'package:wallpapernest/screens/profile_screen/profile_screen.dart';

class MainScreen extends StatefulWidget {

  static const routeName = '/main_screen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  var currIndex = 0;

  Widget getScreens(int index){
    switch(index){
      case 0:
          return const MenuScreen();
      case 1:
          return const DownloadScreen();
      case 2:
          return const ProfileScreen();
      default:
          return const MenuScreen();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: getScreens(currIndex)),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            currIndex = index;
          });
        },
        selectedItemColor: primaryBlue,
        unselectedItemColor: primaryGrey,
        currentIndex: currIndex,
        items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.grid_view_rounded,size: 30,),title: Text("Menu",style: TextStyle(fontSize: 14,fontFamily: fontBold),)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.download,size: 30,),title: Text("Downloads",style: TextStyle(fontSize: 14,fontFamily: fontBold),)
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person,size: 30,),title: Text("Profile",style: TextStyle(fontSize: 14,fontFamily: fontBold),)
            ),
        ],
      ),
    );
  }
}
