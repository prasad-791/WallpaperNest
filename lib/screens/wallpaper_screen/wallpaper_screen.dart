import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/models/wallpaper_arguments.dart';
import 'package:wallpapernest/screens/widgets/back_btn_appbar.dart';
import 'package:wallpapernest/screens/widgets/placeholder_toast.dart';
import 'package:wallpapernest/services/unsplash_wallpaper.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({Key? key}) : super(key: key);

  static const routeName = '/wallpaper_screen';

  @override
  _WallpaperScreenState createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {

  late Wallpaper wallpaper;
  bool fullVisible = false;
  String filePath = '';
  bool inProcess = false;
  bool isLiked = false;

  Widget moreBtn(var h,var w){
    return GestureDetector(
      onTap: (){
        setState(() {
          fullVisible = !fullVisible;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: h*0.015,horizontal: w*0.1),
        decoration: BoxDecoration(
          boxShadow: shadowList,
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Text('More',style: TextStyle(fontSize: 18,fontFamily: fontExtraBold,color: primaryBlue),),
      ),
    );
  }
  
  Widget downloadApplyBtn(var h,var w,Color bg,Color color,String val,double hPadding){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: hPadding,vertical: h*0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: primaryBlue),
          color: bg,
        ),
        child: Text(val,style: TextStyle(color: color,fontSize: 16,fontFamily: fontBold),),
    );
  }

  // Future<void> likeToggle(){
  //   try{
  //
  //   }catch(e){
  //     showToast(e.toString());
  //   }
  // }

  Widget infoContainer(Wallpaper wallpaper,var h,var w){
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
        margin: EdgeInsets.symmetric(horizontal: w*0.05,vertical: h*0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Text(wallpaper.title[0].toUpperCase()+wallpaper.title.substring(1),style: TextStyle(fontFamily: fontExtraBold,fontSize: 24,color: primaryBlue),),
              SizedBox(height: h*0.02,),
              Text(wallpaper.description[0].toUpperCase()+wallpaper.description.substring(1),style: TextStyle(fontFamily: fontSemiBold,fontSize: 18,color: Colors.grey[500]),softWrap: true,),
              SizedBox(height: h*0.02,),
              Text(wallpaper.userName,style: TextStyle(fontFamily: fontSemiBold,fontSize: 16,color: primaryBlue)),
              Text(wallpaper.date,style: TextStyle(fontFamily: fontSemiBold,fontSize: 14,color: primaryGrey,fontStyle: FontStyle.italic)),
              SizedBox(height: h*0.02,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: ()async{
                    if(!inProcess){
                      setState(() {
                        inProcess = true;
                      });
                      await download(wallpaper.downloadURL);
                      setState(() {
                        inProcess = false;
                      });
                    }
                  },child: downloadApplyBtn(h, w, Colors.white, primaryBlue, 'Download',w*0.1)),
                  GestureDetector(onTap: ()async{
                    if(!inProcess){
                      setState(() {
                        inProcess = true;
                      });
                      await setAsWallPaper(wallpaper.downloadURL);
                      setState(() {
                        inProcess = false;
                      });
                    }
                  },child: downloadApplyBtn(h, w, primaryBlue,Colors.white, 'Apply',w*0.15)),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: -h*0.035,
          right: w*0.1,
          child: Column(
            children: [
              FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: (){
                  setState(() {
                    inProcess = true;
                  });
                  setState(() {
                    isLiked = !isLiked;
                    inProcess = false;
                  });
                },
                child: Icon(
                  Icons.favorite,
                  color: isLiked==true? Colors.red : primaryGrey,
                ),
              ),
              SizedBox(height: h*0.01,),
              Text('${wallpaper.likes} likes',style: TextStyle(fontSize: 12,fontFamily: fontSemiBold,color: primaryGrey),),
            ],
          ),
        ),
      ]
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    final args = ModalRoute.of(context)!.settings.arguments as WallpaperArguments;
     wallpaper =args.wallpaper;

    return WillPopScope(
      onWillPop: ()async{
        if(!inProcess){
          return true;
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: fullVisible==true?h*0.7:h,
                        width: w,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
                          child: Hero(
                            tag: wallpaper.imageURL,
                            child: Image.network(wallpaper.regularImageURL,fit: BoxFit.fill,)
                        ),),
                      ),
                      Visibility(visible: fullVisible,child: infoContainer(wallpaper, h, w)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: w*0.03,),
                      child: BackBtnAppBar(goBack: (){
                        if(!inProcess){
                          Navigator.pop(context);
                        }
                      }),
                    ),
                    const Spacer(),
                    Visibility(visible: !fullVisible,child: moreBtn(h,w)),
                    SizedBox(height: h*0.1,),
                  ],
                ),
                Visibility(
                  visible: inProcess,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white,),
                  ),
                ),
                // Visibility(
                //   visible: fullVisible,
                //   child: Positioned(
                //     child: FloatingActionButton(
                //       backgroundColor: Colors.white,
                //       onPressed: (){
                //         setState(() {
                //           inProcess = true;
                //         });
                //         setState(() {
                //           isLiked = !isLiked;
                //           inProcess = false;
                //         });
                //       },
                //       child: Icon(
                //         Icons.favorite,
                //         color: isLiked==true? Colors.red : primaryGrey,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
        ),
      ),
    );
  }
}
