import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sellerapp/models/orders.dart';
import 'package:http/http.dart' as http;

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller();
  Future<List<Orders>> fetchItems(BuildContext context) async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8080/orders"), headers: {
      "Authorization":
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MTcwMTg5NzQsImV4cCI6MTYxNzAyNjE3NCwiZW1haWwiOiJOYW1pdGhhQGdtYWlsLmNvbSIsIk5hbWUiOiJOYW1pdGhhIiwiQXZhaWxhYmxlIjpmYWxzZX0.s_TlDZ23-y9Gj791KBuFQfEQL7SQcn8mOaa9V0SzAM8"
    });

    if (response.statusCode == 200) {
      return ordersFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  Future<http.Response> changeOrderStatus(int oid) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MTY5MzQyNjgsImV4cCI6MTYxNjk0MTQ2OCwiZW1haWwiOiJhYmhpc2hla0BnbWFpbC5jb20iLCJOYW1lIjoiQWJoaXNoZWsiLCJBdmFpbGFibGUiOnRydWV9.ydtRKmznT6CTU9SJTMd-5HyLCdfkGFBewHrbO_l1eks"
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
  Future<http.Response> orderRejected(int oid) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MTY5MzQyNjgsImV4cCI6MTYxNjk0MTQ2OCwiZW1haWwiOiJhYmhpc2hla0BnbWFpbC5jb20iLCJOYW1lIjoiQWJoaXNoZWsiLCJBdmFpbGFibGUiOnRydWV9.ydtRKmznT6CTU9SJTMd-5HyLCdfkGFBewHrbO_l1eks"
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 150,
          width: size.height,
          decoration: BoxDecoration(color: Colors.transparent),
          child: FutureBuilder(
            future: fetchItems(context),
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
                    if(item.status=='Order Placed')
                    {
                    return 
                    Card(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 7.0),
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
                                  padding: const EdgeInsets.only(left: 100.0),
                                  child: IconButton(
                                    icon: Icon(Icons.more_horiz),
                                    color: Colors.grey[800],
                                    onPressed: () {/* Your code */},
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.timer_outlined),
                                  Text(
                                    '${item.date}',
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
                                      changeOrderStatus(item.oid);
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
                                    orderRejected(item.oid);
                                  },
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
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
                    }
                    else{
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
    );
  }
}
