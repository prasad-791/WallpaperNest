import 'package:flutter/material.dart';
import 'package:wallpapernest/screens/authentication/authenticate.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return const AuthenticateScreen();
  }
}
