import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;
  final Function functionValidate;
  final Function onSubmitField;
  final TextInputType type;

  const CustomTextFormField(
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.functionValidate,
    this.onSubmitField,
     this.type,

  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      // width: ,
      color: Colors.grey[100],
      child: TextFormField(
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.amber,
              width: 1.0,
            ),
          ),
          hintText: hintText,
          prefixIcon: prefixIcon,
        ),
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
