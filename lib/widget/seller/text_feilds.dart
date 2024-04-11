import 'package:bidcart/controllers/seller_controllers/seller_store_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TextFeilds extends StatelessWidget {
  const TextFeilds({
    super.key,

    this.isDatepicker=false,
    required this.controller,
    required this.labelText,
    this.readOnly=false, this.icon,
  });

  final bool isDatepicker;

  final TextEditingController? controller;
  final String labelText;
  final bool readOnly;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    final storeController=Get.put(SellerStoreController());
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration:  InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey[200],
          prefixIcon: icon,
          enabledBorder:
          OutlineInputBorder(borderSide: BorderSide.none,),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.cyan))),
      readOnly: readOnly,
      onTap: () {
        if (isDatepicker==true) {
          storeController.selectDate(context);
        }
      },
    );
  }
}
