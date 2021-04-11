import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/providers/tokenModel.dart';
import 'providers/statusUpdate.dart';
import 'package:provider/provider.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'model/orders.dart';
import 'api/apiService.dart';
import 'package:http/http.dart' as http;
import 'orderDetails.dart';
class ActiveOrders extends StatefulWidget {
  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  CountDownController _controller = CountDownController();

  String url;
  bool _isPause = false;

OrderDetail orders=new OrderDetail();

  @override
  Widget build(BuildContext context) {
    return Consumer2<TokenModel, StatusUpdate>(
        builder: (context, value, child, val) {
      return Container(
        child: FutureBuilder(
          future: APIService.fetchOrders(context, value.token),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
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

                  if (item.status == 'Order Preparing') {

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.grey[200],
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(

                    return GestureDetector(
                          onTap: () {
                            
                          orders.settingModalBottomSheet(context, item);
                          
                          },
                    child: Card(
                      color: Colors.blueGrey,
                      shadowColor: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.status == "Order Placed"
                                ? 'Ordered'
                                : 'Order Preparing\n',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //   item.status == "Order Placed"
                              //       ? 'Ordered'
                              //       : 'Order Preparing\n',
                              //   style: TextStyle(
                              //       fontSize: 18,
                              //       fontWeight: FontWeight.bold,
                              //       color: Colors.orange),
                              // ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    CircularCountDownTimer(
                                      width: 60.0,
                                      height: 60.0,
                                      duration: 20,
                                      fillColor: Colors.amber,
                                      ringColor: Colors.white,
                                      controller: _controller,
                                      backgroundColor: Colors.white54,
                                      strokeWidth: 5.0,
                                      strokeCap: StrokeCap.round,
                                      isTimerTextShown: true,
                                      isReverse: true,
                                      onComplete: () {
// Alert(

// context: context,

// title: 'Done',

// style: AlertStyle(

// isCloseButton: true,

// isButtonVisible: false,

// titleStyle: TextStyle(

// color: Colors.white,

// fontSize: 5.0,

// ),

// ),

// type: AlertType.success)

// .show();
                                      },
                                      textStyle: TextStyle(
                                          fontSize: 15.0, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                '#00${item.oid}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                item.customer,
                                style: TextStyle(color: Colors.black),
                              ),
                              const Divider(
                                height: 5,
                                thickness: 3,
                                indent: 10,
                                endIndent: 40,
                              ),
                              Container(
                                width: 400,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Row(
                                        children: [
                                          RaisedButton(
                                            hoverColor: Colors.blueGrey,
                                            onPressed: () {
                                              setState(() {});
                                            },
                                            color: Colors.black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Text("Mark as Done",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                          SizedBox(width: 5),
                                          RaisedButton(
                                            hoverColor: Colors.blueGrey,
                                            onPressed: () {},
                                            color: Colors.black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Text("Update ETC",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
}
