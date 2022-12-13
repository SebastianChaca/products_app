import 'package:flutter/material.dart';
import 'package:productos_app/models/product_model.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    if (productService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemBuilder: (_, int index) => GestureDetector(
          child: ProductCard(
            product: productService.products[index],
          ),
          onTap: () {
            productService.selectedProduct =
                productService.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
        ),
        itemCount: productService.products.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productService.selectedProduct = ProductResponse(
            available: false,
            name: '',
            price: 0,
          );
          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
