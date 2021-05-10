import 'package:Seller_App/App_configs/app_configs.dart';
import 'package:Seller_App/Home.dart';
import 'package:Seller_App/Screens/drawer.dart';
import 'package:Seller_App/Screens/productDetails.dart';
import 'package:Seller_App/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:Seller_App/models/products.dart';
import 'package:Seller_App/widgets/cards.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:Seller_App/widgets/switchButton.dart';

class Catalogue extends StatefulWidget {
  @override
  _CatalogueState createState() => _CatalogueState();
}

class _CatalogueState extends State<Catalogue> {
  SwitchButton switchButton = new SwitchButton();
  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(builder: (context, Product products, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Catalogue",
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          body: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: products.productsList.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                Products item = products.productsList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetails(
                          image: item.image,
                          name: item.name,
                          skuId: item.skuId,
                          ean: item.ean,
                          upc: item.upc,
                          description: item.description,
                          price: item.price,
                          basicEta: item.basicEta,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Cards(
                        color: Colors.white,
                        padding: EdgeInsets.all(0),
                        margin: EdgeInsets.all(2),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: Row(
                            children: [
                              ClipRRect(
                                clipBehavior: Clip.hardEdge,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(13)),
                                  clipBehavior: Clip.hardEdge,
                                  child: Hero(
                                    tag: item.name,
                                    child: CachedNetworkImage(
                                      imageUrl: item.image,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, top: 8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                            child: Text(
                                              item.name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                          ),
                                          switchButton.showSwitch(
                                              context, index),
                                        ],
                                      ),
                                      Text(
                                        item.skuId,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: 230,
                                        child: Text(
                                          item.description,
                                          textAlign: TextAlign.left,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 15),
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      Text(
                                        "\$ " + item.price.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ),
                              // IconButton(
                              //   icon: Icon(Icons.arrow_right),
                              //   onPressed: () {},
                              // ),
                            ],
                          ),
                        )),
                  ),
                );
              }));
    });
  }
}
