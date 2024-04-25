
import 'package:bidcart/model/cart_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RequestData {
  String customerId;
  List<CartModel> items;
  String customerName;
  String dateTime;
  String? orderId;


  RequestData({
    required this.customerId,
    required this.items,
    required this.customerName,
    required this.dateTime,
    this.orderId


  });

  Map<String, dynamic> toJson() {
    return {
      "customerid": customerId,
      "customerName":customerName,
      "dateTime":dateTime,
      "orderId":orderId,
      "items": items.map((item) => item.toJson()).toList(),
    };
  }

  factory RequestData.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    final String documentId = document.id;

    List<dynamic> itemsData = data['items'];
    List<CartModel> items = itemsData.map((item) => CartModel.fromJson(item)).toList();

    return RequestData(
      orderId: documentId, // Using the provided documentId as orderId
      customerId: data["customerid"],
      items: items,
      customerName: data["customerName"],
      dateTime: data["dateTime"],
    );
  }

}