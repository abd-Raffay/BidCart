

import 'package:bidcart/controllers/common_controllers/forget_password_controller.dart';
import 'package:bidcart/screens/common/reset_password.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ForgetPasswordController());
    return  Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 40, left: 30, right: 30),
      child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(

                height:300,
                width: 300,

                child: Lottie.asset("assets/animations/lock.json")),
          ),
          const SizedBox(height: 30,),
          const Text("Forget Password",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 20,),
          const Text("Don't worry sometimes people can forget too, enter your email and we will send you a password reset link.",
              style: TextStyle(
                //fontSize: 10,
                color: Colors.grey,
                //fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 60),

          Form(
            key:controller.forgetPasswordFormKey,
            child: TextFormField(
              controller:controller.email,

              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0,color: Colors.cyan)
                  ),
                  border: OutlineInputBorder()),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!EmailValidator.validate(value)) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 30,),

          SizedBox(
            width: double.infinity,
            child:ElevatedButton(
              onPressed:(){
                controller.sendPasswordResetEmail();
              } ,
              child:const Text("Submit") ,
            )
          )
        ],
      )
      ),
    );
  }
}
