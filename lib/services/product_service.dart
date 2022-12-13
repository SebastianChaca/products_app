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

  Future saveOrCreateProduct(ProductResponse product) async {
    isSaving = true;
    notifyListeners();
    if (product.id == null) {
      createProduct(product);
    } else {
      await updateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> updateProduct(ProductResponse product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    await http.put(url, body: product.toJson());

    final index = products.indexWhere((element) => element.id == product.id);

    products[index] = product;

    return product.id!;
  }

  Future<String> createProduct(ProductResponse product) async {
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.post(url, body: product.toJson());
    final decodedData = jsonDecode(resp.body);
    product.id = decodedData['name'];
    products.add(product);

    return product.id!;
  }

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
