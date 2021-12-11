import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/models/wallpaper.dart';

const String _url = "https://api.unsplash.com/search/photos?client_id="+accessKey;

Future<List<Wallpaper>> getWallpaper(String category) async {
  final response = await http.get(
    Uri.parse(_url+"&query="+category+"&page=1&per_page=50"),
    headers: <String,String>{
      'Content-Type': 'application/json',
    },
  );

  if(response.statusCode == 200){
      Map<String,dynamic> json = jsonDecode(response.body);

      List<Wallpaper> wallpaperList=[];

      var resultList = json['results'];
      for(int i=0;i<30;i++){
          wallpaperList.add(Wallpaper.fromJson(resultList[i], category));
      }
      return wallpaperList;

  }else{
    throw Exception("Could not get wallpaper list, try again later!");
  }
}