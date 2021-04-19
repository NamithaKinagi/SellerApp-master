import 'package:Seller_App/providers/rejectionReason.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/rootPage.dart';
import 'providers/statusUpdate.dart';
import 'package:provider/provider.dart';
import 'session.dart';
import 'rootPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Session.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => StatusUpdate()),
    ChangeNotifierProvider<RejectionReasons>(
      create: (_) => RejectionReasons(),
    ),
  ], child: MyApp()));
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
        accentColor: Color(0xff393E43),
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
      home: RootPage(),
    );
  }
}
