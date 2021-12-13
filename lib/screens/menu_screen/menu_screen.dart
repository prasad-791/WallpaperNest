import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/screens/widgets/grid_view_images.dart';
import 'package:wallpapernest/screens/widgets/placeholder_toast.dart';
import 'package:wallpapernest/screens/widgets/search_widget.dart';
import 'package:wallpapernest/services/unsplash_wallpaper.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var selectedCategoryIndex = 0;
  List<Wallpaper> wallpaperList = [];
  var searchText = '';
  bool isSearching = false;
  bool noResults = false;

  Widget buildWelcomeHeader(var h,var w){
    return Container(
      margin: EdgeInsets.only(top: h*0.03,right: w*0.05,left: w*0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hello',style: TextStyle(
              fontFamily: fontSemiBold,
              fontSize: 14,
              color: primaryBlue,
              overflow: TextOverflow.ellipsis
          ),),
          SizedBox(height: h*0.005,),
          Text("Aniket791 👋",style: TextStyle(
            fontFamily: fontBold,
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
            color: primaryBlue,
          ),),
        ],
      ),
    );
  }

  Widget category(String val,int index){
    return Container(
      margin: const EdgeInsets.only(top: 20,left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        color: selectedCategoryIndex == index ? primaryBlue : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        val,
        style: TextStyle(
          color: selectedCategoryIndex == index ? Colors.white : primaryGrey,
          fontFamily: fontBold,
          fontSize: 16,
        ),
      ),
    );
  }

  List<Widget> buildCategories(){
    return wallpaperCategories.map((e) =>
        GestureDetector(
            onTap: ()async{
              setState(() {
                wallpaperList.clear();
                selectedCategoryIndex = wallpaperCategories.indexOf(e);
              });
              setWallpaperList(e.toLowerCase(),-1);
            },
            child: category(e,wallpaperCategories.indexOf(e))
        )
    ).toList();
  }

  void setWallpaperList(String category,int type)async{
    try {
      Random random = Random();
      int page;
      List<Wallpaper> tempList = [];
      if(category.compareTo('3d')==0 || category.compareTo('game')==0 && type==-1){
        page = random.nextInt(95);
      }else if(type==-1){
        page = random.nextInt(900);
      }else{
        page = 1;
      }

      tempList = await getWallpaper(category, page);

      setState(() {
        wallpaperList = tempList;
        if(wallpaperList.isEmpty){
          noResults = true;
        }else{
          noResults = false;
        }
      });
    }catch(e){
      showToast(e.toString());
    }
  }

  Widget getBody(){
    if(wallpaperList.isEmpty && !noResults){
      return Center(
        child: CircularProgressIndicator(
          color: primaryBlue,
        ),
      );
    }else if(noResults){
      return Center(
        child: Text("No Results Found :(\n Click on category again",textAlign: TextAlign.center,style: TextStyle(fontFamily: fontBold,fontSize: 18,color: primaryGrey),softWrap: true,),
      );
    }else{
      return Expanded(child: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: GridViewImages(imageList: wallpaperList,),
      ));
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    setWallpaperList('nature',-1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(child: buildWelcomeHeader(height, width)),
            SizedBox(child: SearchBar(
              makeCategoryInvisible: (visible){
                setState(() {
                  isSearching = visible;
                });
                setWallpaperList('nature',-1);
              },
              onSaved: (text){
                setState(() {
                  searchText = text.toString();
                });
              },
              search: ()async{
                setState(() {
                  wallpaperList.clear();
                });
                setWallpaperList(searchText,1);
                showToast(wallpaperList.length.toString());
              },
            ),),
            Visibility(
              visible: !isSearching,
              child: SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: buildCategories(),
                  ),
                ),
              ),
            ),
            SizedBox(height: height*0.03,),
            getBody(),
          ],
        ),
    );
  }
}
