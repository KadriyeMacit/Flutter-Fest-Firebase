import 'package:firebase_notes/constants/custom_app_bar.dart';
import 'package:firebase_notes/constants/custom_loading.dart';
import 'package:firebase_notes/services/auth_service.dart';
import 'package:firebase_notes/src/colors.dart';
import 'package:firebase_notes/src/strings.dart';
import 'package:firebase_notes/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isVisible = true;
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: DietColors.mainColor,
        appBar: CustomAppBar(DietText.loginText),
        body: _body(context));
  }

  Stack _body(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bodyContainer(),
              _loginButton(context),
            ],
          ),
        ),
        if (_isLoading) const CustomLoading()
      ],
    );
  }

  Flexible _bodyContainer() {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          color: DietColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
      controller: _emailController,
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
      controller: _passwordController,
      obscureText: _isVisible ? true : false,
      cursorColor: DietColors.black,
      decoration: InputDecoration(
        suffixIcon: InkWell(
          onTap: () {
            if (_isVisible) {
              setState(() {
                _isVisible = false;
              });
            } else {
              setState(() {
                _isVisible = false;
              });
              _isVisible = true;
            }
          },
          child: _isVisible
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
        onTap: () => _loginWithEmail(),
        child: Container(
          decoration: BoxDecoration(
            color: DietColors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          child: Center(
            child: Text(
              DietText.loginText,
              style: TextStyle(
                color: DietColors.white,
              ),
            ),
          ),
        ));
  }

  void _loginWithEmail() {
    setState(() {
      _isLoading = true;
    });

    _authService
        .signInWithEmail(
      _emailController.text,
      _passwordController.text,
    )
        .then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
      setState(() {
        _isLoading = false;
      });
    });
  }

  InkWell _googleButton() {
    return InkWell(
      onTap: () => _loginWithGoogle(),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: DietColors.red, width: 2),
            color: DietColors.red,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: _googleButtonBody(),
        ),
      ),
    );
  }

  Center _googleButtonBody() {
    return Center(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          FontAwesomeIcons.google,
          color: DietColors.white,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          DietText.googleLogin,
          style: TextStyle(color: DietColors.white),
        ),
      ],
    ));
  }

  void _loginWithGoogle() {
    _authService.signInWithGoogle().then((value) {
      return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    });
  }
}
