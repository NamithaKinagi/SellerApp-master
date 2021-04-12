import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:Seller_App/rejectedOrders.dart';
import 'providers/tokenModel.dart';
import 'package:provider/provider.dart';
import 'pendingOrders.dart';
import 'activeOrders.dart';
import 'activeOrders.dart';
import 'api/apiService.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

class MenuDashboard extends StatefulWidget {
  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard>
    with SingleTickerProviderStateMixin {
  final storage = new FlutterSecureStorage();
  bool isSwitched = false;

  bool isDrawerOpen = false;
  double screenwidth, screenheight;

  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenheight = size.height;
    screenwidth = size.width;
    return Consumer<TokenModel>(builder: (context, value, child) {
      return Scaffold(
        body: Stack(
          children: [
            menu(context, value.token),
            dashboard(context, value.token),
          ],
        ),
      );
    });
  }

  Widget menu(context, token) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Container(
          color: Color(0xff393E43),
          padding: EdgeInsets.only(top: 70, bottom: 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  IconButton(
                      icon: Icon(Icons.account_circle, color: Colors.white),
                      onPressed: null),
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
                            future: APIService.fetchName(context, token),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold));
                              } else {
                                return CircularProgressIndicator();
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
                    onPressed: () async {
                      Provider.of<TokenModel>(context, listen: false)
                          .addToken("");
                      await storage.delete(key: "token");
                    },
                    icon: Icon(Icons.logout, color: Colors.white),
                    label: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ])
              ]),
        ),
      ),
    );
  }

  Widget dashboard(context, token) {
    Size size = MediaQuery.of(context).size;
    screenheight = size.height;
    screenwidth = size.width;

    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isDrawerOpen ? 0.5 * screenwidth : 0,
      right: isDrawerOpen ? -0.2 * screenwidth : 0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          height: MediaQuery.of(context).size.height/2,
          decoration: BoxDecoration(
            borderRadius: isDrawerOpen
                ? BorderRadius.circular(40)
                : BorderRadius.circular(0),
                color: Color(0xffE5E5E5),
          ),
          
          padding: const EdgeInsets.only(left: 0, top: 0, bottom: 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(scrollDirection: Axis.vertical, children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            isDrawerOpen
                                ? IconButton(
                                    icon: Icon(Icons.arrow_back),
                                    onPressed: () {
                                      setState(() {
                                        isDrawerOpen = !isDrawerOpen;
                                        _controller.reverse();
                                      });
                                    })
                                : IconButton(
                                    icon: Icon(Icons.menu),
                                    onPressed: () {
                                      setState(() {
                                        isDrawerOpen = !isDrawerOpen;
                                        _controller.forward();
                                      });
                                    }),
                            Column(children: [
                              FutureBuilder(
                                  future: APIService.fetchName(context, token),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Text(snapshot.data);
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  }),
                              FutureBuilder(
                                  future: APIService.fetchAvail(context, token),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      isSwitched = snapshot.data;
                                      return FlutterSwitch(
                                          activeSwitchBorder: Border.all(
                                              width: 2, color: Colors.green),
                                          activeColor: Colors.white,
                                          activeToggleColor: Colors.green,
                                          inactiveToggleBorder: Border.all(
                                              width: 3.0, color: Colors.black),
                                          activeToggleBorder: Border.all(
                                              width: 2.0, color: Colors.green),
                                          width: 45.0,
                                          height: 20.0,
                                          valueFontSize: 10.0,
                                          activeTextColor: Colors.green,
                                          toggleSize: 18.0,
                                          value: isSwitched,
                                          borderRadius: 15.0,
                                          padding: 0.0,
                                          showOnOff: true,
                                          onToggle: (val) {
                                            setState(() {
                                              isSwitched = val;

                                              Widget cancelButton = FlatButton(
                                                child: Text("Cancel"),
                                                onPressed: () {
                                                  setState(() {});
                                                  isSwitched = !val;
                                                  val = isSwitched;

                                                  APIService.updateAvailable(
                                                      val, token);
                                                  Navigator.of(context).pop();
                                                },
                                              );
                                              Widget continueButton =
                                                  FlatButton(
                                                child: val
                                                    ? Text("Go online")
                                                    : Text('Go Offline'),
                                                onPressed: () {
                                                  setState(() {});
                                                  APIService.updateAvailable(
                                                      val, token);
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                  //updateAvailable(val,token);
                                                },
                                              );
                                              // set up the AlertDialog
                                              AlertDialog alert = AlertDialog(
                                                title: Text("Warning!"),
                                                content: val
                                                    ? Text(
                                                        "Are you sure you want to go online")
                                                    : Text(
                                                        "Are you sure you want to go Offline"),
                                                actions: [
                                                  cancelButton,
                                                  continueButton,
                                                ],
                                              );
                                              // show the dialog
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return alert;
                                                },
                                              );
                                            });
                                          });
                                    } else {
                                      return CircularProgressIndicator();
                                    }
                                  })
                            ]),
                            IconButton(
                                icon: Icon(Icons.notifications_active),
                                onPressed: null)
                          ],
                        ),
                        FutureBuilder(
                          future: APIService.fetchAvail(context, token),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8, bottom: 16, top: 8),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          'Pending Orders',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      PendingOrders(),
                                    ],
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical:16),
                                    child: Card(
                                      shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20)),
                                      color: Colors.white,
                                      elevation: 10,
                                      child: Container(
                                        height: 170,
                                        width: 300,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                          Icon(
                                            Icons.block_rounded,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text(
                                                'You cant receive orders as you are offline, if you have any pending orders please fulfill them ',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                  fontWeight: FontWeight.w300)),
                                          )
                                        ]),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            } else
                              return CircularProgressIndicator();
                          },
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height*0.8),
                                                  child: Container(
                            width: screenwidth,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  '\nActive Orders',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                ActiveOrders()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
