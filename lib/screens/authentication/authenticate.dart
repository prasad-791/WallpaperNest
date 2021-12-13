import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';
import 'package:wallpapernest/screens/main_screen/main_screen.dart';
import 'package:wallpapernest/screens/widgets/auth_btn.dart';
import 'package:wallpapernest/screens/widgets/password_text_field.dart';
import 'package:wallpapernest/screens/widgets/text_field.dart';

class AuthenticateScreen extends StatefulWidget {
  const AuthenticateScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticateScreen> createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {

  double dxIntro = 0;
  double dxRegister = 500;
  double dxLogin = 500;
  bool checkedValue = false;

  Widget exploreTextField(){
    return Column(
      children: const [
        Align(
          alignment: Alignment.topLeft,
          child: Text('Explore',style: TextStyle(
          fontFamily: fontExtraBold,
          fontSize: 24,
          color: Colors.white,
          ),),
        ),
        Text('Explore beautiful wallpapers and set them in your devices.',
          style: TextStyle(
          fontFamily: fontSemiBold,
          fontSize: 14,
          color: Colors.white,
        ),),
      ],
    );
  }

  Widget toggleContainer(String val1, String val2,Function toggle){
    return Row(
        children: [
          const Spacer(),
          Text(val1, style: const TextStyle(fontFamily: fontSemiBold,fontSize: 14,color: Colors.white),),
          GestureDetector(onTap: (){
              toggle();
          },child: Text(val2, style: const TextStyle(fontFamily: fontBold,fontSize: 14,color: Colors.white,decoration: TextDecoration.underline),)),
          const Spacer(),
        ],
      );
  }

  Widget buildIntroContainer(var h,var w){
      return Align(
        alignment: Alignment.bottomLeft,
        child: AnimatedContainer(
          transform: Matrix4.translationValues(dxIntro, 0, 0),
          margin: EdgeInsets.symmetric(vertical: h*0.03,horizontal: w*0.08),
          duration: const Duration(milliseconds: 500),
          child: Column(
            children: [
              SizedBox(height: h*0.1,),
              exploreTextField(),
              SizedBox(height: h*0.03,),
              AuthButton(value: 'Sign Up with Email',function: (){
                  setState(() {
                    dxIntro = -500;
                    dxRegister = 0;
                  });
                },
              ),
              SizedBox(height: h*0.03,),
              toggleContainer("Already have an Account? ", "Login Now",(){
                setState(() {
                  dxIntro = -500;
                  dxLogin = 0;
                });
              }),
              SizedBox(height: h*0.03,),
            ],
          ),
        ),
      );
  }

  Widget buildRegisterContainer(var h,var w){
    return Align(
      alignment: Alignment.bottomLeft,
      child: AnimatedContainer(
        transform: Matrix4.translationValues(dxRegister, 0, 0),
        margin: EdgeInsets.symmetric(vertical: h*0.03,horizontal: w*0.08),
        duration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            SizedBox(height: h*0.01,),
            exploreTextField(),
            SizedBox(height: h*0.03,),
            TextLabelField(prefixIcon: Icons.email, hint: 'Email', inputType: TextInputType.emailAddress, obscure: false, onSaved: (email){

            }),
            SizedBox(height: h*0.01,),
            TextLabelField(prefixIcon: Icons.person, hint: 'Username', inputType: TextInputType.text, obscure: false, onSaved: (username){

            }),
            SizedBox(height: h*0.01,),
            PasswordTextField(suffixIcon: Icons.visibility, prefixIcon: Icons.lock, hint: 'Password', inputType: TextInputType.text, obscure: true, onSaved: (password){

            }),
            SizedBox(height: h*0.01,),
            PasswordTextField(suffixIcon: Icons.visibility, prefixIcon: Icons.lock, hint: 'Re-type Password', inputType: TextInputType.text, obscure: true, onSaved: (reTypePassword){

            }),
            SizedBox(height: h*0.01,),
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white60),
              child: CheckboxListTile(
                tileColor: Colors.white,
                selectedTileColor: Colors.white,
                checkColor: Colors.white,
                contentPadding: EdgeInsets.zero,
                title: Transform.translate(offset: const Offset(-15, 0),child: const Text("Remember Me",style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: fontSemiBold),),),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
              ),
            ),
            SizedBox(height: h*0.03,),
            AuthButton(value: 'Sign Up',function: (){
                Navigator.pushNamed(context, MainScreen.routeName);
              },
            ),
            SizedBox(height: h*0.03,),
            toggleContainer("Already have an Account? ", "Login Now",(){
              setState(() {
                dxRegister = -500;
                dxLogin = 0;
              });
            }),
            SizedBox(height: h*0.03,),
          ],
        ),
      ),
    );
  }

  Widget buildLogInContainer(var h,var w){
    return Align(
      alignment: Alignment.bottomLeft,
      child: AnimatedContainer(
        transform: Matrix4.translationValues(dxLogin, 0, 0),
        margin: EdgeInsets.symmetric(vertical: h*0.03,horizontal: w*0.08),
        duration: const Duration(milliseconds: 500),
        child: Column(
          children: [
            SizedBox(height: h*0.01,),
            exploreTextField(),
            SizedBox(height: h*0.03,),
            TextLabelField(prefixIcon: Icons.email, hint: 'Email', inputType: TextInputType.emailAddress, obscure: false, onSaved: (email){

            }),
            SizedBox(height: h*0.01,),
            PasswordTextField(suffixIcon: Icons.visibility, prefixIcon: Icons.lock, hint: 'Password', inputType: TextInputType.text, obscure: true, onSaved: (password){

            }),
            SizedBox(height: h*0.02,),
            const Align(
              alignment: Alignment.centerRight,
              child: Text('Forgot Password?',
                style: TextStyle(
                  fontFamily: fontSemiBold,
                  fontSize: 14,
                  color: Colors.white,
                ),),
            ),
            SizedBox(height: h*0.03,),
            AuthButton(value: 'Sign In',function: (){
              Navigator.pushNamed(context, MainScreen.routeName);
              },
            ),
            SizedBox(height: h*0.03,),
            toggleContainer("Don't have an Account? ", "Create Now",(){
              setState(() {
                dxLogin = 500;
                dxRegister = 0;
              });
            }),
            SizedBox(height: h*0.03,),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
        children: [
          Container(
            height: height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
              ),
            )
          ),
          Column(
            children: [
              SizedBox(height: height*0.1,),
              const Align(alignment: Alignment.topCenter,child: Text('Wallpaper Nest',style: TextStyle(fontSize:36,fontFamily: fontSansitaBold,color: Colors.white),)),
              SizedBox(height: height*0.02,),
              const Align(alignment: Alignment.topCenter,child: Text('Beautiful Photos',style: TextStyle(fontSize:16,fontFamily: fontBold,color: Colors.white),)),
              Container(
                color: Colors.transparent,
                child: Stack(
                  children: [
                    buildIntroContainer(height, width),
                    buildRegisterContainer(height, width),
                    buildLogInContainer(height, width),
                  ],
                ),
              )
            ],
          ),
        ],
    ));
  }
}
