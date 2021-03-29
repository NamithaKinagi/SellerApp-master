import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class APIService {
  final storage = new FlutterSecureStorage();
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "http://10.0.2.2:8080/login/seller";
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
      print(response);
      await storage.write(key: "token", value: json.decode(response.body)['token']);
      print(json.decode(response.body)['token']);
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
      
    } 
    else {
      throw Exception('Failed to load data!');
    }
  }
}
