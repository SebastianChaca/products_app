import 'package:flutter/material.dart';
import 'package:productos_app/models/product_model.dart';

class ProductImage extends StatelessWidget {
  final ProductResponse product;
  const ProductImage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Container(
          decoration: _buildBoxDecoration(),
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25), topLeft: Radius.circular(25)),
            child: FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              image: NetworkImage(product.picture.toString()),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5))
      ]);
}
