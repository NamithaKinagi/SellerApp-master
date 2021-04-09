import 'package:Seller_App/Screens/loginScreen.dart';
import 'package:Seller_App/rootPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RootPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
  
    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
          ),
        ),
      ),
      pages: [
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
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      
    );
  }
}
