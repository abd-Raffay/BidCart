import 'package:bidcart/const/images.dart';
import 'package:bidcart/controllers/seller_controllers/seller_signup_controller.dart';
import 'package:bidcart/model/seller_model.dart';
import 'package:bidcart/screens/seller/seller_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';

import '../../repository/seller_repository/seller_repository.dart';


class SSignup extends StatefulWidget {
  const SSignup({super.key});

  @override
  State<SSignup> createState() => _SSignupState();

}


class _SSignupState extends State<SSignup> {
  final controller = Get.put(SellerSignUpController());
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;


  final sellerrepo = Get.put(SellerRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      Column(
        children: [
          Expanded(
            child:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                            onPressed: (){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => SLoginPage()),
                              );

                            },
                            child: const Icon(Icons.arrow_back,color: Colors.black,)),
                      ),
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      child: Image.asset(Images.logo),
                    ),

                    //Heading and subHeadings
                    const Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Ready to start selling with us?",
                        style: TextStyle(

                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        " Create your seller account today and tap into a world of "
                            "opportunities to showcase your products and grow your business!",
                        style: TextStyle(
                          //fontSize: 15,
                          //fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),


                    //Sellername Feild
                    TextFormField(
                      controller: controller.sellername,

                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0,color: Colors.cyan)
                          ),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10.0),


                    //Phone Number
                    TextFormField(
                      controller: controller.phone,

                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          labelText: 'Phone Number'
                              ''
                              '',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0,color: Colors.cyan)
                          ),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10.0),

                    //CNIC
                    TextFormField(
                      controller: controller.cnic,

                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.card_membership),
                          labelText: 'CNIC'
                              ''
                              '',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0,color: Colors.cyan)
                          ),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10.0),

                    //Store Name
                    TextFormField(
                      controller: controller.storename,

                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.store),
                          labelText: 'Store Name'
                              ''
                              '',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0,color: Colors.cyan)
                          ),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10.0),

                    //Store Address
                    TextFormField(
                      controller: controller.address,

                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.pin_drop),
                          labelText: 'Store Address'
                              ''
                              '',
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0,color: Colors.cyan)
                          ),
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(height: 10.0),


                    //Email Feild
                    TextFormField(

                      controller: controller.email,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0,color: Colors.cyan)
                          ),

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

                    //password Feild
                    TextFormField(

                      controller: controller.password,

                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock,),
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0,color: Colors.cyan)
                        ),
                        //errorText: "Password must be 8 digits long",
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
                          return 'Password must be 8 digits long';
                        } else {
                          print('hello');
                          return null;
                        }
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
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
              child: SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    foregroundColor: Colors.white,
                  ),

                  onPressed: () {
                    final seller=SellerModel(
                    sellername: controller.sellername.text.trim(),
                    email: controller.email.text.trim(),
                    //password: controller.password.text.trim(),
                    phone: controller.phone.text.trim(),
                    storename: controller.storename.text.trim(),
                    address: controller.address.text.trim(),
                      cnic: controller.cnic.text.trim(),
                      userId:"",
                      status: '',
                      storeId: '',
                        dateTime: Timestamp.now(),
                    );

                    if (_formKey.currentState!.validate()) {
                      SellerSignUpController.instance.createUser(seller,controller.password.text);
                      //SellerSignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                      //controller.email.clear();
                      // controller.password.clear();

                    }

                    // await _signUp();
                  },
                  child: const Text('Sign Up'),
                ),
              ),
            ), )
        ],

      ),

    );



  }
}


