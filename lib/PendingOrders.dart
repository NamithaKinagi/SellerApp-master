import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/TokenModel.dart';
import 'package:provider/provider.dart';
import 'model/orders.dart';
import 'api/api_service.dart';
import 'package:http/http.dart' as http;

class CategoriesScroller extends StatefulWidget {
  @override
  _CategoriesScrollerState createState() => _CategoriesScrollerState();
}

class _CategoriesScrollerState extends State<CategoriesScroller> {

  @override
  Widget build(BuildContext context) {
    OrderListings apiService = new OrderListings();
    Size size = MediaQuery.of(context).size;
    return Consumer<TokenModel>(builder: (context, value, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 140,
            width: size.height,
            decoration: BoxDecoration(color: Colors.transparent),
            child: FutureBuilder(
              future: apiService.fetchItems(context, value.token),
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
                          elevation: 10,
                          color: Colors.blueGrey[600],
                          shadowColor: Colors.black12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: new BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey[400],
                                      blurRadius: 45.0, // soften the shadow
                                      spreadRadius: 5.0, //extend the shadow
                                      offset: Offset(
                                        5.0, // Move to right 10  horizontally
                                        15.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                ),
                                height: 30,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        '#00${item.oid}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                        //height: 40,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 120.0, top: 0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.timer_outlined,
                                                size: 30,
                                              ),
                                              Text(
                                                item.date.hour.toString() +
                                                    ":" +
                                                    item.date.minute.toString(),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                          apiService.changeOrderStatus(
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
                                        apiService.orderRejected(
                                            item.oid, value.token);
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
      );
    });
  }
  void _settingModalBottomSheet(context, Orders item) {
  double total = 0.0;
  
  String url;
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext bc) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:10.0),
              child: Text(
                'Order Details',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900]),
              ),
            ),
            ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemCount: item.orderItems.length,
                itemBuilder: (context, int index) {
                
                    total += item.orderItems[index].products.price *
                      item.orderItems[index].quantity;

                  
                  switch (item.orderItems[index].products.name) {
                    case 'Pizza':
                      url = 'assets/pizza.jpeg';
                      break;
                    case 'Burger':
                      url = 'assets/burger.jpeg';
                      break;
                    default:
                  }
                  print(total);
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.grey[300],
                                spreadRadius: 5)
                          ]),
                      child: Card(
                        child: ListTile(
                          leading: Image(image: new AssetImage(url)),
                          title: Text(item.orderItems[index].products.name),
                          subtitle: Row(
                            children: [
                              Text('SKU ID:' +
                                  item.orderItems[index].products.skuId),
                              SizedBox(width: 5),
                              Text('Quantity : ' +
                                  item.orderItems[index].quantity.toString()),
                            ],
                          ),
                          trailing: Column(
                            children: [
                              Text('Price'),
                              Text(item.orderItems[index].products.price
                                  .toString())
                                 
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Total Amount :' + '$total',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        );
      });
}

}

