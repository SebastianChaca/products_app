import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl =
      'productosappflutter-1ecc4-default-rtdb.firebaseio.com';
  final List<ProductResponse> products = [];
  bool isLoading = false;
  bool isSaving = false;
  late ProductResponse selectedProduct;

  ProductService() {
    this.loadProducts();
  }

  // Future saveOrCreateProduct(ProductResponse product) async {

  //   try {
  //     isSaving = true;
  //     notifyListeners()
  //   } catch (e) {

  //     isSaving = false;
  //     notifyListeners();
  //   }

  // }

  Future<List<ProductResponse>> loadProducts() async {
    final url = Uri.https(_baseUrl, 'products.json');
    try {
      isLoading = true;
      notifyListeners();
      final resp = await http.get(url);

      final Map<String, dynamic> productsMap = json.decode(resp.body);

      productsMap.forEach((key, value) {
        final tempProduct = ProductResponse.fromMap(value);

        tempProduct.id = key;
        products.add(tempProduct);
      });
      print(products);
      isLoading = false;
      notifyListeners();
      return this.products;
    } catch (e) {
      final List<ProductResponse> list = [];

      isLoading = false;
      notifyListeners();
      return list;
    }
  }
}
