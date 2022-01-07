import 'package:firebase_notes/constants/custom_app_bar.dart';
import 'package:firebase_notes/src/colors.dart';
import 'package:firebase_notes/src/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DietColors.mainColor,
        appBar: CustomAppBar(DietText.loginText),
        body: _body(context));
  }

  Padding _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _bodyContainer(),
          const SizedBox(
            height: 55,
          ),
          _loginButton(context),
        ],
      ),
    );
  }

  Flexible _bodyContainer() {
    return Flexible(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _emailTextField(),
                const SizedBox(
                  height: 20,
                ),
                _passwordTextField(),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                _googleButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField _emailTextField() {
    return TextField(
      controller: emailController,
      cursorColor: DietColors.black,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.mail,
          color: DietColors.orange,
        ),
        hintText: DietText.email,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DietColors.mainColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DietColors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  TextField _passwordTextField() {
    return TextField(
      controller: passwordController,
      obscureText: isVisible ? true : false,
      cursorColor: DietColors.black,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            if (isVisible) {
              setState(() {
                isVisible = false;
              });
            } else {
              setState(() {
                isVisible = false;
              });
              isVisible = true;
            }
          },
          child: isVisible
              ? Icon(
                  Icons.remove_red_eye,
                  color: DietColors.orange,
                )
              : Icon(
                  Icons.remove_red_eye_outlined,
                  color: DietColors.orange,
                ),
        ),
        prefixIcon: Icon(
          Icons.vpn_key,
          color: DietColors.orange,
        ),
        hintText: DietText.password,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DietColors.mainColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: DietColors.orange),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  InkWell _loginButton(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => const LaunchPage()));
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

  InkWell _googleButton() {
    return InkWell(
      onTap: () {
        // _authService.signInWithGoogle().then((value) {
        //   return Navigator.push(
        //       context, MaterialPageRoute(builder: (context) => HomePage()));
        //  });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: DietColors.red, width: 2),
            color: DietColors.red,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FaIcon(
                FontAwesomeIcons.google,
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                DietText.googleLogin,
                style: TextStyle(color: DietColors.white),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
