import 'package:bidcart/const/images.dart';
import 'package:bidcart/const/sizes.dart';
import 'package:bidcart/controllers/customer_controllers/customer_signup_controller.dart';
import 'package:bidcart/model/customer_model.dart';
import 'package:bidcart/repository/customer_repository/customer_repository.dart';
import 'package:bidcart/widget/app_bar/appBar.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
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

  @override
  void initState() {
    super.initState();
    // Initialize any necessary state or dependencies here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true),
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
                      fontSize: Sizes.lg,
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
                      fontSize: Sizes.fontSizeMd,
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                // Username Field
                TextFormField(
                  controller: controller.name,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.cyan),
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                // Phone Number Field
                TextFormField(
                  controller: controller.phone,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.cyan),
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
                const SizedBox(height: Sizes.spaceBtwInputFields),
                // Email Field
                TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.cyan),
                    ),
                    labelText: 'E-Mail',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!EmailValidator.validate(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                // Password Field
                TextFormField(
                  controller: controller.password,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.cyan),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length <= 7) {
                      return 'Password must be 8 digits long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                // Location Field
                TextFormField(
                  controller: controller.address,
                  readOnly: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on_rounded),
                    labelText: 'Location',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.cyan),
                    ),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.my_location),
                      onPressed: () {
                        controller.getCurrentLocation();
                        controller.convertLocation(controller.position);
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                // Sign Up Button
                Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final customer = CustomerModel(
                              name: controller.name.text.trim(),
                              email: controller.email.text.trim(),
                              phone: controller.phone.text.trim(),
                              address: controller.address.text.trim(),
                              id: "",
                              location: controller.location,
                            );
                            CustomerSignUpController.instance.createUser(customer, controller.password.text);
                            // Clear form fields
                            controller.name.clear();
                            controller.email.clear();
                            controller.phone.clear();
                            controller.password.clear();
                            controller.address.clear();
                          }
                        },
                        child: const Text('Sign Up'),
                      ),
                    ),
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
