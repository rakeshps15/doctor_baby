import 'dart:async';
import 'package:doctor_baby/views/inro_screens/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/colors/mycolors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override

  void initState() {
    //what will happen when the app or page is first launched
    Timer(Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => Intro()));
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset('assets/intro_images/baby.png',height: 300,width: 300,),
            ),
            Text("Welcome",style: GoogleFonts.satisfy(fontSize: 100,fontWeight: FontWeight.bold,color: MyColors.titleTextColor))
          ],
        ),
      ),
    );
  }
}
