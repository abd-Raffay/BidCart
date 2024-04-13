import 'package:bidcart/const/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellerRequestCards extends StatelessWidget {
  const SellerRequestCards({super.key, required this.userName, required this.date});

  final String userName;
  final String date;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: MediaQuery.of(context).size.width,
      foregroundDecoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
               Row(
                children: [
                  const Icon(Icons.person),
                  SizedBox(width: 5,),
                  Text(userName),
                ],
              ),

               Row(
                children: [
                  const Icon(Icons.date_range_outlined),
                  SizedBox(width: 5,),
                  Text(date),
                ],
              ),

              const Row(children: [
                Icon(CupertinoIcons.cart),
                SizedBox(width: 5,),
                Text("Product Available: 3/4"),
              ]),
            ],
          ),
          Positioned(
            top: 6,
            right: 2,
            bottom: 6,
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      textStyle:
                      const TextStyle(fontSize: Sizes.fontSizeSm),
                      backgroundColor: Colors.green[600]),
                  child: const Text("Accept"),
                ),
                const SizedBox(width: 8), // Add spacing between buttons
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      textStyle:
                      const TextStyle(fontSize: Sizes.fontSizeSm),
                      backgroundColor: Colors.red[600]),
                  child: const Text("Reject"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
