import 'package:flutter/material.dart';
import 'package:bidcart/model/seller_inventory.dart'; // Adjust according to your inventory model
import 'package:bidcart/widget/container/round_image.dart'; // Adjust paths as needed
import 'package:bidcart/widget/products/product_text/product_label_text.dart'; // Adjust paths as needed
import 'package:bidcart/widget/products/product_text/product_title_text.dart'; // Adjust paths as needed
import 'package:bidcart/const/sizes.dart'; // Adjust paths as needed

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.item,
    this.imageWidth = 80,
    this.imageHeight = 80,
    this.imagePadding = EdgeInsets.zero,
  }) : super(key: key);

  final Inventory item;
  final double imageWidth;
  final double imageHeight;
  final EdgeInsetsGeometry imagePadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          RoundedImage(
            imageUrl: item.imageUrl,
            width: imageWidth,
            height: imageHeight,
            padding: imagePadding,
            isNetworkImage: true,
          ),

          // Details Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 4,),
                      TitleText(title: item.name),
                      SizedBox(width: 4,),
                      ProductLabelText(title: item.size ?? ''),
                    ],
                  ),

                  // Additional Details
                  Row(
                    children: [
                      // Expiry Date
                      Icon(Icons.calendar_month, size: Sizes.iconSm),
                      ProductLabelText(title: item.dateofexpiry ?? ''), // Adjust for expiry date field
                      // Batch Number
                    ],
                  ),
                      Row(
                        children: [
                          Icon(Icons.confirmation_number, size: Sizes.iconSm),
                          ProductLabelText(title: item.batch ?? ''),
                        ],
                      ), // Adjust for batch number field


                  // Price and Quantity
                  Row(
                    children: [
                      // Price
                      Icon(Icons.money, size: Sizes.iconSm),
                      ProductLabelText(title: "${item.price.toString()}Rs"), // Adjust for price field
                      // Quantity
                      SizedBox(width: 4,),
                      Icon(Icons.inventory, size: Sizes.iconSm),
                      ProductLabelText(title: item.quantity.toString()), // Adjust for quantity field
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
