import 'package:flutter/material.dart';
import 'package:Seller_App/dashboardMenu.dart';
import 'providers/tokenModel.dart';

import 'package:provider/provider.dart';
import 'package:Seller_App/Screens/introductionScreen.dart';
import 'dashboardMenu.dart';
import 'activeOrders.dart';
import 'activeOrders.dart';
import 'Screens/loginScreen.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class RootPage extends StatefulWidget {

//   @override
//   _RootPageState createState() => _RootPageState();
// }

// enum AuthStatus {
//   notSignedIn,
//   signedIn
// }

// class _RootPageState extends State<RootPage> {

//   AuthStatus _authStatus = AuthStatus.notSignedIn;

//   @override
//   void initState(){
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Consumer<TokenModel>(builder: (context, tokenModel, child),);
//     // switch (_authStatus){
//     //   case AuthStatus.notSignedIn:
//     //    return new LoginPage();
//     //   case AuthStatus.signedIn:
//     //    return HomePage();
//     // }

//   }
// }

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  String _token = "";
  _RootPageState() {
    readStorage().then((val) => setState(() {
          _token = val;
        }));
  }

  Future<String> readStorage() async {
    final storage = new FlutterSecureStorage();
    String value = await storage.read(key: "token");

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TokenModel>(builder: (context, tokenModel, child) {
        Provider.of<TokenModel>(context, listen: false).addToken(_token);
        if (tokenModel.token == "")
          return LoginPage();
        else
          return MenuDashboard();
      }),
    );
  }
}
