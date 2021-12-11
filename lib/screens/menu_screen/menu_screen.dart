import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/screens/widgets/grid_view_images.dart';
import 'package:wallpapernest/screens/widgets/placeholder_toast.dart';
import 'package:wallpapernest/services/unsplash_wallpaper.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var selectedCategoryIndex = 0;
  List<Wallpaper> wallpaperList = [];

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
          Text("Aniket791 " + "👋",style: TextStyle(
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
              setWallpaperList(e.toLowerCase());
            },
            child: category(e,wallpaperCategories.indexOf(e))
        )
    ).toList();
  }

  void setWallpaperList(String category)async{
    try {
      List<Wallpaper> tempList = await getWallpaper(category);
      setState(() {
        wallpaperList = tempList;
      });
    }catch(e){
      showToast(e.toString());
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    setWallpaperList('nature');
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
            SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: buildCategories(),
                ),
              ),
            ),
            SizedBox(height: height*0.03,),
            // buildImageCard(tempImages[1]),
            wallpaperList.isEmpty? Center(
              child: CircularProgressIndicator(
                  color: primaryBlue,
              ),
            ): Expanded(child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: GridViewImages(imageList: wallpaperList,),
            )),
          ],
        ),
    );
  }
}
