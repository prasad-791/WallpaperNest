import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/screens/widgets/placeholder_toast.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

const String _url = "https://api.unsplash.com/search/photos?client_id="+accessKey;

// Get Wallpapers by Category
Future<List<Wallpaper>> getWallpaper(String category) async {
  Random random = Random();
  int page = random.nextInt(900);
  final response = await http.get(
    Uri.parse(_url+"&query="+category+"&page=${page+1}&per_page=50"),
    headers: <String,String>{
      'Content-Type': 'application/json',
    },
  );

  if(response.statusCode == 200){
      Map<String,dynamic> json = jsonDecode(response.body);

      List<Wallpaper> wallpaperList=[];

      List resultList = json['results'];
      for(int i=0;i<resultList.length;i++){
          wallpaperList.add(Wallpaper.fromJson(resultList[i], category));
      }
      return wallpaperList;

  }else{
    throw Exception("Could not get wallpaper list, try again later!");
  }
}

// Download Wallpaper
Future<void> download(String url) async{
  try{

    final response = await http.get(Uri.parse(url));

    final imageName = path.basename(url)+".png";

    final appDir = await path_provider.getExternalStorageDirectory();

    final localPath = path.join(appDir!.path.toString(),imageName);

    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);

    showToast("Downloaded!");
  }catch(e){
    showToast(e.toString());
  }
}

// Set Wallpaper
Future<void> setAsWallPaper(String url)async{
  try{

    await download(url);

    final int location = WallpaperManagerFlutter.HOME_SCREEN;

    File cachedImage = await DefaultCacheManager().getSingleFile(url);
    WallpaperManagerFlutter().setwallpaperfromFile(cachedImage, location);

    showToast('Wallpaper set successfully');
  }on PlatformException catch(e){
    showToast(e.toString());
  }catch(e){
    showToast(e.toString());
  }
}