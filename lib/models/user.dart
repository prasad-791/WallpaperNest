import 'package:wallpapernest/models/wallpaper.dart';

class CustomUser{
  final String uid;
  final String email;
  final String userName;
  late List<Wallpaper> likedWallpapers = [];
  late List<Wallpaper> downloadedWallpapers = [];

  CustomUser({required this.uid,required this.email, required this.userName, required this.likedWallpapers,
      required this.downloadedWallpapers});
}