import 'package:flutter/material.dart';
import 'package:wallpapernest/models/liked_screen_arguments.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/screens/widgets/app_bar.dart';
import 'package:wallpapernest/screens/widgets/back_btn_appbar.dart';
import 'package:wallpapernest/screens/widgets/empty_placeholder.dart';
import 'package:wallpapernest/screens/widgets/grid_view_images.dart';

class LikedWallpaperScreen extends StatefulWidget {

  static const routeName = '/liked_wallpaper_screen';

  const LikedWallpaperScreen({Key? key}) : super(key: key);

  @override
  _LikedWallpaperScreenState createState() => _LikedWallpaperScreenState();
}

class _LikedWallpaperScreenState extends State<LikedWallpaperScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    final args = ModalRoute.of(context)!.settings.arguments as LikedScreenArguments;
    List<Wallpaper> likedWallpaperList = args.list;


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: w*0.03,),
              child: BackBtnAppBar(goBack: (){
                Navigator.pop(context);
              }),
            ),

            const CustomAppBar(title: "Liked Wallpapers",),
            likedWallpaperList.isEmpty?
            const EmptyPlaceHolder(name: 'here'):Expanded(child: GridViewImages(imageList: likedWallpaperList,)),
          ],
        ),
      ),
    );
  }
}
