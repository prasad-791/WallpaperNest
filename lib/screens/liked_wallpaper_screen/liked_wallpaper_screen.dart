import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/models/liked_screen_arguments.dart';
import 'package:wallpapernest/models/user.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/screens/widgets/back_btn_appbar.dart';
import 'package:wallpapernest/screens/widgets/empty_placeholder.dart';
import 'package:wallpapernest/screens/widgets/grid_view_images.dart';
import 'package:wallpapernest/screens/widgets/placeholder_toast.dart';
import 'package:wallpapernest/services/database.dart';

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

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    final user = Provider.of<CustomUser?>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*0.03),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: w*0.03,),
                    child: BackBtnAppBar(goBack: (){
                      Navigator.pop(context);
                    }),
                  ),
                  SizedBox(width: w*0.05,),
                  const Text(
                    "Liked Wallpapers",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontFamily: fontExtraBold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h*0.05,),
              likedWallpaperList.isEmpty?
              const EmptyPlaceHolder(name: 'here'):Expanded(child: GridViewImages(imageList: likedWallpaperList, isFromMenuScreen: false,
              delete: (item)async{
                await DatabaseService(uid: user!.uid).removeFromLikedWallpapers(item);
                setState(() {
                  showToast("Deleted");
                });
              },)),
            ],
          ),
        ),
      ),
    );
  }
}
