import 'package:bidcart/model/offer_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Review {
  String customerId;
  OfferData offer;
  String reviewDateTime;
  String review;
  String customerName;
  String? reviewId;

  Review({
    required this.customerId,
    required this.offer,
    required this.reviewDateTime,
    required this.review,
    required this.customerName,
    this.reviewId,
  });

  Map<String, dynamic> toJson() {
    return {
      "customerId": customerId,
      "reviewDateTime": reviewDateTime,
      "offer": offer.toJson(),
      "review": review,
      "customerName": customerName,
    };
  }

  factory Review.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    try {
      final data = document.data()!;

      return Review(
        reviewId: document.id,
        customerId: data["customerId"] ?? '',
        offer: OfferData.fromJson(data["offer"]),
        reviewDateTime: data["reviewDateTime"] ?? '',
        review: data["review"] ?? '',
        customerName: data["customerName"] ?? '',
      );
    } catch (e) {
      print('Error converting document to Review: $e');
      // Print more detailed information about the document to identify the problematic field
      print('Fields in document:');
      document.data()?.forEach((key, value) {
        print('$key: $value');
      });
      throw e; // Rethrow the error for further analysis if needed
    }
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      customerId: json['customerId'] ?? '',
      offer: OfferData.fromJson(json['offer']),
      reviewDateTime: json['reviewDateTime'] ?? '',
      review: json["review"] ?? '',
      customerName: json["customerName"] ?? '',
    );
  }
}
