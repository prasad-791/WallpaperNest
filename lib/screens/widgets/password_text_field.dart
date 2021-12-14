import 'package:flutter/material.dart';
import 'package:wallpapernest/configurations/config.dart';

// ignore: must_be_immutable
class PasswordTextField extends StatefulWidget {
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final String? hint;
  final TextInputType inputType;
  bool obscure;
  final ValueChanged<String>? onSaved;

  PasswordTextField({Key? key,required this.suffixIcon, required this.prefixIcon, required this.hint,required this.inputType, required this.obscure, required this.onSaved}) : super(key: key);
  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {

  void _toggle(){
    setState((){
      widget.obscure = !widget.obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: widget.inputType,
        obscureText: widget.obscure,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)
          ),
          prefixIcon: Icon(widget.prefixIcon,color: Colors.black,size: 20,),
          suffixIcon: GestureDetector(
            onTap: _toggle,
            child: Icon(
              widget.obscure ? widget.suffixIcon : Icons.visibility_off,
              color: Colors.black,
              size: 20,
            ),
          ),
          hintText: widget.hint,
          hintStyle: const TextStyle(
              decoration: TextDecoration.none,
              fontFamily: fontSemiBold,
              fontSize: 16,
              color: Colors.grey
          ),
        ),
        onChanged: (value)=> widget.onSaved!(value),
        onFieldSubmitted: (value)=> widget.onSaved!(value),
        validator: (value){
          if(value!.isEmpty) return "Empty Field Not Allowed";
          return null;
        },
      ),
    );
  }
}
