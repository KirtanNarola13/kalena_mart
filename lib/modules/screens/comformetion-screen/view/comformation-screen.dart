import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kalena_mart/modules/screens/home-screen/view/home_page.dart';
import 'package:kalena_mart/modules/screens/navbar/navbar.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  _ConfirmationScreenState createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  @override
  void initState() {
    super.initState();
    // After a certain duration, navigate to the home screen
    Timer(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                NavBar()), // Replace HomeScreen with your home screen widget
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
            'https://aogdesign.com.au/wp-content/uploads/2019/02/checkmark.gif'),
      ),
    );
  }
}
