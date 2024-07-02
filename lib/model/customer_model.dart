import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerModel {
  String id;
  final String name;
  final String email;
  final String phone;
  final String address;// for saving address
  final GeoPoint location; // for saving latitudes and longitudes

  CustomerModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.address,
  });

  setid(String id) {
    this.id = id;
  }

  toJson() {
    return {
      "Userid": id,
      "Name": name,
      "Email": email,
      "Phone": phone,
      "location": location,
      "address": address,
    };
  }

  //MAP user Fetch  From FIREBASE to Model

  factory CustomerModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return CustomerModel(
      id: data["Userid"],
      name: data["Name"],
      email: data["Email"],
      phone: data["Phone"],
      location: data["location"],
      address: data["address"],
    );
  }
}
