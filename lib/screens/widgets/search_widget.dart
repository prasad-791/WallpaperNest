import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';

class SearchBar extends StatefulWidget {

  final Function search;
  final ValueChanged<bool> makeCategoryInvisible;
  final ValueChanged<String>? onSaved;
  const SearchBar({Key? key,required this.search,required this.onSaved,required this.makeCategoryInvisible}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  late TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState

    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(left: width*0.035,right: width*0.035,top: height*0.025),
      child: CupertinoSearchTextField(
        controller: _controller,
        padding: EdgeInsets.symmetric(horizontal: width*0.03,vertical: height*0.02),
        decoration: BoxDecoration(
          border: customBorder,
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: shadowList,
        ),
        placeholder: 'e.g Football',
        placeholderStyle: const TextStyle(
          fontFamily: fontSemiBold,
          color: Colors.grey,
        ),
        style: const TextStyle(
          fontFamily: fontSemiBold,
          color: Colors.black,
        ),
        itemSize: 20,
        prefixIcon: GestureDetector(onTap: (){
          FocusScope.of(context).unfocus();
          widget.search();
        },child: Icon(Icons.search,color: primaryBlue,size: 20,)),
        suffixIcon: Icon(Icons.close,color: primaryBlue,size: 20,),
        suffixInsets: const EdgeInsets.only(right: 10),
        prefixInsets: const EdgeInsets.only(left: 10),
        onSuffixTap: (){
          _controller.clear();
          FocusScope.of(context).unfocus();
          widget.makeCategoryInvisible(false);
        },
        onTap: (){
          widget.makeCategoryInvisible(true);
        },
        onSubmitted: (value){
          widget.onSaved!(value);
          widget.search();
        },
        onChanged: (value){
          widget.onSaved!(value);
        },
      ),
    );

  }
}