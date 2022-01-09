import 'dart:io';
import 'package:firebase_notes/constants/custom_app_bar.dart';
import 'package:firebase_notes/constants/custom_loading.dart';
import 'package:firebase_notes/services/food_service.dart';
import 'package:firebase_notes/src/colors.dart';
import 'package:firebase_notes/src/images.dart';
import 'package:firebase_notes/src/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key? key}) : super(key: key);

  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final TextEditingController _foodController = TextEditingController();
  final FoodService _foodService = FoodService();

  final ImagePicker _pickerImage = ImagePicker();
  dynamic _pickImage;
  dynamic _foodImage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DietColors.mainColor,
      appBar: CustomAppBar(DietText.addFoodText),
      body: _body(),
    );
  }

  Stack _body() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              _mainBody(),
              _saveButton(context),
            ],
          ),
        ),
        if (_isLoading) const CustomLoading(),
      ],
    );
  }

  Flexible _mainBody() {
    return Flexible(
      child: ListView(
        children: [
          _bodyTitle(),
          const SizedBox(
            height: 20,
          ),
          _bodyImage(),
          const SizedBox(
            height: 30,
          ),
          _bodyContainer(),
        ],
      ),
    );
  }

  Widget _bodyTitle() {
    return Container(
      decoration: BoxDecoration(
        color: DietColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          DietText.addSomeFoodsTitle,
        ),
      ),
    );
  }

  Container _bodyContainer() {
    return Container(
      decoration: BoxDecoration(
        color: DietColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _foodTextField(),
      ),
    );
  }

  TextField _foodTextField() {
    return TextField(
        cursorColor: DietColors.orange,
        controller: _foodController,
        maxLines: 7,
        decoration: InputDecoration(
          hintText: DietText.addSomeFoodsText,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: DietColors.white,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: DietColors.white,
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: DietColors.white,
            ),
          ),
        ));
  }

  Column _bodyImage() {
    return Column(
      children: [
        Center(
          child: _imagePlace(),
        ),
        const SizedBox(
          height: 10,
        ),
        _imageRow(),
      ],
    );
  }

  Row _imageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _cameraContainer(),
        const SizedBox(
          width: 10,
        ),
        _galeryContainer(),
      ],
    );
  }

  Container _cameraContainer() {
    return Container(
      decoration: BoxDecoration(
        color: DietColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IconButton(
        icon: Icon(
          Icons.camera_alt,
          color: DietColors.orange,
        ),
        onPressed: () => _onImageButtonPressed(
          ImageSource.camera,
          context: context,
        ),
      ),
    );
  }

  Container _galeryContainer() {
    return Container(
      decoration: BoxDecoration(
        color: DietColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: IconButton(
        icon: Icon(
          Icons.image,
          color: DietColors.orange,
        ),
        onPressed: () => _onImageButtonPressed(
          ImageSource.gallery,
          context: context,
        ),
      ),
    );
  }

  Container _imagePlace() {
    if (_foodImage != null) {
      return _fileImage();
    } else {
      if (_pickImage != null) {
        return _networkImage();
      } else {
        return _circleImage();
      }
    }
  }

  Container _fileImage() {
    return Container(
      decoration: BoxDecoration(
        color: DietColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            File(_foodImage!.path),
          ),
        ),
      ),
    );
  }

  Container _networkImage() {
    return Container(
      decoration: BoxDecoration(
        color: DietColors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(_pickImage)),
      ),
    );
  }

  Container _circleImage() {
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: DietColors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CircleAvatar(
          backgroundImage: AssetImage(DietImages.popcorn),
          radius: height * 0.08,
        ),
      ),
    );
  }

  Padding _saveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
          onTap: () => _saveButtonOnTap(),
          child: Container(
            decoration: BoxDecoration(
              color: DietColors.orange,
              borderRadius: BorderRadius.circular(10),
            ),
            height: 40,
            child: Center(
              child: Text(
                DietText.addText,
                style: TextStyle(
                  color: DietColors.white,
                ),
              ),
            ),
          )),
    );
  }

  void _saveButtonOnTap() {
    if (_foodController.text.isNotEmpty && _foodImage != null) {
      setState(() {
        _isLoading = true;
      });
      _foodService
          .addFood(_foodController.text, _foodImage ?? '')
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      });
    } else {
      _emptyMessage();
    }
  }

  Future<bool?> _emptyMessage() {
    return Fluttertoast.showToast(
        msg: DietText.emptyText,
        timeInSecForIosWeb: 2,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: DietColors.red,
        textColor: DietColors.white,
        fontSize: 14);
  }

  void _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
  }) async {
    try {
      final pickedFile = await _pickerImage.pickImage(source: source);
      setState(() {
        _foodImage = pickedFile!;
      });
    } catch (e) {
      setState(() {
        _pickImage = e;
      });
    }
  }
}
