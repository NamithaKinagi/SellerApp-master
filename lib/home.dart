import 'package:Seller_App/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double screenwidth, screenheight;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenheight = size.height;
    screenwidth = size.width;
      return Scaffold(
        body: Stack(
          children: [
            MenuDashboard(),
            MainScreen(),
          ],
        ),
      );
  }
}
