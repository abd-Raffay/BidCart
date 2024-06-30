import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/seller_controllers/seller_request_controller.dart';
import 'package:bidcart/model/cart_model.dart';
import 'package:bidcart/model/offer_model.dart';
import 'package:bidcart/widget/Text/heading.dart';
import 'package:bidcart/widget/Text/labeltext.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BidDetails extends StatelessWidget {
  BidDetails({
    Key? key,
    required this.bid,
    //this.showStock=true
  }) : super(key: key);

  //final List<CartModel> products;
  OfferData bid;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.all(Sizes.md),
      elevation: 20,
      shadowColor: Colors.black,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(CupertinoIcons.list_bullet),
          Column(
            children: [
              const HeadingText(title: "Bid Details"),

            ],
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: Container(
        //color: Colors.grey.shade200,
        height: 300,
        width: 300,
        child: Scrollbar(
          interactive: true,
          thumbVisibility: true,
          trackVisibility: true,
          child: ListView.separated(
            itemCount: bid.items.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(color: Colors.grey.shade100);
            },
            itemBuilder: (BuildContext context, int index) {
              return  ListTile(
                tileColor: Colors.white.withOpacity(0.6),
                leading: RoundedImage(
                  imageUrl: bid.items[index].imageUrl,
                  width: 50, // Adjust the width as needed
                  height: 50, // Adjust the height as needed
                  isNetworkImage: true,
                ),
                title: HeadingText(title: bid.items[index].name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const LabelText(title: 'Qty: '),
                        Flexible(
                          child: LabelText(title: bid.items[index].quantity.toString()),
                        ),
                        SizedBox(width: 7,),

                        const LabelText(title: 'Size: '),
                        Flexible(
                          child: LabelText(title: bid.items[index].size!),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        LabelText(title: "Price : Rs ${bid.items[index].price}")

                      ],
                    )
                    /*if (showStock)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4), // Add some space between subtitles
                          LabelText(
                            title: availabilityText,
                            color: textColor,
                          ),
                        ],
                      ),*/
                  ],
                ),

              );

            },
          ),
        ),
      ),
    );
  }
}
