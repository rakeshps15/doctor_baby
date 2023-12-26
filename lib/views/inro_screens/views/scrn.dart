import 'dart:async';
import 'package:doctor_baby/views/inro_screens/views/pages.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset('assets/intro_images/baby.png',height: 200,width: 150,),
          ),
          SizedBox(height: 40,),
          Text("Welcome",style: TextStyle(fontSize: 50,fontStyle: FontStyle.italic,color: MyColors.titleTextColor))
        ],
      ),
    );
  }
}
