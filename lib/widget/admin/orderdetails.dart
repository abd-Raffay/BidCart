import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/widget/admin/item_card.dart';
import 'package:bidcart/widget/cart/cart_item.dart';
import 'package:flutter/material.dart';


void showOrderDialog(BuildContext context, OfferData offer) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            Icon(Icons.shopping_cart),
            SizedBox(width: 8),
            Text("Order"),
          ],
        ),

        content: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*0.5,// Adjust width as needed
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: offer.items.length,
                  itemBuilder: (context, index) {
                    Inventory item = offer.items[index];
                    return ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ItemCard(item: item,),
                        ],
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(10)),
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Close"),

          ),
        ],
      );
    },
  );
}
