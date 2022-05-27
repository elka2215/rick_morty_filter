import 'dart:async';

import 'package:flutter/material.dart';

import 'main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () =>
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()),),);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage('assets/images/rickAndMorty.png'),fit: BoxFit.fill,);
  }
}
