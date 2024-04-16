import 'package:bidcart/const/images.dart';
import 'package:bidcart/controllers/customer_controllers/customer_signup_controller.dart';
import 'package:bidcart/model/customer_model.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:bidcart/screens/customer/customer_login.dart';
import 'package:get/get.dart';


class CustomerSignup extends StatefulWidget {
  const CustomerSignup({super.key});


  @override
  State<CustomerSignup> createState() => _CustomerSignupState();

}


class _CustomerSignupState extends State<CustomerSignup> {
  final controller = Get.put(CustomerSignUpController());
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;


  final customerrepo = Get.put(CustomerRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TAppBar(showBackArrow: true,),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset(Images.logo),
                  ),

                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Join our grocery Community",
                      style: TextStyle(

                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Create your account to start Shopping",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),

                  //Username Feild
                  TextFormField(
                    controller: controller.name,

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
                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyan,
                        foregroundColor: Colors.white,
                      ),

                      onPressed: () {
                        final customer=CustomerModel(
                            name: controller.name.text.trim(),
                            email: controller.email.text.trim(),
                            //password: controller.password.text.trim(),
                            phone: controller.phone.text.trim(),
                            id:"",
                        );

                        if (_formKey.currentState!.validate()) {
                          CustomerSignUpController.instance.createUser(customer,controller.password.text);
                          //SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                          controller.email.clear();
                          controller.password.clear();

                        }



                       // await _signUp();
                      },
                      child: const Text('Sign Up'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );



  }
}


