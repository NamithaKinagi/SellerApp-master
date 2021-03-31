import 'package:flutter/material.dart';

import 'package:introduction_screen/introduction_screen.dart';

import 'pages/login_page.dart';

class IntroScreen extends StatelessWidget {
  List<PageViewModel> getPages() {
    return [
      PageViewModel(
        title: "Welcome to Express delivery app",
        body: "Delivering one order at a time ",
        image: Center(
          child: Image.asset("assets/sellerLogo.jpeg", height: 250.0),
        ),
      ),
      PageViewModel(
        title: "Seller accept/reject order",
        body:
            "Providing an option for you to either accept or reject a particular order",
        image: Center(
          child: Image.asset("assets/Screen2.jpeg", height: 250.0),
        ),
      ),
      PageViewModel(
        title: "Switch on/off seller",
        body:
            "Now you have full flexibility to either keep your restaurant open or close for receiving orders",
        image: Center(
          child: Image.asset("assets/chef.jpeg", height: 250.0),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IntroductionScreen(
          pages: getPages(),
          onDone: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          done: Text(
            'Done',
            style: TextStyle(color: Colors.black),
          ),
          showSkipButton: true,
          skip: const Text("Skip"),
          globalBackgroundColor: Colors.white,
        ),
      ),
    );
  }
}
