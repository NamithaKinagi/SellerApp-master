import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/TokenModel.dart';
import 'package:provider/provider.dart';
import 'model/orders.dart';
import 'api/api_service.dart';
import 'package:http/http.dart' as http;

class ActiveOrders extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
        OrderListings apiService = new OrderListings();
    return Consumer<TokenModel>(builder: (context, value, child) {
        
      return Container(
        child: FutureBuilder(
          future: apiService.fetchItems(context, value.token),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  Orders item = snapshot.data[index];
                  print(item.status);
                  if (item.status == 'Order Preparing') {
                    return Card(
                      color: Colors.blueGrey,
                      shadowColor: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.status == "Order Placed"
                                ? 'Ordered'
                                : 'Order Preparing',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange),
                          ),
                          Text(
                            '#00${item.oid}',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            item.customer,
                            style: TextStyle(color: Colors.white),
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
                                        onPressed: () {},
                                        color: Colors.black,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Text("Mark as Done",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
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
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
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
      );
    });
  }
}
