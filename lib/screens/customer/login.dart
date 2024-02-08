import 'package:bidcart/controllers/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

import 'package:bidcart/screens/onboarding.dart';
import 'package:bidcart/screens/customer/signup.dart';
import 'package:bidcart/screens/customer/homescreen.dart';
import 'package:get/get.dart';

import '../../widget/login_form_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final controller = Get.put(SignInController());

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
                  padding:const EdgeInsets.only(top: 40.0),
                  child:TextButton(onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => OnBoarding()),
                  );
                },
                    child: Icon(Icons.arrow_back)
                ),)
              ),
              Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/images/logo.png'),
              ),
              const Text(

                "Login to BidCart",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Enter your credentials",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              LoginForm(),

              //Login Button


              const SizedBox(height: 10),
              Column(
                children: [
                  const Text("OR"),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                        icon: Image(
                          image: AssetImage("assets/images/googlelogo.png"),

                          width: 30.0,
                        ),
                        onPressed: () {

                          SignInController.instance.googleSignIn();

                        },
                        label: Text("Sign in with Google",
                        style:TextStyle(color: Colors.black)
                        )),
                  )
                ],
              ),

              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => Signup(),
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

