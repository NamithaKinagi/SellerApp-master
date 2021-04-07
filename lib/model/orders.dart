// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

List<Orders> ordersFromJson(String str) => List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
    Orders({
        this.oid,
        this.customer,
        this.seller,
        this.date,
        this.status,
        this.source,
        this.totalPrice,
        this.orderItem,
    });

    int oid;
    String customer;
    String seller;
    DateTime date;
    String status;
    String source;
    double totalPrice;
    List<OrderItem> orderItem;

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        oid: json["oid"],
        customer: json["customer"],
        seller: json["seller"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        source: json["source"],
        totalPrice: json["totalPrice"],
        orderItem: List<OrderItem>.from(json["orderItem"].map((x) => OrderItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "oid": oid,
        "customer": customer,
        "seller": seller,
        "date": date.toIso8601String(),
        "status": status,
        "source": source,
        "totalPrice": totalPrice,
        "orderItem": List<dynamic>.from(orderItem.map((x) => x.toJson())),
    };
}

class OrderItem {
    OrderItem({
        this.price,
        this.skuId,
        this.itemId,
        this.quantity,
        this.productName,
        this.orderCompletionTime,
    });

    double price;
    String skuId;
    int itemId;
    int quantity;
    String productName;
    int orderCompletionTime;

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        price: json["price"],
        skuId: json["skuId"],
        itemId: json["itemId"],
        quantity: json["quantity"],
        productName: json["productName"],
        orderCompletionTime: json["orderCompletionTime"],
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "skuId": skuId,
        "itemId": itemId,
        "quantity": quantity,
        "productName": productName,
        "orderCompletionTime": orderCompletionTime,
    };
}
