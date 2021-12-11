import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpapernest/configurations/config.dart';

void showToast(String val){
  Fluttertoast.showToast(
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.grey,
    textColor: primaryBlue,
    fontSize: 20,
    msg: val,
  );
}