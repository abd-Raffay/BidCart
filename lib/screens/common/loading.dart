import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent, // Make the dialog background transparent
      elevation: 0, // No elevation for the dialog
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0,horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10.0,
                offset: const Offset(0, 10),
                spreadRadius: 1000
              ),
            ],
          ),
          child: const Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(), // Loading spinner
              SizedBox(height: 16.0),
              Text(
                'Loading...', // Text indicating loading
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
