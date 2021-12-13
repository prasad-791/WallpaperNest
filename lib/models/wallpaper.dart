class Wallpaper{
  final String imageURL;
  final int likes;
  final String photoID;
  final bool likedByUser;
  final String regularImageURL;
  final String title;
  final String userName;
  final String description;
  final String date;
  final String downloadURL;

  Wallpaper({required this.photoID, required this.likes,required this.imageURL, required this.likedByUser,required this.regularImageURL,required this.title, required this.description, required this.date, required this.downloadURL,required this.userName});

  factory Wallpaper.fromJson(Map<String,dynamic> json,String category){
    String temp = json['created_at'].toString();
    return Wallpaper(
        photoID: json['id'].toString(),
        likes: int.parse(json['likes'].toString()),
        likedByUser: json['liked_by_user'].toString().compareTo('true')==0?true:false,
        regularImageURL: json['urls']['regular'].toString(),
        imageURL: json['urls']['thumb'].toString(),
        title: category,
        description: json['alt_description'].toString(),
        date: temp.substring(0,10),
        userName: json['user']['name'].toString(),
        downloadURL: json['links']['download'],
    );
  }
}