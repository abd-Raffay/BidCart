import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/seller_controllers/seller_login_controller.dart';
import 'package:bidcart/screens/common/forget_password.dart';
import 'package:bidcart/screens/common/loading.dart';
import 'package:bidcart/screens/seller/seller_signup.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bidcart/screens/common/onboarding.dart';
import 'package:get/get.dart';


class SLoginPage extends StatefulWidget {
  @override
  _SLoginPageState createState() => _SLoginPageState();
}


class _SLoginPageState extends State<SLoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isLoading = false;
  final controller = Get.put(SellerLogInController());

  @override
  Widget build(BuildContext context) {
    final logInController=Get.put(SellerLogInController());
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true,),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(//color: Colors.red,

                width: 200,
                height: 200,
                child: Image.asset(Images.logo),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(

                  "Reconnect with your customers!",
                  style: TextStyle(
                    fontSize: Sizes.fontSizeLg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              //const SizedBox(height: 10,),
              const Text(
                "Log in to your seller dashboard to engage with shoppers and grow your brand.",
                style: TextStyle(
                 // fontSize: Sizes.fontSizeMd,
                  //fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),

              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Email Feild
                      TextFormField(
                        controller: controller.email,

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

                      const SizedBox(height: 10.0),

                      //Password Feild
                      TextFormField(
                        controller: controller.password,

                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0,color: Colors.cyan)

                          ),
                          border: const OutlineInputBorder(),
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
                              )


                          ),
                        ),
                        obscureText: _obscureText,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),

                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(

                            onPressed: () {
                              Get.to(() => const ForgetPassword());
                            },
                            child: const Text("Forgot Password?",
                              style: TextStyle(color: Colors.blue),),

                          )
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true; // Show loading indicator
                            });


                           await controller.loginUser(
                              controller.email.text.trim(),
                             controller.password.text.trim(),
                           );

                            setState(() {
                              _isLoading = false; // Hide loading indicator
                            });



                              controller.password.clear();


                          }
                        },
                        child: const Text('Login'),
                      ),



                    ],
                  ),
                ),
              ),

              //Login Button


              const SizedBox(height: 10),

              TextButton(
                  onPressed: () {
                    Get.to(const SSignup());

                  },
                  child: const Text.rich(TextSpan(
                      text: "Don't have an Account? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                            text: "Signup",
                            style: TextStyle(color: Colors.blue))
                      ]))),
            ],
          ),
        ),
      ),
      floatingActionButton: _isLoading ? LoadingScreen() : null, // Show loading screen overlay conditionally
    );

  }
}

