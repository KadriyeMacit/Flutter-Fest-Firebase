import 'package:firebase_notes/constants/custom_loading.dart';
import 'package:firebase_notes/services/food_service.dart';
import 'package:firebase_notes/src/colors.dart';
import 'package:firebase_notes/src/strings.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoodListPage extends StatefulWidget {
  const FoodListPage({Key? key}) : super(key: key);

  @override
  _FoodListPageState createState() => _FoodListPageState();
}

class _FoodListPageState extends State<FoodListPage> {
  final FoodService _foodService = FoodService();

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  StreamBuilder _body() {
    return StreamBuilder<QuerySnapshot>(
      stream: _foodService.getFood(),
      builder: (context, snaphot) {
        return !snaphot.hasData
            ? const CustomLoading()
            : snaphot.data != null
                ? _mainBody(snaphot)
                : const CustomLoading();
      },
    );
  }

  ListView _mainBody(AsyncSnapshot<QuerySnapshot<Object?>> snaphot) {
    return ListView.builder(
        itemCount: snaphot.data?.docs.length ?? 0,
        itemBuilder: (context, index) {
          DocumentSnapshot mypost = snaphot.data!.docs[index];

          Future<void> _showChoiseDialog(BuildContext context) {
            return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return _alertDialog(mypost);
                });
          }

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                _showChoiseDialog(context);
              },
              child: _dietListContainer(mypost),
            ),
          );
        });
  }

  Container _dietListContainer(DocumentSnapshot mypost) {
    return Container(
      decoration: BoxDecoration(
        color: DietColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: _dietListColumn(mypost),
    );
  }

  Padding _dietListColumn(DocumentSnapshot mypost) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DietText.dietList,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "${mypost['food']}",
          ),
          const SizedBox(
            height: 10,
          ),
          _dietListImage(mypost),
        ],
      ),
    );
  }

  Container _dietListImage(DocumentSnapshot mypost) {
    return Container(
      decoration: BoxDecoration(
        color: DietColors.white,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(mypost['image']),
        ),
      ),
    );
  }

  AlertDialog _alertDialog(DocumentSnapshot mypost) {
    return AlertDialog(
      title: Text(
        DietText.alertDialogTitle,
        textAlign: TextAlign.center,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      content: _alertDialogContent(mypost),
    );
  }

  Row _alertDialogContent(DocumentSnapshot mypost) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _removeButton(mypost),
        _giveUpButton(),
      ],
    );
  }

  InkWell _removeButton(DocumentSnapshot mypost) {
    return InkWell(
      onTap: () {
        _foodService.removeFood(mypost.id);
        Navigator.pop(context);
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: DietColors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            DietText.removeText,
            style: TextStyle(color: DietColors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  InkWell _giveUpButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: DietColors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            DietText.giveUpText,
            style: TextStyle(color: DietColors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
