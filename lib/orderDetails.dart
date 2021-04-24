import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'model/orders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'verification.dart';

class Quantity {
  var quantity = 0.0;
}

class OrderDetail {
  var now = DateTime(0);
  @override
  void settingModalBottomSheet(context, Orders item) {
    showModalBottomSheet(
        backgroundColor: Colors.blueAccent,
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 600,
                  color: Color(0xff6D6D6D),
                  child: Container(
                    child: buildBottomSheet(item, context),
                    decoration: BoxDecoration(
                        color: Color(0xffCCCCCD),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Column buildBottomSheet(item, BuildContext context) {
    Quantity quant = new Quantity();
    // var order = item.orderPlacedDate;
    // var minu=item.orderFulfillmentTime;
    // var add1 = order.add(Duration(minutes: minu));
    String url;
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        'Order Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const Divider(
                        height: 17,
                        thickness: 4,
                        indent: 130,
                        endIndent: 130,
                        color: Color(0xff393E43),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: Row(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_circle_sharp,
                            size: 60,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            //mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    showAlertDialog(item.customer, context);
                                  },
                                  child: Text(
                                    item.customer.name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Text(
                                'Customer Name',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w200),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(item.orderFulfilmentTime.toString()),
                              Text('Order fulfillment time'),
                            ],
                          ),
                        ]),
                  ],
                ),
              ),
              item.deliveryResource.driverName != null
                  ? Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                        child: Column(
                          children: [
                            const Divider(
                              height: 17,
                              thickness: 2,
                              indent: 15,
                              endIndent: 15,
                              color: Colors.white,
                            ),
                            Row(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.account_circle_sharp,
                                    size: 60,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    //mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            showDriver(
                                                item.deliveryResource, context);
                                          },
                                          child: Text(
                                            item.deliveryResource.driverName,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          )),
                                      Text(
                                        'Driver Name',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ],
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              const Divider(
                height: 17,
                thickness: 2,
                indent: 15,
                endIndent: 15,
                color: Colors.white,
              ),
              Container(
                child: Center(
                    child: Text(
                  'Order items',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                )),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: item.orderItems.length,
                  itemBuilder: (context, int index) {
                    print(item.orderItems[index].image);
                    now = item.orderPlacedDate;
                    quant.quantity += item.orderItems[index].quantity;
                    return Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  height: 90,
                                  width: 87,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 2.0),
                                        child: Text(
                                          item.orderItems[index].skuId,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          height: 60,
                                          width: 70,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(13),
                                            // child: CachedNetworkImage(
                                            //   imageUrl: item
                                            //       .orderItems[index].image,
                                            //   placeholder: (context, url) =>
                                            //       CircularProgressIndicator(),
                                            //   errorWidget:
                                            //       (context, url, error) =>
                                            //           Icon(Icons.error),
                                            // ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '\$' +
                                            item.orderItems[index].price
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff0D2F36)),
                                      ),
                                    ],
                                  )),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.orderItems[index].productName,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                        child: Text(
                                      'X ' +
                                          item.orderItems[index].quantity
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w200,
                                          color: Colors.black),
                                    )),
                                  ]),
                              Text(
                                '\$' +
                                    (item.orderItems[index].quantity *
                                            item.orderItems[index].price)
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xff0D2F36),
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipPath(
                  child: Container(
                      width: 400,
                      height: 70,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  'Items',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  '7',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12.0, right: 25),
                                child: Column(children: [
                                  Text(
                                    '\$' + item.totalPrice.toString(),
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Center(
                                      child: Text(
                                    'Total',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w300),
                                  )),
                                ]),
                              ),
                            ],
                          )
                        ],
                      )),
                  clipper: CustomClipPath(),
                ),
              ),
              item.status == 'Order Preparing'
                  ? Container(
                      height: 34,
                      width: 130,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RaisedButton(
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Verify()),
                              )
                            },
                            color: Colors.white,
                            elevation: 10,
                            child: Row(
                              children: [
                                Text(
                                  'Handover',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(Icons.bike_scooter),
                              ],
                            ),
                            //other properties
                          ),
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }

  showAlertDialog(Customer cust, BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Customer Details"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Customer name: " + cust.name),
          Text("Address: " + cust.address),
          Text("Phone number: " + cust.phone.toString())
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showDriver(DeliveryResource dri, BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Driver Details"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Driver name: " + dri.driverName),
          Text("Phone number: " + dri.phone.toString()),
          Text("Licence number: " + dri.licenseNumber),
          Text("threePLName: " + dri.threePlName),
          Text("Vehicle number: " + dri.vehicleNumber)
        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 30.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.7);
    path.moveTo(size.width / 12, 0);
    var firstEnd = new Offset(0, size.height / 3);
    var firstControl = new Offset(0, 0);
    path.quadraticBezierTo(
        firstControl.dx, firstControl.dy, firstEnd.dx, firstEnd.dy);
    //path.lineTo(0, size.height/3);
    var secondEnd = new Offset(radius, size.height * 0.7);
    var secondControl = new Offset(0, size.height * 0.7);
    path.quadraticBezierTo(
        secondControl.dx, secondControl.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width * 0.7 - 10, size.height * 0.7);
    var thirdEnd = new Offset(size.width * 0.7 + radius, size.height);
    var thirdControl = new Offset(size.width * 0.7, size.height);
    path.quadraticBezierTo(
        thirdControl.dx, thirdControl.dy, thirdEnd.dx, thirdEnd.dy);
    path.lineTo(size.width - radius, size.height);
    var forthEnd = new Offset(size.width, size.height - radius);
    var forthControl = new Offset(size.width, size.height);
    path.quadraticBezierTo(
        forthControl.dx, forthControl.dy, forthEnd.dx, forthEnd.dy);
    path.lineTo(size.width, size.height);

    path.lineTo(size.width, size.height / 4 + 10);
    var fifthEnd = new Offset(size.width - radius, 0);
    var fifthControl = new Offset(size.width, 0);
    path.quadraticBezierTo(
        fifthControl.dx, fifthControl.dy, fifthEnd.dx, fifthEnd.dy);
    //path.quadraticBezierTo(thirdControl.dx, thirdControl.dy, thirdEnd.dx, thirdEnd.dy);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
