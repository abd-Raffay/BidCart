import 'package:cloud_firestore/cloud_firestore.dart';

class Location {
  String locationid;
  String storename;
  String sellerid;
  GeoPoint location;

  Location({
    required this.locationid,
    required this.storename,
    required this.sellerid,
    required this.location,
  });

  Map<String, dynamic> toJson() {
    return {
      "locationid": locationid,
      "storename": storename,
      "sellerid": sellerid,
      "location": location,
    };
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      locationid: json["locationid"],
      storename: json["storename"],
      sellerid: json["sellerid"],
      location: json["location"],
    );
  }

  factory Location.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Location(
      locationid: document.id,
      storename: data["storename"],
      sellerid: data["sellerid"],
      location: data["location"],
    );
  }
}
