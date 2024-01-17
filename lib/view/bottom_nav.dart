import 'package:doctor_baby/view/home.dart';
import 'package:doctor_baby/view/maps.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavi extends StatefulWidget {
  const BottomNavi({super.key});

  @override
  State<BottomNavi> createState() => _BottomNaviState();
}

class _BottomNaviState extends State<BottomNavi> {
 List pages=[
    VaccineCalendar(),
    MapScreen(),
// Container(
//   child: Center(
//     child: Text('settings'),
//   ),
// ),

  ];
  int selecetdIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selecetdIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
setState(() {
  selecetdIndex=value;
});
        },
        items:[
        BottomNavigationBarItem(icon: Icon(Icons.home),label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.map),label: ''),
        // BottomNavigationBarItem(icon: Icon(Icons.settings),label: ''),
       

      ]),
    );
  }
}