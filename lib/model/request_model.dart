import 'package:bidcart/model/cart_model.dart';

class RequestData {
  String customerId;
  List<CartModel> items;
  String customerName;
  String dateTime;

  RequestData({
    required this.customerId,
    required this.items,
    required this.customerName,
    required this.dateTime

  });

  Map<String, dynamic> toJson() {
    return {
      "customerid": customerId,
      "customerName":customerName,
      "dateTime":dateTime,
      "items": items.map((item) => item.toJson()).toList(),
    };
  }

  factory RequestData.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemsData = json['items'];
    List<CartModel> items = itemsData.map((item) => CartModel.fromJson(item)).toList();

    return RequestData(
      customerId: json["customerid"],
      items: items,
      customerName: json["customerName"],
      dateTime: json["dateTime"],
    );
  }
}