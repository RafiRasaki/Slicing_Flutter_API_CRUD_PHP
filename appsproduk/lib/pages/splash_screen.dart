import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
   Timer(Duration(seconds: 5), () {
    Navigator.pushNamedAndRemoveUntil(
      context, '/home', (route) => false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
             Container(
              margin: EdgeInsets.only(top: 240),
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: AssetImage('assets/produk1.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              height: 100,
              child: Column(
                children: [
                  Text(
                    'Product Apps',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        letterSpacing: 3),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              //mobile
              //margin: EdgeInsets.only(top: 210),
              //desktop
              margin: EdgeInsets.only(top: 100),
              width: 120,
              height: 80,
              child: const Column(
                children: [
                  //const SizedBox(height: 1),
                  Text(
                   'Warung Etoks',
                    style:
                    TextStyle(fontSize: 20, color: Colors.black, letterSpacing: 2),
                    textAlign: TextAlign.center,
                  ),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}