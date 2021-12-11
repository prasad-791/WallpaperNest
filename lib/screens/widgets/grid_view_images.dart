import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/models/wallpaper_arguments.dart';
import 'package:wallpapernest/screens/wallpaper_screen/wallpaper_screen.dart';

class GridViewImages extends StatefulWidget {

  final List<Wallpaper> imageList;

  const GridViewImages({Key? key,required this.imageList}) : super(key: key);

  @override
  _GridViewImagesState createState() => _GridViewImagesState();
}

class _GridViewImagesState extends State<GridViewImages> {

  Widget buildImageCard(Wallpaper wallpaper){
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Hero(tag:wallpaper.imageURL,
          child: GestureDetector(onTap: (){
                Navigator.pushNamed(context, WallpaperScreen.routeName,arguments: WallpaperArguments(wallpaper: wallpaper));
            },child: Image.network(wallpaper.imageURL,fit: BoxFit.fill,))),
    );
  }

  Widget buildGridView(){
    return StaggeredGridView.countBuilder(
      scrollDirection: Axis.vertical,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      crossAxisCount: 2,
      itemCount: widget.imageList.length,
      itemBuilder: (BuildContext context,int index)=> buildImageCard(widget.imageList[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildGridView();
  }
}
