import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/screens/liked_wallpaper_screen/liked_wallpaper_screen.dart';
import 'package:wallpapernest/screens/widgets/app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  Widget profileHeader(var h,var w){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: w*0.05),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor: primaryGrey,
                child: Icon(Icons.person,color: primaryBlue,size: 45,),
              ),
              Positioned(
                  bottom: 1,
                  right: 1,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: primaryBlue,
                    child: const Icon(Icons.add,color: Colors.white,size: 20,),
                  ),
              )
            ],
          ),
        ),
        Text('Aniket791',style: TextStyle(fontFamily: fontBold,fontSize: 22,color: primaryBlue),),
        SizedBox(width: w*0.1,),
        Container(
            padding: EdgeInsets.all(w*0.015),
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Icon(Icons.edit_rounded,color: Colors.white,size: 20,)
        ),
        SizedBox(width: w*0.02,),
      ],
    );
  }

  Widget shortCuts(IconData iconData,String value,Function goTo,double w){
    return GestureDetector(
      onTap: (){
        goTo();
      },
      child: Row(
        children: [
          Icon(iconData,color: primaryBlue,size: 25,),
          SizedBox(width: w*0.03,),
          Text(value,style: TextStyle(color: primaryBlue,fontFamily: fontBold,fontSize: 18),),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,size: 20,),
        ],
      ),
    );
  }

  Widget logOutBtn(Function logOut,double w){
    return GestureDetector(
      onTap: (){
        logOut();
      },
      child: Row(
        children: [
          const Icon(Icons.logout_rounded,color: Colors.red,size: 20,),
          SizedBox(width: w*0.045,),
          const Text("Logout",style:TextStyle(color: Colors.red,fontFamily: fontSemiBold,fontSize: 20))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(child: CustomAppBar(title: 'Profile'),),
          profileHeader(h, w),
          SizedBox(height: h*0.05,),
          Container(
            margin: EdgeInsets.only(left: w*0.08),
            child: const Text("Settings",style: TextStyle(fontSize: 18,fontFamily: fontExtraBold,color: Colors.black),),
          ),
          Container(
            margin: EdgeInsets.only(left: w*0.08,top: h*0.03,right: w*0.07),
            child: Column(
              children: [
                  shortCuts(Icons.favorite, 'Liked Wallpaper', (){
                    Navigator.pushNamed(context, LikedWallpaperScreen.routeName);
                  }, w),
                  SizedBox(height: h*0.03,),
                  shortCuts(Icons.person, 'Account Settings', (){}, w),
                  SizedBox(height: h*0.03,),
                  shortCuts(Icons.mic_rounded, 'Language Settings', (){}, w),
                  SizedBox(height: h*0.03,),
                  shortCuts(Icons.chat, 'FAQ', (){}, w),
                  SizedBox(height: h*0.03,),
                  logOutBtn((){}, w),
              ],
            ),
          )
        ],
      ),
    );
  }
}
