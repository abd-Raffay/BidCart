import 'package:bidcart/const/images.dart';
import 'package:bidcart/controllers/seller_controllers/seller_signup_controller.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/screens/seller/seller_login.dart';
import 'package:bidcart/screens/seller/seller_maps_screen.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../const/sizes.dart';
import '../../repository/seller_repository/seller_login_repository.dart';

class SSignup extends StatefulWidget {
  const SSignup({super.key});

  @override
  State<SSignup> createState() => _SSignupState();
}

class _SSignupState extends State<SSignup> {
  final controller = Get.put(SellerSignUpController());
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  final sellerrepo = Get.put(SellerLoginRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.defaultSpace / 2),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        child: Image.asset(Images.logo),
                      ),
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Ready to start selling with us?",
                          style: TextStyle(
                            fontSize: Sizes.fontSizeLg,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          " Create your seller account today and tap into a world of "
                          "opportunities to showcase your products and grow your business!",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      //Sellername Field
                      TextFormField(
                        controller: controller.sellername,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: 'Full Name',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2.0, color: Colors.cyan)),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      //Phone Number
                      TextFormField(
                        controller: controller.phone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11), // Adjust maximum length as needed
                        ],
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0, color: Colors.cyan)
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (value.length < 9 || value.length > 11) {
                            return 'Phone number must be between 9 to 11 digits long';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10.0),
                      //CNIC
                      TextFormField(
                        controller: controller.cnic,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.card_membership),
                          labelText: 'CNIC',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0, color: Colors.cyan)
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          bool isValidCNIC(String cnic) {
                            RegExp check = RegExp(r'^[0-9]{5}-[0-9]{7}-[0-9]{1}$');
                            return check.hasMatch(cnic);
                          }

                          if (value == null || value.isEmpty) {
                            return 'Please enter your CNIC';
                          } else if (!isValidCNIC(value)) {
                            return 'CNIC must be in the format XXXXX-XXXXXXX-X';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 10.0),
                      //Store Name
                      TextFormField(
                        controller: controller.storename,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.store),
                            labelText: 'Store Name',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2.0, color: Colors.cyan)),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your store name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      //Store Address
                      TextFormField(
                        controller: controller.address,
                        readOnly: true,
                        onTap: () async {
                          final selectedLocation = await Get.to(MapScreen());
                          if (selectedLocation != null) {
                            controller.setLocationSignup(selectedLocation);
                            controller.address.text =
                                "Selected Address"; // Update this to the actual address string
                          }
                        },
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.pin_drop),
                            labelText: 'Store Address',
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2.0, color: Colors.cyan)),
                            border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your store address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      //Email Field
                      TextFormField(
                        controller: controller.email,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(),
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2.0, color: Colors.cyan)),
                            labelText: 'E-Mail'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10.0),
                      //Password Field
                      TextFormField(
                        controller: controller.password,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2.0, color: Colors.cyan)),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          } else if (value.length <= 7) {
                            return 'Password must be at least 8 characters long';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32.0),
                      // SignUp Button
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    final sellerController = Get.put(SellerSignUpController());
                    if (_formKey.currentState!.validate()) {
                      final seller = SellerModel(
                        sellername: controller.sellername.text.trim(),
                        email: controller.email.text.trim(),
                        phone: controller.phone.text.trim(),
                        storename: controller.storename.text.trim(),
                        address: controller.address.text.trim(),
                        cnic: controller.cnic.text.trim(),
                        userId: "",
                        status: '',
                        storeId: '',
                        location: sellerController.sellerlocation,
                        dateTime: Timestamp.now(),
                      );

                      sellerController.createUser(seller, controller.password.text);
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
