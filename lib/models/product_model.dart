// To parse this JSON data, do
//
//     final productResponse = productResponseFromMap(jsonString);

import 'dart:convert';

class ProductResponse {
  ProductResponse(
      {required this.available,
      required this.name,
      this.picture,
      required this.price,
      required this.productResponseAvailable,
      this.id});

  bool available;
  String name;
  String? picture;
  double price;
  bool productResponseAvailable;
  String? id;

  factory ProductResponse.fromJson(String str) =>
      ProductResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponse.fromMap(Map<String, dynamic> json) => ProductResponse(
        available: json["available"] == null ? null : json["available"],
        name: json["name"],
        picture: json["picture"],
        price: json["price"].toDouble(),
        productResponseAvailable:
            json["available "] == null ? null : json["available "],
      );

  Map<String, dynamic> toMap() => {
        "available": available == null ? null : available,
        "name": name,
        "picture": picture,
        "price": price,
        "available ":
            productResponseAvailable == null ? null : productResponseAvailable,
      };
}
