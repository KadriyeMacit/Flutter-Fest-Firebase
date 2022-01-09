import 'package:firebase_notes/src/colors.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: DietColors.orange,
      ),
    );
  }
}
