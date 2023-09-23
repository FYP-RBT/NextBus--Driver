import 'package:flutter/material.dart';

import '../colors.dart';

class DataAddTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final Widget prefixIcon;

  const DataAddTextField(
      {Key? key,
      this.controller,
      required this.hintText,
      required this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.textFieldBorder),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(10)),
            fillColor: AppColor.textFieldFill,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
    ;
  }
}
