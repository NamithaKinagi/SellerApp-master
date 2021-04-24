import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/loginModel.dart';
import '../model/orders.dart';
import 'package:Seller_App/model/Seller.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Seller_App/model/products.dart';
import 'package:Seller_App/session.dart';
import 'package:Seller_App/model/error.dart';

class APIService {
  build(BuildContext context) {}
  APIService({context});

  static final storage = new FlutterSecureStorage();
  static Future<dynamic> login(LoginRequestModel requestModel) async {
    Uri url = Uri.parse("http://10.0.2.2:8080/login/seller");
    Map<String, String> headers = {
      "Accept": "application/json",
      "content-type": "application/json"
    };

    final response = await http.post(
      url,
      body: jsonEncode(requestModel.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      Session.token = json.decode(response.body)['token'];

      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else if (response.statusCode == 401) {
      return Error.fromJson(json.decode(response.body));
    }
  }

  static Future<List<Orders>> fetchOrders() async {
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:8080/orders/seller"),
          headers: {"Authorization": "Bearer " + Session.token});

      if (response.statusCode == 200) {
        return ordersFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<http.Response> changeOrderStatus(int oid) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + Session.token
      },
      body: jsonEncode(<String, String>{
        "status": "Order Preparing",
      }),
    );
    if (response.statusCode == 200) {
      print("Order status changed!");
    } else {
      print("Seller status update failed!");
    }
    return response;
  }

  static Future<http.Response> orderReady(int oid) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + Session.token
      },
      body: jsonEncode(<String, String>{
        "status": "Order Ready",
      }),
    );
    if (response.statusCode == 200) {
      print("Order status changed!");
    } else {
      print("Seller status update failed!");
    }
    return response;
  }

  static Future<http.Response> orderRejected(int oid) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/orders/" + oid.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + Session.token
      },
      body: jsonEncode(<String, String>{
        "status": "Order Rejected",
      }),
    );
    if (response.statusCode == 200) {
      print("Order status changed to rejected !");
    } else {
      print("Seller status update failed!");
    }
    return response;
  }

  static Future<String> fetchName() async {
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:8080/details/seller"),
          headers: {"Authorization": "Bearer " + Session.token});

      if (response.statusCode == 200) {
        return SellerFromJson(response.body).name;
      }
    } on SocketException {
      print('error');
    }
  }

  static Future<http.Response> updateAvailable(bool value) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/update/seller"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + Session.token
      },
      body: jsonEncode(<String, bool>{
        'available': value,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Seller availability changed!");
    } else {
      print("Seller Availability update failed!");
    }
    return response;
  }

  static Future<bool> fetchAvail() async {
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:8080/details/seller"),
          headers: {"Authorization": "Bearer " + Session.token});

      if (response.statusCode == 200) {
        return SellerFromJson(response.body).available;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<Products>> fetchProducts() async {
    try {
      final response = await http.get(
          Uri.parse("http://10.0.2.2:8080/product/seller"),
          headers: {"Authorization": "Bearer " + Session.token});
      //print(response.statusCode);

      if (response.statusCode == 200) {
        return productsFromJson(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<http.Response> updateProdAvailable(bool value, int pid) async {
    final response = await http.put(
      Uri.parse("http://10.0.2.2:8080/product"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": "Bearer " + Session.token
      },
      body: jsonEncode(<String, dynamic>{
        'available': value,
        'pid': pid,
      }),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("Product availability changed!");
    } else {
      print("Product Availability update failed!");
    }
    return response;
  }
}
