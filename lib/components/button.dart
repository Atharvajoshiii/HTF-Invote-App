import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback ontap;
  final String text;
  const MyButton({super.key,required this.ontap,required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(text),
          ),
        ),
    );

  }
}
