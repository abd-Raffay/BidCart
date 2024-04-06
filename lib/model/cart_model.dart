import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String id;
  String name;
  String image;
  int quantity;

  String size; // List of sizes

  CartModel({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    return {
      "productid": id,
      "name": name,
      "quantity": quantity,
      "imageurl": image,
      "size": size, // Serialize sizes as a list of strings
    };
  }


  static CartModel empty() => CartModel(
    id: "",
    name: "",
    image: '',
    quantity: 0,
    size: '',
  );

  // MAP Products Fetch From FIREBASE to Model

  factory CartModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return CartModel(
      id: document.id,
      name: data["name"],
      image: data["imageurl"],
      quantity: data["quantity"],
      size: data["size"] // Convert size data to list of strings
    );
  }
}
