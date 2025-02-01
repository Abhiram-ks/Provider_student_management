import 'package:flutter/material.dart';
import '../home/homepage/home_screen.dart';

void navigateToHome(context){
    Future.delayed(const Duration(seconds: 3), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
}