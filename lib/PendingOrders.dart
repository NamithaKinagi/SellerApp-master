import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/TokenModel.dart';
import 'package:provider/provider.dart';
import 'model/orders.dart';
import 'package:http/http.dart' as http;

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();
  Future<List<Orders>> fetchItems(BuildContext context, String token) async {
    final response = await http.get(Uri.parse("http://10.0.2.2:8080/orders"),
        headers: {"Authorization": "Bearer " + token});

    if (response.statusCode == 200) {
      return ordersFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<http.Response> changeOrderStatus(int oid, String token) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + token
      },
      body: jsonEncode(<String, String>{
        "status": "Order Preparing",
      }),
    );
    if (response.statusCode == 200) {
      print("Order status changed!");
    } else {
      print("Seller status update failed!");
    }
    return response;
  }

  Future<http.Response> orderRejected(int oid, String token) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + token
      },
      body: jsonEncode(<String, String>{
        "status": "Order Rejected",
      }),
    );
    if (response.statusCode == 200) {
      print("Order status changed to rejected !");
    } else {
      print("Seller status update failed!");
    }
    return response;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return Consumer<TokenModel>(builder: (context, value, child) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 150,
              width: size.height,
              decoration: BoxDecoration(color: Colors.transparent),
              child: FutureBuilder(
                future: fetchItems(context, value.token),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        Orders item = snapshot.data[index];
                        print(item.status);
                        print(item.oid);
                        if (item.status == 'Order Placed') {
                          return Card(
                            elevation: 8,
                            color: Colors.blueGrey[600],
                            shadowColor: Colors.black38,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 7.0),
                                        child: Text(
                                          item.status == "Order Placed"
                                              ? 'Ordered'
                                              : 'Bad',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 100.0),
                                        child: IconButton(
                                          icon: Icon(Icons.more_horiz),
                                          color: Colors.white,
                                          onPressed: () {
                                            _settingModalBottomSheet(
                                                context, item);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    '#00${item.oid}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 180.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.timer_outlined),
                                        Text(
                                          item.date.hour.toString() +
                                              ":" +
                                              item.date.minute.toString(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: RaisedButton(
                                          hoverColor: Colors.blueGrey,
                                          onPressed: () {
                                            changeOrderStatus(
                                                item.oid, value.token);
                                          },
                                          color: Colors.black,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Text("Accept",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      RaisedButton(
                                        hoverColor: Colors.blueGrey,
                                        onPressed: () {
                                          orderRejected(item.oid, value.token);
                                        },
                                        color: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text("Reject",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}

void _settingModalBottomSheet(context, Orders item) {
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext bc) {
        return ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: item.orderItems.length,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[400],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.grey[300],
                            spreadRadius: 5)
                      ]),
                  child: new ListTile(
                      leading: new Icon(Icons.music_note),
                      title: new Text(item.orderItems[index].products.name),
                      onTap: () => {}),
                ),
              );
            });
      });
}
