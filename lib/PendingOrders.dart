import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/providers/tokenModel.dart';
import 'package:Seller_App/providers/statusUpdate.dart';
import 'package:provider/provider.dart';
import 'model/orders.dart';
import 'api/apiService.dart';
import 'package:http/http.dart' as http;

class CategoriesScroller extends StatefulWidget {
  @override
  _CategoriesScrollerState createState() => _CategoriesScrollerState();
}

class _CategoriesScrollerState extends State<CategoriesScroller> {
int count=0;
  @override
  Widget build(BuildContext context) {
  
    Size size = MediaQuery.of(context).size;
    return Consumer2<TokenModel,StatusUpdate>(builder: (context, value,child,val) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 140,
            width: size.height,
            decoration: BoxDecoration(color: Colors.transparent),
            child: FutureBuilder(
              future: APIService.fetchItems(context, value.token),
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
                         onTap: (){
                           _settingModalBottomSheet(context, item);
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
                                          setState(() {
                                            
                                          });
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
                                        setState(() {
                                          
                                        });
                                        APIService.orderRejected(
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
                        ),
                        );
                      } 
                      else {
                         
                        
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
                itemCount: item.orderItem.length,
                itemBuilder: (context, int index) {
                
                  
                  
                  switch (item.orderItem[index].productName) {
                    case 'Pizza':
                      url = 'assets/pizza.jpeg';
                      break;
                    case 'Burger':
                      url = 'assets/burger.jpeg';
                      break;
                    default:
                  }
    
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
                    child: Container(
                      decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.grey[300],
                                spreadRadius: 5)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Card(
                          child: ListTile(
                            leading: Image(image: new AssetImage(url)),
                            title: Text(item.orderItem[index].productName),
                            subtitle: Row(
                              children: [
                                Text('SKU ID:' +
                                    item.orderItem[index].skuId),
                                SizedBox(width: 5),
                                Text('Quantity : ' +
                                    item.orderItem[index].quantity.toString()),
                              ],
                            ),
                            trailing: Column(
                              children: [
                                Text('Price'),
                                Text(item.orderItem[index].price
                                    .toString())
                                   
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
                Text('Total Amount: '+item.totalPrice.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
              ]
            )
          ],
        );
      });
}

}