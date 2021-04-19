import 'package:Seller_App/model/rejectionReasonsJson.dart';
import 'package:Seller_App/providers/rejectionReason.dart';
import 'package:Seller_App/session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/providers/statusUpdate.dart';
import 'package:provider/provider.dart';
import 'model/orders.dart';
import 'api/apiService.dart';
import 'orderDetails.dart';

class PendingOrders extends StatefulWidget {
  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders>
    with SingleTickerProviderStateMixin {
  AnimationController controllerOne;
  Animation<Color> animationOne;
  Animation<Color> animationTwo;
  Future<List<dynamic>> _orders;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orders=APIService.fetchOrders();
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
      this.setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();

    controllerOne.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    OrderDetail orderitems = new OrderDetail();
    String url;

    return Consumer<StatusUpdate>(
        builder: (context, value, child) {
      //       APIService.fetchOrderItems(context,value.token).then((product_names) {
      //   setState(() {
      //     productNames=product_names;

      //   });
      // });

      return Container(
        height: 160,
        child: FutureBuilder(
          future: _orders,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Orders item = snapshot.data[index];
                  switch (item.businessUnit) {
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
                        orderitems.settingModalBottomSheet(context, item);
                      },
                      child: Card(
                        shadowColor: Colors.black,
                        elevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white,
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 150,
                                        height: 75,
                                        child: FittedBox(
                                          child: Image(
                                            image: new AssetImage(url),
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 5, 8, 0),
                                      child: Container(
                                        //height: 40,
                                        child: Column(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.schedule,
                                              size: 26,
                                            ),
                                            Text(
                                              item.orderPlacedDate.hour
                                                      .toString() +
                                                  ":" +
                                                  item.orderPlacedDate.minute
                                                      .toString() +
                                                  ((item.orderPlacedDate.hour) <
                                                          12
                                                      ? ' am'
                                                      : ' pm'),
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  '#00${item.orderId}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left:8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(productName(item.orderItems)),
                                    Text('Rs ${item.totalPrice.toString()}'),
                                  ],
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
                                              item.orderId);
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
                                            item, Session.token);
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
            return ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                          tileMode: TileMode.mirror,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [animationOne.value, animationTwo.value])
                      .createShader(rect, textDirection: TextDirection.ltr);
                },
                child: Container(
                  color: Colors.white,
                  height: 156,
                  width: MediaQuery.of(context).size.width,
                ));
          },
        ),
      );
    });
  }

  String productName(List<OrderItem> data) {
    String productNames = "";
    String firstHalf="";
    for (int i = 0; i < data.length; i++) {
      productNames += data[i].productName + ", ";
    }
    if (productNames.length > 5) {
      for (int i = 0; i < 5; i++) {
        firstHalf += productNames[i];
      }
      productNames = firstHalf + "...";
    }
    return productNames;
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
                              //Navigator.of(context).pop();
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
                    APIService.orderRejected(item.orderId);
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
