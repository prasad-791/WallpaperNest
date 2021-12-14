import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/models/user.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/screens/widgets/app_bar.dart';
import 'package:wallpapernest/screens/widgets/empty_placeholder.dart';
import 'package:wallpapernest/screens/widgets/grid_view_images.dart';
import 'package:wallpapernest/screens/widgets/placeholder_toast.dart';
import 'package:wallpapernest/services/database.dart';

class DownloadScreen extends StatefulWidget {
  final String? uid;
  const DownloadScreen({Key? key,required this.uid}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {

  List<Wallpaper> downloadedWallpaperList = [];

  late CustomUser _user = CustomUser(uid: widget.uid!,email: '',userName: '',likedWallpapers: [],downloadedWallpapers: []);

  void getData()async{
    if(widget.uid!=null){
      final temp = await DatabaseService(uid: widget.uid!).getUserData();
      setState(() {
        _user = CustomUser(uid: temp.uid, email: temp.email, userName: temp.userName, likedWallpapers: temp.likedWallpapers, downloadedWallpapers: temp.downloadedWallpapers);
        downloadedWallpaperList = _user.downloadedWallpapers;
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.01),
        child: Column(
          children: [
            const SizedBox(
              child: CustomAppBar(title: "Downloads",),
            ),
            downloadedWallpaperList.isEmpty?
            const EmptyPlaceHolder(name: 'Downloads'):Expanded(child: GridViewImages(imageList: downloadedWallpaperList,)),
          ],
        ),
      ),
    );
  }
}