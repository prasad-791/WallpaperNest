import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpapernest/models/user.dart';
import 'package:wallpapernest/screens/authentication/authenticate.dart';
import 'package:wallpapernest/screens/main_screen/main_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);

    return user==null? const AuthenticateScreen(): MainScreen(uid: user.uid,);
  }
}
