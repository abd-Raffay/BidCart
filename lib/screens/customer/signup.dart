import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:email_validator/email_validator.dart';
import 'package:bidcart/screens/customer/signup.dart';
import 'package:bidcart/screens/customer/login.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:bidcart/toast/toast.dart';
import 'package:bidcart/screens/customer/login.dart';
import 'package:bidcart/screens/onboarding.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});


  @override
  State<Signup> createState() => _SignupState();
}
class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Signup Page')),
          backgroundColor: Colors.cyan,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  Text(
                    "Signup to BidCart",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Enter your credentials",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  TextFormField(
                    controller: _usernameController,

                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }

                      return null;

                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  TextFormField(

                    controller: _passwordController,

                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock,),
                      labelText: 'Password',
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
                  SizedBox(height: 32.0),






                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyan,
                      foregroundColor: Colors.white,
                    ),

                    onPressed: () {

                      if (_formKey.currentState!.validate()) {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text
                        ).then((value) {
                           SuccessToast(context, "Success",
                              "Account Created Sucessfully");
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) => LoginPage()));
                        }).onError((error, stackTrace) {
                          ErrorToast(context, "Failed", "${error.toString()}");
                          print(error.toString());
                        });
                      }


                     // await _signUp();
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );



  }
}


