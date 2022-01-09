import 'package:firebase_notes/constants/custom_app_bar.dart';
import 'package:firebase_notes/src/colors.dart';
import 'package:firebase_notes/src/images.dart';
import 'package:firebase_notes/src/strings.dart';
import 'package:firebase_notes/views/login/login_page.dart';
import 'package:firebase_notes/views/register/register_page.dart';
import 'package:flutter/material.dart';

class LaunchPage extends StatelessWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DietColors.mainColor,
      appBar: CustomAppBar(DietText.mainText),
      body: _body(context),
    );
  }

  Padding _body(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: ListView(
          children: [
            _bodyImage(context),
            const SizedBox(
              height: 50,
            ),
            _bodyColumn(context),
          ],
        ));
  }

  ClipRRect _bodyImage(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        DietImages.launchImage,
        height: size.height * .5,
        fit: BoxFit.fill,
      ),
    );
  }

  Column _bodyColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _loginButton(context),
        const SizedBox(
          height: 15,
        ),
        _registerButton(context),
      ],
    );
  }

  InkWell _loginButton(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: DietColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          child: Center(
            child: Text(
              DietText.loginText,
              style: TextStyle(color: DietColors.black),
            ),
          ),
        ));
  }

  InkWell _registerButton(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const RegisterPage()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: DietColors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          child: Center(
            child: Text(
              DietText.registerText,
              style: TextStyle(color: DietColors.black),
            ),
          ),
        ));
  }
}
