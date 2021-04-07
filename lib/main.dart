import 'package:Seller_App/introductionScreen.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/dashboardMenu.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'providers/tokenModel.dart';
import 'package:Seller_App/Screens/loginScreen.dart';
import 'package:Seller_App/rootPage.dart';
import 'providers/statusUpdate.dart';
import 'package:provider/provider.dart';

//import 'pages/login_page.dart';

void main() {
  runApp( MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TokenModel()),
      ChangeNotifierProvider(create: (_)=>StatusUpdate())
    ],
    child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Loader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        fontFamily: 'Poppins',
        primaryColor: Colors.white,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          elevation: 0,
          foregroundColor: Colors.white,
        ),
        accentColor: Colors.blueGrey,
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 22.0, color: Colors.blueGrey),
          headline2: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.w700,
            color: Colors.blueGrey,
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Colors.blueAccent,
          ),
        ),
      ),
      home: OnBoardingPage(),
    );
  }
}
