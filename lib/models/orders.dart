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
        this.orderItems,
    });

    int oid;
    String customer;
    String seller;
    DateTime date;
    String status;
    String source;
    List<OrderItem> orderItems;

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        oid: json["oid"],
        customer: json["customer"],
        seller: json["seller"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        source: json["source"],
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "oid": oid,
        "customer": customer,
        "seller": seller,
        "date": date.toIso8601String(),
        "status": status,
        "source": source,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
    };
}

class OrderItem {
    OrderItem({
        this.itemId,
        this.products,
        this.quantity,
    });

    int itemId;
    Products products;
    int quantity;

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        itemId: json["item_id"],
        products: Products.fromJson(json["products"]),
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "products": products.toJson(),
        "quantity": quantity,
    };
}

class Products {
    Products({
        this.pid,
        this.date,
        this.name,
        this.skuId,
        this.price,
        this.available,
        this.basicEta,
    });

    int pid;
    DateTime date;
    String name;
    String skuId;
    double price;
    bool available;
    int basicEta;

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        pid: json["pid"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
        skuId: json["sku_id"],
        price: json["price"],
        available: json["available"],
        basicEta: json["basic_eta"],
    );

    Map<String, dynamic> toJson() => {
        "pid": pid,
        "date": date.toIso8601String(),
        "name": name,
        "sku_id": skuId,
        "price": price,
        "available": available,
        "basic_eta": basicEta,
    };
}