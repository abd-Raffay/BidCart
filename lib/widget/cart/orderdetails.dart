import 'package:flutter/material.dart';
import 'package:bidcart/widget/Text/heading.dart';
import 'package:bidcart/widget/Text/labeltext.dart';

class OrderDetailCard extends StatelessWidget {
  const OrderDetailCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Fixed height for the card
      child: Card(
        elevation: 4, // Adding elevation for a raised effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Adding rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(20), // Adjusting padding
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side text
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeadingText(title: "Order ID"),
                  SizedBox(height: 10),
                  LabelText(title: "12345678"),
                  SizedBox(height: 10),
                  LabelText(title: "Total Products"),
                ],
              ),
              // Right side button
              ElevatedButton(
                onPressed: () {
                  // Add your onPressed logic here
                },
                child: const Text('Your Button'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
