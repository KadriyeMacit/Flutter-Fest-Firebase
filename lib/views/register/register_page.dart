import 'package:firebase_notes/constants/custom_app_bar.dart';
import 'package:firebase_notes/src/colors.dart';
import 'package:firebase_notes/src/images.dart';
import 'package:firebase_notes/src/strings.dart';
import 'package:firebase_notes/views/launch/launch_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordControllerAgain = TextEditingController();

  //göz için
  bool isVisible = true;

//cinsiyet için
  bool woman = false;
  bool man = false;

  //dropdown için
  final int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DietColors.mainColor,
      appBar: CustomAppBar(DietText.registerText),
      body: _body(context),
    );
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
          _registerButton(context),
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
                _usernameTextField(),
                const SizedBox(
                  height: 20,
                ),
                _emailTextField(),
                const SizedBox(
                  height: 20,
                ),
                _passwordTextField(),
                const SizedBox(
                  height: 20,
                ),
                _foodText(),
                const SizedBox(
                  height: 10,
                ),
                _foodsRow(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  DietText.registerQuestionSos,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                _dropdownButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField _usernameTextField() {
    return TextField(
      controller: nameController,
      cursorColor: DietColors.black,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.person,
          color: DietColors.orange,
        ),
        hintText: DietText.username,
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

  Text _foodText() {
    return Text(
      DietText.registerQuestionFood,
      style: const TextStyle(fontSize: 15),
    );
  }

  Row _foodsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _foodRowFirst(),
        _foodRowLast(),
      ],
    );
  }

  Expanded _foodRowFirst() {
    return Expanded(
      child: Row(
        children: [
          _foodFirstCheckBox(),
          _foodImage(DietImages.ramen),
        ],
      ),
    );
  }

  Transform _foodFirstCheckBox() {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        side: BorderSide(color: DietColors.mainColor),
        value: woman,
        activeColor: DietColors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onChanged: (_) {},
      ),
    );
  }

  ClipRRect _foodImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.asset(
        image,
        height: 70,
      ),
    );
  }

  Expanded _foodRowLast() {
    return Expanded(
      child: Row(
        children: [
          _foodLastCheckbox(),
          _foodImage(DietImages.pizza),
        ],
      ),
    );
  }

  Transform _foodLastCheckbox() {
    return Transform.scale(
      scale: 1.3,
      child: Checkbox(
        side: BorderSide(color: DietColors.mainColor),
        value: woman,
        activeColor: DietColors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onChanged: (_) {},
      ),
    );
  }

  DropdownButton _dropdownButton() {
    return DropdownButton(
        borderRadius: BorderRadius.circular(20),
        isExpanded: true,
        iconEnabledColor: DietColors.orange,
        value: _value,
        items: const [
          DropdownMenuItem(
            child: Text("Ketçap"),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text("Mayonez"),
            value: 2,
          ),
          DropdownMenuItem(
            child: Text("Barbekü"),
            value: 3,
          ),
          DropdownMenuItem(
            child: Text("Sarımsaklı Sos"),
            value: 4,
          ),
          DropdownMenuItem(
            child: Text("Ballı Hardal"),
            value: 5,
          ),
        ],
        onChanged: (value) {
          setState(() {
            // _value = value;
          });
        });
  }

  InkWell _registerButton(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LaunchPage()));
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
