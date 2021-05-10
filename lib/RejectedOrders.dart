import 'dart:convert';
import 'package:Seller_App/session.dart';
import 'package:Seller_App/widgets/orderDetails.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'providers/orderUpdate.dart';
import 'models/orders.dart';
import 'package:provider/provider.dart';
import 'widgets/cards.dart';
import 'package:http/http.dart' as http;

class RejectedOrders extends StatefulWidget {
  @override
  _RejectedOrdersState createState() => _RejectedOrdersState();
}

class _RejectedOrdersState extends State<RejectedOrders> {
  OrderDetail orderItem = new OrderDetail();
  var format = DateFormat('dd-MM-yyyy');
  int days;
  int selectedValue = 1;
  List<Orders> lastRejected = [];
  Future<List<Orders>> fetchOrders(int i) async {
    lastRejected.clear();
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:8080/orders/seller"),
          headers: {"Authorization": "Bearer " + Session.token});
      List<dynamic> responseJson = json.decode(response.body);
      List<Orders> ordersList =
          responseJson.map((d) => new Orders.fromJson(d)).toList();
      ordersList.forEach((element) {
        if (element.orderPlacedDate
                .isAfter(DateTime.now().subtract(Duration(days: i))) &&
            element.status == 'Order Rejected') {
          setState(() {
            lastRejected.add(element);
          });
        }
      });
      if (response.statusCode == 200) {
        return lastRejected;
      } else {
        return ordersFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Update>(builder: (context, Update orders, child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffCCCCCD),
            title: Text(
              'Rejected Orders',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          backgroundColor: Colors.grey[300],
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white60,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: DropdownButton(
                            focusColor: Colors.white,
                            value: selectedValue,
                            items: [
                              DropdownMenuItem(
                                onTap: () {
                                  setState(() {
                                    days = 0;
                                  });
                                },
                                child: Text("Today"),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  setState(() {
                                    days = 2;
                                  });
                                },
                                child: Text("Last two days"),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                onTap: () {
                                  setState(() {
                                    days = 5;
                                  });
                                },
                                child: Text("Last five days"),
                                value: 3,
                              ),
                              DropdownMenuItem(
                                  child: Text("Last ten days"), value: 4),
                            ],
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                              fetchOrders(days);
                            }),
                      ),
                    ),
                  ),
                ]),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: (selectedValue != 1)
                      ? lastRejected.length
                      : orders.rejectedOrders.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Orders item = (selectedValue != 1)
                        ? lastRejected[index]
                        : orders.rejectedOrders[index];
                    if (item.status == 'Order Rejected') {
                      return GestureDetector(
                        onTap: () {
                          orderItem.settingModalBottomSheet(
                              context, item, index);
                        },
                        child: Cards(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '#00${item.orderId}',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red[300],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.date_range),
                                          SizedBox(width: 5),
                                          Text(
                                            'Date',
                                            style: TextStyle(
                                                color: Colors.deepOrangeAccent),
                                          ),
                                        ],
                                      ),
                                      Text(format.format(item.orderPlacedDate)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text("Customer Name: ",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                  Text(
                                    item.customer.name,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Business Unit: ",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                  Text(
                                    item.businessUnit,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Total Price: ",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black)),
                                  Text(
                                    "\$ " + item.totalPrice.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  'Rejection reason : Product out of stock',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ));
    });
  }
}
