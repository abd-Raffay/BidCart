import 'package:flutter/material.dart';


Future<int> showRadiusDialog(BuildContext context) async {
  TextEditingController distanceController = TextEditingController();
  int distance = 0;

  int? result = await showDialog<int>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Enter Distance"),
        content: TextField(
          controller: distanceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: "Enter distance in meters",
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("Submit"),
            onPressed: () {
              String radiusText = distanceController.text;
              if (radiusText.isNotEmpty) {
                int radius = int.parse(radiusText);
                Navigator.of(context).pop(radius);
              } else {
                Navigator.of(context).pop(0);
              }
            },
          ),
        ],
      );
    },
  );

  if (result != null) {
    distance = result;
  }

  return distance;
}