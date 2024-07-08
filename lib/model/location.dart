import 'package:cloud_firestore/cloud_firestore.dart';

class Locations {
  String locationid;
  String storename;
  String sellerid;
  GeoPoint location;

  Locations({
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

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      locationid: json["locationid"],
      storename: json["storename"],
      sellerid: json["sellerid"],
      location: json["location"],
    );
  }

  factory Locations.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Locations(
      locationid: document.id,
      storename: data["storename"],
      sellerid: data["sellerid"],
      location: data["location"],
    );
  }
}
