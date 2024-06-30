import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bidcart/model/seller_inventory.dart';

class OfferData {
  String sellerId;
  List<Inventory> items;
  String sellerName;
  String dateTime;
  String orderId;
  String status;
  int totalPrice;


  OfferData({
    required this.sellerId,
    required this.items,
    required this.sellerName,
    required this.dateTime,
    required this.status,
    required this.orderId,
    required this.totalPrice,

  });

  Map<String, dynamic> toJson() {
    return {
      "sellerid": sellerId,
      "sellerName":sellerName,
      "status": status,
      "dateTime": dateTime,
      "orderId": orderId,
      "totalPrice":totalPrice,
      "items": items.map((item) => item.toJson()).toList(),
    };
  }
  factory OfferData.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    try {
      final data = document.data()!;

      // Print all fields in the document for debugging
      // Extract items data
      List<dynamic>? itemsData = data['items'] as List<dynamic>?;

      List<Inventory> items = itemsData?.map((item) => Inventory.fromJson(item)).toList() ?? [];

      return OfferData(
        orderId: data["orderId"] ?? '',
        sellerId: data["sellerid"] ?? '',
        items: items,
        sellerName: data["sellerName"] ?? '',
        dateTime: data["dateTime"] ?? '',
        status: data["status"] ?? 'pending',
          totalPrice:data["totalPrice"] ?? 0,

      );
    } catch (e) {
      print('Error converting document to OfferData: $e');
      // Print more detailed information about the document to identify the problematic field
      print('Fields in document:');
      document.data()?.forEach((key, value) {
        print('$key: $value');
      });
      throw e; // Rethrow the error for further analysis if needed
    }
  }





  factory OfferData.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemsData = json['items'] as List<dynamic>? ?? [];
    List<Inventory> items = itemsData.map((item) => Inventory.fromJson(item)).toList();

    return OfferData(
      orderId: json['orderId'] ?? '',
      sellerId: json['sellerid'] ?? '',
      items: items,
      sellerName: json['sellerName'] ?? '',
      dateTime: json['dateTime'] ?? '',
      status: json['status'] ?? '',
        totalPrice: json['totalPrice'] ?? 0,

    );
  }
}
