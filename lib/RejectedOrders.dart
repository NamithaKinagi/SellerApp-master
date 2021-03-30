import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_post_request/model/orders.dart';
import 'DashboardMenu.dart';
import 'main.dart';
import 'model/orders.dart';
import 'package:http/http.dart' as http;

class RejectedOrders extends StatelessWidget {
  const RejectedOrders();
  Future<List<Orders>> fetchItems(BuildContext context) async {
    final response =
        await http.get(Uri.parse("http://10.0.2.2:8080/orders"), headers: {
      "Authorization":
          "eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MTcwNzQzMTEsImV4cCI6MTYxNzA4MTUxMSwiZW1haWwiOiJOYW1pdGhhQGdtYWlsLmNvbSIsIk5hbWUiOiJOYW1pdGhhIiwiQXZhaWxhYmxlIjp0cnVlfQ.xIbFB3gvzZyemaG-TjgWMz0rKi8xxn2zAQukAWPYe8c"
    });

    if (response.statusCode == 200) {
      return ordersFromJson(response.body);
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(
            'Rejected Orders',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder(
            future: fetchItems(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    Orders item = snapshot.data[index];
                    print(item.status);
                    if (item.status == 'Order Rejected') {
                      return Card(
                        color: Colors.blueGrey,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(item.customer,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white)),
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
                                      children: [],
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
        ],
      ),
    );
  }
}
