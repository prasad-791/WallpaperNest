import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';

class BackBtnAppBar extends StatelessWidget {
  final Function goBack;
  const BackBtnAppBar({Key? key,required this.goBack}) : super(key: key);

  Widget backBtn() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(10),
          border: customBorder,
          boxShadow: shadowList
      ),
      child: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.black,
        size: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              goBack();
            },
            child: backBtn(),
          ),
        ],
      ),
    );
  }
}
