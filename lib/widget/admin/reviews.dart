import 'package:flutter/material.dart';
import '../../model/review_model.dart';

void showReviewDialog(BuildContext context, Review review) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.rate_review_outlined),
            SizedBox(width: 2),
            Text("Review"),
          ],
        ),
        content: SingleChildScrollView(
          child: Container(
            color: Colors.grey[100], // Light grey color
            padding: const EdgeInsets.all(10), // Optional: Add padding for better readability
            child: ListBody(
              children: <Widget>[
                Text("${review.review}"),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
            child:Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
