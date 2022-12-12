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
      this.id,
      this.descript});

  bool available;
  String name;
  String? picture;
  double price;
  String? descript;

  String? id;

  factory ProductResponse.fromJson(String str) =>
      ProductResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponse.fromMap(Map<String, dynamic> json) => ProductResponse(
      available: json["available"] == null ? false : json["available"],
      name: json["name"],
      picture: json["picture"],
      price: json["price"].toDouble(),
      descript: json["descript"] == null ? null : json["descript"]);

  Map<String, dynamic> toMap() => {
        "available": available == null ? null : available,
        "name": name,
        "picture": picture,
        "price": price,
        'descript': descript == null ? null : descript
      };

  ProductResponse copy() => ProductResponse(
      available: this.available,
      name: this.name,
      price: this.price,
      picture: this.picture,
      descript: this.descript,
      id: this.id);
}
