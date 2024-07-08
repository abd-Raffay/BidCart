import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SellerModel {
  String userId;
  final String sellername;
  final String phone;
  final String cnic;
  final String email;
  final String storename;
  final String address;
  String status;
  final String storeId;
   Timestamp dateTime;
   final GeoPoint location;


  SellerModel({
    required this.userId,
    required this.sellername,
    required this.phone,
    required this.cnic,
    required this.email,
    required this.storename,
    required this.address,
    required this.status,
    required this.storeId,
    required this.dateTime,
    required this.location,
  });

  factory SellerModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return SellerModel(
      storeId: document.id,
      userId: data["Userid"],
      sellername: data["SellerName"],
      email: data["Email"],
      phone: data["Phone"],
      cnic: data["CNIC"],
      storename: data["StoreName"],
      address: data["Address"],
      status: data["Status"],
      dateTime: data["DateTime"],
      location: data["location"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Userid": userId,
      "SellerName": sellername,
      "Email": email,
      "CNIC": cnic,
      "Phone": phone,
      "StoreName": storename,
      "Address": address,
      "Status": status,
      "StoreId": storeId,
      "DateTime": dateTime ,
      "location":location,
    };
  }

}
