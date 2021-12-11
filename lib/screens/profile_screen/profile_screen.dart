import 'package:flutter/material.dart';
import 'package:wallpapernest/screens/widgets/app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: const [
          SizedBox(child: CustomAppBar(title: 'Profile'),),
        ],
      ),
    );
  }
}
