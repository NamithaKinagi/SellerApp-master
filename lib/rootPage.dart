import 'package:flutter/material.dart';
import 'package:Seller_App/dashboardMenu.dart';
import 'providers/tokenModel.dart';

import 'package:provider/provider.dart';
import 'package:Seller_App/introductionScreen.dart';
import 'dashboardMenu.dart';
import 'activeOrders.dart';
import 'activeOrders.dart';
import 'Screens/loginScreen.dart';

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

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TokenModel>(builder: (context, tokenModel, child) {
        if (tokenModel.token == "")
          return LoginPage();
        else
          return MenuDashboard();
      }),
    );
  }
}
