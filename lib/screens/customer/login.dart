import 'package:bidcart/controllers/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bidcart/screens/onboarding.dart';
import 'package:bidcart/screens/customer/signup.dart';
import 'package:get/get.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

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
                    MaterialPageRoute(builder: (_) => const OnBoarding()),
                  );
                },
                    child: const Icon(Icons.arrow_back)
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

                            onPressed: () {},
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
                              SignInController.instance.loginUser(controller.email.text.trim(), controller.password.text.trim());

                              controller.email.clear();
                              controller.password.clear();
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
              Column(
                children: [
                  const Text("OR"),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                        icon: const Image(
                          image: AssetImage("assets/images/googlelogo.png"),

                          width: 30.0,
                        ),
                        onPressed: () {
                          SignInController.instance.googleSignIn();
                        },
                        label: const Text("Sign in with Google",
                        style:TextStyle(color: Colors.black)
                        )),
                  )
                ],
              ),

              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (_) => const Signup(),
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

