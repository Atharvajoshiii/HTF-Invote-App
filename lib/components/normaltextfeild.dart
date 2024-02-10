import 'package:flutter/material.dart';
import 'package:invote/color/color.dart';
class LabelTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const LabelTextField({Key? key,required this.label,required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return TextField(
      controller:controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: AppColors.kPrimary),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kPrimary)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kPrimary))),
    );
  }
}
