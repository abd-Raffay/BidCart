import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_signin_controller.dart';
import 'package:bidcart/screens/common/forget_password.dart';
import 'package:bidcart/screens/common/loading.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:bidcart/widget/container/round_image.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bidcart/screens/customer/customer_signup.dart';
import 'package:get/get.dart';


class CustomerLoginPage extends StatefulWidget {
  const CustomerLoginPage({super.key});

  @override
  CustomerLoginPageState createState() => CustomerLoginPageState();
}

class CustomerLoginPageState extends State<CustomerLoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _isLoading = false;



  @override
  Widget build(BuildContext context) {
    final signinController = Get.put(CustomerSignInController());

    return  Scaffold(
      appBar: const TAppBar(showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const RoundedImage(
                width: 200,
                height: 200,
                imageUrl: Images.logo
              ),
              const Text(
                "Ready to shop?",
                style: TextStyle(
                  fontSize: Sizes.fontSizeLg,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Log in to continue your shopping journey.",
                style: TextStyle(
                  fontSize: Sizes.fontSizeMd,
                  color: Colors.grey,
                ),
              ),
              //const SizedBox(height: 20,),
              Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Email Feild
                      TextFormField(
                        controller: signinController.email,

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
                        controller: signinController.password,

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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyan,
                            foregroundColor: Colors.white,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              // Show loading indicator
                              setState(() {
                                _isLoading = true; // Show loading indicator
                              });
                              // Call login asynchronously
                              await signinController.loginUser(
                                  signinController.email.text.trim(),
                                  signinController.password.text.trim(),
                              );
                              setState(() {
                                _isLoading = false; // Show loading indicator
                              });

                              // Hide loading indicator



                                // Clear fields
                                signinController.email.clear();
                                signinController.password.clear();
                                // Navigate to next screen or perform any other action

                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              //Login Button

              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const CustomerSignup(),
                    ));
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
      floatingActionButton: _isLoading ? LoadingScreen() : null,
    );
  }
}

