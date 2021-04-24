import 'package:Seller_App/Screens/loginScreen.dart';
import 'package:Seller_App/catalogue.dart';
import 'package:Seller_App/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'RejectedOrders.dart';
import 'package:provider/provider.dart';
import 'api/apiService.dart';

class MenuDashboard extends StatefulWidget {
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with TickerProviderStateMixin {
  bool isSwitched = false;
  bool isDrawerOpen = false;

  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;
  AnimationController controllerOne;
  Animation<Color> animationOne;
  Animation<Color> animationTwo;
  Future<dynamic> _name;
  @override
  void initState() {
    
    super.initState();
    _name=APIService.fetchName();

    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    controllerOne = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    animationOne = ColorTween(begin: Colors.black38, end: Colors.white24)
        .animate(controllerOne);
    animationTwo = ColorTween(begin: Colors.white24, end: Colors.black38)
        .animate(controllerOne);
    controllerOne.forward();
    controllerOne.addListener(() {
      if (controllerOne.status == AnimationStatus.completed) {
        controllerOne.reverse();
      } else if (controllerOne.status == AnimationStatus.dismissed) {
        controllerOne.forward();
      }
      //this.setState((){});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    controllerOne.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff393E43),
      padding: EdgeInsets.only(top: 70, bottom: 30),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              IconButton(
                  icon: Icon(Icons.account_circle, color: Colors.white),
                  onPressed:(){}),
              SizedBox(
                width: 10,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    FutureBuilder(
                        future: _name,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold));
                          } else {
                            return ShaderMask(
                                shaderCallback: (rect) {
                                  return LinearGradient(
                                      tileMode: TileMode.mirror,
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        animationOne.value,
                                        animationTwo.value
                                      ]).createShader(rect,
                                      textDirection: TextDirection.ltr);
                                },
                                child: Text(''));
                          }
                        }),
                  ])
            ]),
            Column(
              children: [
                Row(
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Catalogue()),
                          );
                          // Catalogue();
                        },
                        label: Text(
                          'Catalogue',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon:
                            Icon(Icons.shopping_cart, color: Colors.white))
                  ],
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        //OrderHistory();
                      },
                      icon: Icon(
                        Icons.history,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Order history',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RejectedOrders()),
                          );
                        },
                        label: Text(
                          'Rejected Orders',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(Icons.cancel, color: Colors.white))
                  ],
                ),
              ],
            ),
            Row(children: [
              SizedBox(width: 10),
              TextButton.icon(
                onPressed: () {
                  //Settings();
                },
                icon: Icon(Icons.settings, color: Colors.white),
                label: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(width: 10),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              TextButton.icon(
                onPressed: () {
                  Session.logout();
                  print(Session.token);
                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                },
                icon: Icon(Icons.logout, color: Colors.white),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ])
          ]),
    );
  }
}
