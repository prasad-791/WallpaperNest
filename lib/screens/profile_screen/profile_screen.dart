import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/models/liked_screen_arguments.dart';
import 'package:wallpapernest/models/user.dart';
import 'package:wallpapernest/screens/liked_wallpaper_screen/liked_wallpaper_screen.dart';
import 'package:wallpapernest/screens/widgets/app_bar.dart';
import 'package:wallpapernest/screens/widgets/placeholder_toast.dart';
import 'package:wallpapernest/services/auth.dart';
import 'package:wallpapernest/services/database.dart';

class ProfileScreen extends StatefulWidget {

  final String? uid;
  const ProfileScreen({Key? key,required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late CustomUser _user = CustomUser(uid: widget.uid!,email: '',userName: '',likedWallpapers: [],downloadedWallpapers: []);

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
        SizedBox(width: w*0.03,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_user.userName,style: TextStyle(fontFamily: fontBold,fontSize: 22,color: primaryBlue),),
            Text(_user.email,style: TextStyle(fontSize: 12,fontFamily: fontSemiBold,color: primaryGrey),),
          ],
        ),
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

  void getData()async{
    if(widget.uid!=null){
      final temp = await DatabaseService(uid: widget.uid!).getUserData();
      setState(() {
        _user = CustomUser(uid: temp.uid, email: temp.email, userName: temp.userName, likedWallpapers: temp.likedWallpapers, downloadedWallpapers: temp.downloadedWallpapers);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
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
                    Navigator.pushNamed(context, LikedWallpaperScreen.routeName,arguments: LikedScreenArguments(list: _user.likedWallpapers));
                  }, w),
                  SizedBox(height: h*0.03,),
                  shortCuts(Icons.person, 'Account Settings', (){}, w),
                  SizedBox(height: h*0.03,),
                  shortCuts(Icons.mic_rounded, 'Language Settings', (){}, w),
                  SizedBox(height: h*0.03,),
                  shortCuts(Icons.chat, 'FAQ', (){}, w),
                  SizedBox(height: h*0.03,),
                  logOutBtn((){
                    AuthService().signOut();
                  }, w),
              ],
            ),
          )
        ],
      ),
    );
  }
}
