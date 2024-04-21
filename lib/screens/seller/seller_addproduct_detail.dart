import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_cart_controller.dart';
import 'package:bidcart/controllers/seller_controllers/seller_store_controller.dart';
import 'package:bidcart/model/seller_inventory.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/app_bar/bottomBar.dart';
import 'package:bidcart/widget/app_bar/cart_counter_icon.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:bidcart/widget/seller/text_feilds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SellerProductDetail extends StatefulWidget {
  @override
  State<SellerProductDetail> createState() => _SellerProductDetailState();

  SellerProductDetail(
      {super.key,
      required this.product,
        //required this.sizes

      });


  List<String>? size;
  final Inventory product;
  //final List<String> sizes;

}

class _SellerProductDetailState extends State<SellerProductDetail> {
  @override
  Widget build(BuildContext context) {
    int quantity = 0;

    final storeController = Get.put(SellerStoreController());
    String? dropdownValue = "";
    List<String>? size=storeController.getSizes(widget.product.productid);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(widget.product.name),
        //actions: const [CartCounterIcon()],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      //- Product Image
                      RoundedImage(
                        imageUrl: widget.product.imageUrl,
                        isNetworkImage: true,
                        height: 200,
                      ),
                      const RoundedImage(
                        imageUrl: Images.split,
                        isNetworkImage: false,
                      ),
                      SizedBox(height: Sizes.spaceBtwItems*2,),
              
                      Row(
                        children: [
                          Expanded(
                            child: TextFeilds(controller: storeController.quantityController, labelText: "Stock Quantity",icon: const Icon(Icons.storage),),
                          ),
                          const SizedBox(width: Sizes.spaceBtwItems,),
                          DropdownMenu(
                            width: 170,
                            label: const Text(
                              " Select Size",
                              style: TextStyle(fontSize: Sizes.fontSizeSm),
                            ),
                            menuStyle: MenuStyle(
                              backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                              surfaceTintColor:
                              MaterialStateProperty.all(Colors.white),
                            ),
                            onSelected: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!;
                              });
              
                              storeController.size = dropdownValue!;
                             // print(widget.product.size);


                              //print(dropdownValue);
                            },
                            dropdownMenuEntries: size
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList(),
                          ),
                        ],
                      ),
                      const SizedBox(height: Sizes.spaceBtwItems,),
              
                      TextFeilds(controller: storeController.prizeController, labelText: "Price per item",icon: const Icon(Icons.money),),
                      const SizedBox(height: Sizes.spaceBtwItems,),
              
                      TextFeilds(isDatepicker: true, readOnly:true,controller: storeController.dateController, labelText: 'Date of Expiry',icon: const Icon(Icons.calendar_month),),
                      const SizedBox(height: Sizes.spaceBtwItems,),
              
                      TextFeilds(controller: storeController.batchController, labelText: 'Batch Number',icon: const Icon(Icons.batch_prediction),),
                      const SizedBox(height: Sizes.spaceBtwItems,),
              
              
                    ]),
              ),
            ),


            BottomBar(
              product: widget.product,
              buttontext: 'Add to Inventory',
              functionality: "addsellerproduct",
            ),
          ],
        ),
      ),
    );
  }
}



