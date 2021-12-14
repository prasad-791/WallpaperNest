import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wallpapernest/models/user.dart';
import 'package:wallpapernest/models/wallpaper.dart';
import 'package:wallpapernest/screens/widgets/placeholder_toast.dart';

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(CustomUser user)async{
    return await userCollection.doc(uid).set({
      "email": user.email,
      "uid": user.uid,
      "userName": user.userName,
      "downloadedWallpapers": user.downloadedWallpapers,
      "likedWallpapers": user.likedWallpapers,
    });
  }

  Future addToLikedWallpapers(Wallpaper item)async{

    final result = await userCollection.doc(uid).update({
      "likedWallpapers": FieldValue.arrayUnion([{
        "imageURL": item.imageURL,
        "likes": item.likes,
        "photoID": item.photoID,
        "likedByUser": item.likedByUser,
        "regularImageURL": item.regularImageURL,
        "title": item.title,
        "userName": item.userName,
        "description": item.description,
        "date": item.date,
        "downloadURL": item.downloadURL,
      }]),
    }).then((value){
      showToast("Added to Liked Wallpapers!");
    },onError: (e){showToast(e.toString());});
    return result;
  }

  Future addToDownloadedWallpapers(Wallpaper item)async{
    final result = await userCollection.doc(uid).update({
      "downloadedWallpapers": FieldValue.arrayUnion([{
        "imageURL": item.imageURL,
        "likes": item.likes,
        "photoID": item.photoID,
        "likedByUser": item.likedByUser,
        "regularImageURL": item.regularImageURL,
        "title": item.title,
        "userName": item.userName,
        "description": item.description,
        "date": item.date,
        "downloadURL": item.downloadURL,
      }]),
    }).then((value){
      showToast("Added to Downloaded Wallpapers!");
    },onError: (e){showToast(e.toString());});

    return result;
  }

  Future<CustomUser> getUserData()async{
    late CustomUser user;
    // await userCollection.doc(uid).get().then((value){
    //   user = CustomUser(uid: value['uid'].toString() , email: value['email'].toString(), userName: value['userName'].toString(), likedWallpapers: value['likedWallpapers'] as List<Wallpaper>, downloadedWallpapers:  value['downloadedWallpapers'] as List<Wallpaper>);
    // },onError: (e){showToast(e.toString());});

    await userCollection.doc(uid).get().then((value){
      user = CustomUser(uid: value['uid'].toString() , email: value['email'].toString(), userName: value['userName'].toString(), likedWallpapers: [], downloadedWallpapers: []);
      List tempList = List.from(value['downloadedWallpapers']);
      List<Wallpaper> list = [];
      for(int i=0;i<tempList.length;i++){
        list.add(Wallpaper(
            imageURL: tempList[i]["imageURL"].toString(),
            likes: int.parse(tempList[i]["likes"].toString()),
            photoID: tempList[i]["photoID"].toString(),
            likedByUser: tempList[i]['likedByUser'].toString().compareTo('true')==0?true:false,
            regularImageURL: tempList[i]["regularImageURL"].toString(),
            title: tempList[i]['title'].toString(),
            userName: tempList[i]['userName'].toString(),
            description: tempList[i]['userName'].toString(),
            date: tempList[i]['date'].toString(),
            downloadURL: tempList[i]['downloadURL'].toString(),
        ));
      }
      user.downloadedWallpapers = list;


      List tempList2 = List.from(value['likedWallpapers']);
      List<Wallpaper> list2 = [];
      for(int i=0;i<tempList2.length;i++){
        list2.add(Wallpaper(
          imageURL: tempList2[i]["imageURL"].toString(),
          likes: int.parse(tempList2[i]["likes"].toString()),
          photoID: tempList2[i]["photoID"].toString(),
          likedByUser: tempList2[i]['likedByUser'].toString().compareTo('true')==0?true:false,
          regularImageURL: tempList2[i]["regularImageURL"].toString(),
          title: tempList2[i]['title'].toString(),
          userName: tempList2[i]['userName'].toString(),
          description: tempList2[i]['userName'].toString(),
          date: tempList2[i]['date'].toString(),
          downloadURL: tempList2[i]['downloadURL'].toString(),
        ));
      }
      user.likedWallpapers = list2;
      },onError: (e){showToast(e.toString());});

    return user;
  }

}