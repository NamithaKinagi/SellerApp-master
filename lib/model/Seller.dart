// To parse this JSON data, do
//
//     final seller = sellerFromJson(jsonString);

import 'dart:convert';

Seller sellerFromJson(String str) => Seller.fromJson(json.decode(str));

String sellerToJson(Seller data) => json.encode(data.toJson());

class Seller {
    Seller({
        this.sid,
        this.email,
        this.password,
        this.date,
        this.name,
        this.available,
    });

    int sid;
    String email;
    String password;
    DateTime date;
    String name;
    bool available;

    factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        sid: json["sid"],
        email: json["email"],
        password: json["password"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        available: json["available"],
    );

    Map<String, dynamic> toJson() => {
        "sid": sid,
        "email": email,
        "password": password,
        "date": date.toIso8601String(),
        "name": name,
        "available": available,
    };
}
