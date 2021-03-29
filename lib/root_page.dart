import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/pages/home_page.dart';
import 'pages/login_page.dart';

class RootPage extends StatefulWidget {
  

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus {
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (_authStatus){
      case AuthStatus.notSignedIn:
       return new LoginPage();
      case AuthStatus.signedIn:
       return HomePage();
    }
    
  }
}