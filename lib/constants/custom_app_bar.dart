import 'package:firebase_notes/src/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar(
    String title, {
    Key? key,
  }) : super(
          key: key,
          backgroundColor: DietColors.orange,
          title: Text(
            title,
          ),
          elevation: 0.0,
        );
}
