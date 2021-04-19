import 'package:Seller_App/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/home.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/Screens/introductionScreen.dart';
import 'Screens/loginScreen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Seller_App/session.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  Future<String> readStorage() async {
    // final storage = new FlutterSecureStorage();
    // String value = await storage.read(key: "token") ?? "";
    return Session.token ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder(
          future: readStorage(),
          builder: (ctx, snapshot) {
            print(snapshot.data);
            if (snapshot.hasData) {
              if (snapshot.data == "") {
                return LoginPage();
              } else
                return Home();
            } else {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.black,
                valueColor: AlwaysStoppedAnimation(Colors.green),
                strokeWidth: 10,
              ));
            }
          }),
    );
  }
}
