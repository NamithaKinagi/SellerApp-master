import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/model/orders.dart';
import 'dashboardMenu.dart';
import 'main.dart';
import 'model/orders.dart';
import 'package:Seller_App/api/apiService.dart';
import 'package:provider/provider.dart';
import 'package:Seller_App/providers/tokenModel.dart';
import 'package:http/http.dart' as http;

class RejectedOrders extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;

    return Consumer<TokenModel>(builder: (context, value, child) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:  Color(0xff393E43),
          title: Text(
            'Rejected Orders',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MenuDashboard()));
              // do something
            },
          )),
          backgroundColor: Color(0xffCCCCCD),
      body:
      
       SingleChildScrollView(
                child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FutureBuilder(
              future: APIService.fetchOrders(context,value.token),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      Orders item = snapshot.data[index];
                     
                      if (item.status == 'Order Rejected') {
                        return Card(
                          elevation: 10,
                          margin: EdgeInsets.symmetric(vertical:10,horizontal:25),
                          color:Colors.white,
                          shadowColor: Colors.black,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.status == "Order Rejected"
                                    ? 'Rejected'
                                    : 'Bad',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[400]),
                              ),
                              Text(
                                '#00${item.orderId}',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black26,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(item.customer.name,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black)),
                              ),
                              
                              // Container(
                              //   width: 400,
                              //   child: Row(
                              //     children: [
                              //       Padding(
                              //         padding: const EdgeInsets.only(left: 5),
                              //         child: Row(
                              //           children: [],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // )
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
          ],
      ),
       ),
    );
    });
  }
}
