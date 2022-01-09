import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notes/services/model/food_model.dart';
import 'package:firebase_notes/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class FoodService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageService _storageService = StorageService();
  String _mediaUrl = '';

  Future<Food> addFood(String food, XFile pickedFile) async {
    var ref = _firestore.collection("Food");

    _mediaUrl = await _storageService.uploadMedia(File(pickedFile.path));

    var documentRef = await ref.add({'food': food, 'image': _mediaUrl});

    return Food(id: documentRef.id, food: food, image: _mediaUrl);
  }

  Stream<QuerySnapshot> getFood() {
    var ref = _firestore.collection("Food").snapshots();

    return ref;
  }

  Future<void> removeFood(String docId) {
    var ref = _firestore.collection("Food").doc(docId).delete();

    return ref;
  }
}
