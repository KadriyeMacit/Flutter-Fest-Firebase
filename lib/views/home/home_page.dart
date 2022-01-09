import 'package:firebase_notes/constants/custom_app_bar.dart';
import 'package:firebase_notes/services/auth_service.dart';
import 'package:firebase_notes/services/food_service.dart';
import 'package:firebase_notes/src/colors.dart';
import 'package:firebase_notes/src/images.dart';
import 'package:firebase_notes/src/strings.dart';
import 'package:firebase_notes/views/add_food/add_food_page.dart';
import 'package:firebase_notes/views/home/food_list_page.dart';
import 'package:firebase_notes/views/launch/launch_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  final FoodService _foodService = FoodService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DietColors.mainColor,
      appBar: CustomAppBar(DietText.homeText),
      drawer: _drawer(),
      body: const FoodListPage(),
      floatingActionButton: _floatingActionButton(),
    );
  }

  Drawer _drawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _userAccountsDrawer(),
          _drawerHome(),
          _drawerProfile(),
          const Divider(),
          _drawerLogout(),
        ],
      ),
    );
  }

  UserAccountsDrawerHeader _userAccountsDrawer() {
    return UserAccountsDrawerHeader(
      accountName: const Text("Hello World"),
      accountEmail: const Text("helloworld@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage(DietImages.pizza),
      ),
      decoration: BoxDecoration(color: DietColors.orange),
    );
  }

  ListTile _drawerHome() {
    return ListTile(
      title: Text(DietText.homeText),
      leading: Icon(
        Icons.home,
        color: DietColors.orange,
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  ListTile _drawerProfile() {
    return ListTile(
      title: Text(DietText.profileText),
      onTap: () {
        Navigator.pop(context);
      },
      leading: Icon(
        Icons.person,
        color: DietColors.orange,
      ),
    );
  }

  ListTile _drawerLogout() {
    return ListTile(
      title: Text(DietText.logoutText),
      onTap: () {
        _authService.signOut();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LaunchPage()),
            (route) => false);
      },
      leading: Icon(
        Icons.remove_circle,
        color: DietColors.orange,
      ),
    );
  }

  FloatingActionButton _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: DietColors.orange,
      elevation: 0.0,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AddFoodPage(),
          ),
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
