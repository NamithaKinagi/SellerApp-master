import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomePage extends StatelessWidget {
  final storage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: readStorage(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            String value = snapshot.data;
            return Center(
                child: Text(
              value,
              style: TextStyle(fontSize: 15.0),
            ));
          }
          return CircularProgressIndicator();
        });
  }
}

Future<String> readStorage() async {
  final storage = new FlutterSecureStorage();
  String value = await storage.read(key: "token");
  return value;
}
