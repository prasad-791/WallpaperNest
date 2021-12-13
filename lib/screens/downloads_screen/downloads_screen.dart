import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/screens/widgets/app_bar.dart';
import 'package:wallpapernest/screens/widgets/empty_placeholder.dart';
import 'package:wallpapernest/screens/widgets/grid_view_images.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({Key? key}) : super(key: key);

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {

  List<Wallpaper> downloadedWallpaperList = [];

  @override
  void initState() {
    // TODO: implement initState



    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const SizedBox(
            child: CustomAppBar(title: "Downloads",),
          ),
          downloadedWallpaperList.isEmpty?
          const EmptyPlaceHolder(name: 'Downloads'):Expanded(child: GridViewImages(imageList: downloadedWallpaperList,)),
        ],
      ),
    );
  }
}