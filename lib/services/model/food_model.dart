import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String id;
  String food;
  String image;

  Food({required this.id, required this.food, required this.image});

  factory Food.fromSnapshot(DocumentSnapshot snapshot) {
    return Food(
      id: snapshot.id,
      food: snapshot["food"],
      image: snapshot["image"],
    );
  }
}
