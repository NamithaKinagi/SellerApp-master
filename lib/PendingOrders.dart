import 'dart:convert';

import 'package:Seller_App/model/rejectionReasonsJson.dart';
import 'package:Seller_App/providers/rejectionReason.dart';
import 'package:Seller_App/rejectedOrders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/providers/tokenModel.dart';
import 'package:Seller_App/providers/statusUpdate.dart';
import 'package:provider/provider.dart';
import 'model/orders.dart';
import 'api/apiService.dart';
import 'orderDetails.dart';

import 'package:http/http.dart' as http;

class PendingOrders extends StatefulWidget {
  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String url;

    return Consumer2<TokenModel, StatusUpdate>(
        builder: (context, value, child, val) {
      return Container(
        height: 150,
        child: FutureBuilder(
          future: APIService.fetchOrders(context, value.token),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Orders item = snapshot.data[index];
                  switch (item.source) {
                    case 'Sodimac':
                      url = 'assets/sodi.png';
                      break;
                    case 'Tottus':
                      url = 'assets/tottus.png';
                      break;
                    default:
                  }

                  if (item.status == 'Order Placed') {
                    return GestureDetector(
                      onTap: () {
                        _settingModalBottomSheet(context, item);
                      },
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
                        shadowColor: Colors.black12,
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                // decoration: new BoxDecoration(
                                //   boxShadow: [
                                //     BoxShadow(
                                //       color: Colors.grey[400],
                                //       blurRadius: 45.0, // soften the shadow
                                //       spreadRadius: 5.0, //extend the shadow
                                //       offset: Offset(
                                //         5.0, // Move to right 10  horizontally
                                //         15.0, // Move to bottom 10 Vertically
                                //       ),
                                //     )
                                //   ],
                                // ),
                                height: 60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 75,
                                      child: FittedBox(
                                        child: Image(
                                          image: new AssetImage(url),

  OrderDetail orders=new OrderDetail();
    return Consumer2<TokenModel, StatusUpdate>(
        builder: (context, value, child, val) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 140,
            width: size.height,
            decoration: BoxDecoration(color: Colors.transparent),
            child: FutureBuilder(
              future: APIService.fetchOrders(context, value.token),
              builder: (context, snapshot) {
                
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      Orders item = snapshot.data[index];
                      
                      if (item.status == 'Order Placed') {
                        return GestureDetector(
                          onTap: () {
                            
                          orders.settingModalBottomSheet(context, item);
                          
                          },
                          child: Card(
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
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Container(
                                        //height: 40,
                                        child: Column(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.timer_outlined,
                                              size: 30,
                                            ),
                                            Text(
                                              item.date.hour.toString() +
                                                  ":" +
                                                  item.date.minute.toString(),
                                              style:
                                                  TextStyle(color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8),
                                child: Text(
                                  '#00${item.oid}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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
                                          setState(() {});
                                          Provider.of<StatusUpdate>(context,
                                                  listen: false)
                                              .addToken(item.status);
                                          APIService.changeOrderStatus(
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
                                        _showRejectionchoiceDialog(
                                            item, value.token);
                                        //setState(() {});
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
                        ),
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
      );
    });
  }

  
  _showRejectionchoiceDialog(Orders item, token) => showDialog(
      context: context,
      builder: (context) {
        final _rejectioneNotifier =
            Provider.of<RejectionReasons>(context, listen: false);
        return Consumer<RejectionReasons>(builder: (context, value, child) {
          return AlertDialog(
            title: Text('Select Rejection Reason'),
            content: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: reasons
                      .map((e) => RadioListTile(
                            title: Text(e),
                            value: e,
                            groupValue: _rejectioneNotifier.currentReason,
                            selected: _rejectioneNotifier.currentReason == e,
                            onChanged: (value) {
                              _rejectioneNotifier.updateCountry(value);
                              Navigator.of(context).pop();
                            },
                          ))
                      .toList(),
                ),
              ),
            ),
            actions: [
              FlatButton(
                  child: Text('Continue'),
                  onPressed: () {
                    setState(() {});
                    APIService.orderRejected(item.oid, token);
                    Navigator.of(context).pop();
                  }),
              FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  }),
            ],
          );
        });
      });
}
