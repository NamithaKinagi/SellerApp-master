// To parse this JSON data, do
//
//     final orders = ordersFromJson(jsonString);

import 'dart:convert';

import 'dart:ffi';

List<Orders> ordersFromJson(String str) => List<Orders>.from(json.decode(str).map((x) => Orders.fromJson(x)));

String ordersToJson(List<Orders> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Orders {
    Orders({
        this.orderId,
        this.customer,
        this.orderPlacedDate,
        this.status,
        this.businessUnit,
        this.totalPrice,
        this.orderFulfillmentTime,
        this.orderPreparationTime,
        this.orderItems,
        this.deliveryResource,
    });

    int orderId;
    Customer customer;
    DateTime orderPlacedDate;
    String status;
    String businessUnit;
    double totalPrice;
    int orderFulfillmentTime;
    double orderPreparationTime;
    List<OrderItem> orderItems;
    DeliveryResource deliveryResource;

    factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        orderId: json["orderId"],
        customer: Customer.fromJson(json["customer"]),
        orderPlacedDate: DateTime.parse(json["orderPlacedDate"]),
        status: json["status"],
        businessUnit: json["businessUnit"],
        totalPrice: json["totalPrice"],
        orderFulfillmentTime: json["orderFulfillmentTime"],
        orderPreparationTime: json["orderPreparationTime"],
        orderItems: List<OrderItem>.from(json["orderItems"].map((x) => OrderItem.fromJson(x))),
        deliveryResource: DeliveryResource.fromJson(json["deliveryResource"]),
    );

    Map<String, dynamic> toJson() => {
        "orderId": orderId,
        "customer": customer.toJson(),
        "orderPlacedDate": orderPlacedDate.toIso8601String(),
        "status": status,
        "businessUnit": businessUnit,
        "totalPrice": totalPrice,
        "orderFulfillmentTime": orderFulfillmentTime,
        "orderPreparationTime": orderPreparationTime,
        "orderItems": List<dynamic>.from(orderItems.map((x) => x.toJson())),
        "deliveryResource": deliveryResource.toJson(),
    };
}

class Customer {
    Customer({
        this.name,
        this.email,
        this.phone,
        this.address,
        this.location,
    });

    String name;
    String email;
    int phone;
    String address;
    Location location;

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        location: Location.fromJson(json["location"]),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "location": location.toJson(),
    };
}

class Location {
    Location({
        this.latitude,
        this.longitude,
    });

    double latitude;
    double longitude;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}

class DeliveryResource {
    DeliveryResource({
        this.driverName,
        this.phone,
        this.image,
        this.licenseNumber,
        this.threePlName,
        this.vehicleNumber,
    });

    String driverName;
    int phone;
    String image;
    String licenseNumber;
    String threePlName;
    String vehicleNumber;

    factory DeliveryResource.fromJson(Map<String, dynamic> json) => DeliveryResource(
        driverName: json["driverName"],
        phone: json["phone"],
        image: json["image"],
        licenseNumber: json["licenseNumber"],
        threePlName: json["threePLName"],
        vehicleNumber: json["vehicleNumber"],
    );

    Map<String, dynamic> toJson() => {
        "driverName": driverName,
        "phone": phone,
        "image": image,
        "licenseNumber": licenseNumber,
        "threePLName": threePlName,
        "vehicleNumber": vehicleNumber,
    };
}

class OrderItem {
    OrderItem({
        this.upc,
        this.image,
        this.price,
        this.skuId,
        this.itemId,
        this.quantity,
        this.basicEtc,
        this.description,
        this.productName,
    });

    String upc;
    String image;
    double price;
    String skuId;
    int itemId;
    int quantity;
    int basicEtc;
    String description;
    String productName;

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        upc: json["upc"],
        image: json["image"],
        price: json["price"],
        skuId: json["skuId"],
        itemId: json["itemId"],
        quantity: json["quantity"],
        basicEtc: json["basic_etc"],
        description: json["description"],
        productName: json["productName"],
    );

    Map<String, dynamic> toJson() => {
        "upc": upc,
        "image": image,
        "price": price,
        "skuId": skuId,
        "itemId": itemId,
        "quantity": quantity,
        "basic_etc": basicEtc,
        "description": description,
        "productName": productName,
    };
}
