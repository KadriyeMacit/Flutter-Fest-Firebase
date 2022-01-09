import 'package:firebase_notes/constants/custom_app_bar.dart';
import 'package:firebase_notes/constants/custom_loading.dart';
import 'package:firebase_notes/services/auth_service.dart';
import 'package:firebase_notes/src/colors.dart';
import 'package:firebase_notes/src/images.dart';
import 'package:firebase_notes/src/strings.dart';
import 'package:firebase_notes/views/launch/launch_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isVisible = true;
  bool _ramenValue = false;
  bool _pizzaValue = false;
  String _dropdownValue = DietText.ketchup;
  dynamic _profileImage = '';
  bool _isLoading = false;

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DietColors.mainColor,
      appBar: CustomAppBar(DietText.registerText),
      body: _body(context),
    );
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
              const SizedBox(
                height: 55,
              ),
              _registerButton(context),
            ],
          ),
        ),
        if (_isLoading) const CustomLoading(),
      ],
    );
  }

  Flexible _bodyContainer() {
    return Flexible(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
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
                  DietText.registerQuestionsauce,
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
      controller: _usernameController,
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
        value: _ramenValue,
        activeColor: DietColors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onChanged: (_) => _setRamenValue(),
      ),
    );
  }

  void _setRamenValue() {
    if (_ramenValue != true) {
      setState(() {
        _ramenValue = true;
        _pizzaValue = false;
        _profileImage = DietImages.ramen;
      });
    } else {
      setState(() {
        _ramenValue = false;
      });
    }
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
        value: _pizzaValue,
        activeColor: DietColors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onChanged: (_) => _setPizzaValue(),
      ),
    );
  }

  void _setPizzaValue() {
    if (_pizzaValue != true) {
      setState(() {
        _pizzaValue = true;
        _ramenValue = false;
        _profileImage = DietImages.pizza;
      });
    } else {
      setState(() {
        _pizzaValue = false;
      });
    }
  }

  DropdownButton _dropdownButton() {
    return DropdownButton(
        borderRadius: BorderRadius.circular(20),
        isExpanded: true,
        iconEnabledColor: DietColors.orange,
        value: _dropdownValue,
        items: [
          DropdownMenuItem(
            child: Text(DietText.ketchup),
            value: DietText.ketchup,
          ),
          DropdownMenuItem(
            child: Text(DietText.mayonnaise),
            value: DietText.mayonnaise,
          ),
          DropdownMenuItem(
            child: Text(DietText.barbecue),
            value: DietText.barbecue,
          ),
          DropdownMenuItem(
            child: Text(DietText.ranch),
            value: DietText.ranch,
          ),
          DropdownMenuItem(
            child: Text(DietText.honeyMustard),
            value: DietText.honeyMustard,
          ),
        ],
        onChanged: (value) {
          setState(() {
            _dropdownValue = value;
          });
        });
  }

  InkWell _registerButton(BuildContext context) {
    return InkWell(
        onTap: () => _registerOnTap(),
        child: Container(
          decoration: BoxDecoration(
            color: DietColors.orange,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 40,
          child: Center(
            child: Text(
              DietText.registerText,
              style: TextStyle(
                color: DietColors.white,
              ),
            ),
          ),
        ));
  }

  void _registerOnTap() {
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _profileImage.toString().isNotEmpty &&
        _dropdownValue.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      _authService
          .createPerson(
        _usernameController.text,
        _emailController.text,
        _passwordController.text,
        _profileImage ?? '',
        _dropdownValue,
      )
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LaunchPage()),
            (route) => false);
      }).catchError((error) {
        _warningToast(DietText.errorText);
      }).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      _warningToast(DietText.emptyText);
    }
  }

  Future<bool?> _warningToast(String text) {
    return Fluttertoast.showToast(
        msg: text,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: DietColors.red,
        textColor: DietColors.white,
        fontSize: 14);
  }
}
