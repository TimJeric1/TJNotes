


import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType keyboardType;
  final bool isObscureText;
  const AuthField({super.key, required this.textEditingController, required this.hintText, this.isObscureText = false, this.keyboardType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      validator: (inputtedText){
        if(inputtedText!.isEmpty) return "$hintText is missing";
        return null;
      },
      obscureText: isObscureText,
      keyboardType: keyboardType,
    );
  }
}
