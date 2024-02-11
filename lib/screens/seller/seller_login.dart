import 'package:bidcart/controllers/seller_controllers/seller_login_controller.dart';
import 'package:bidcart/screens/common/forget_password.dart';
import 'package:bidcart/screens/seller/seller_signup.dart';
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

  final controller = Get.put(SellerLogInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:const EdgeInsets.only(top: 20.0),
                    child:TextButton(onPressed: (){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const OnBoarding()),
                      );
                    },
                        child: const Icon(Icons.arrow_back)
                    ),)
              ),
              Container(
                width: 250,
                height: 250,
                child: Image.asset('assets/images/logo.png'),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(

                  "Reconnect with your customers!",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                "Log in to your seller dashboard to engage with shoppers and grow your brand.",
                style: TextStyle(
                  //fontSize: 15,
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
                              Get.offAll(() => const ForgetPassword());
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
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              SellerLogInController.instance.loginUser(controller.email.text.trim(), controller.password.text.trim());

                              controller.password.clear();
                              //controller.email.clear();
                             // controller.password.clear();
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


              const SizedBox(height: 10),

              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const SSignup(),
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
    );
  }
}

