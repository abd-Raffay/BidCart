
import 'package:bidcart/controllers/signin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final controller=Get.put(SignInController());
    final _formkey=GlobalKey<FormState>();

    return Form(
      key: _formkey,
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

            ),

            const SizedBox(height: 10.0),

            //Password Feild
            TextFormField(
              controller: controller.password,

              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2.0,color: Colors.cyan)
                ),
                border: OutlineInputBorder(),
              ),
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
                  if(_formkey.currentState!.validate()){
                    SignInController.instance.loginUser(controller.email.text.trim(), controller.password.text.trim());
                  }
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}