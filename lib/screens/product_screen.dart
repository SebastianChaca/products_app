import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:productos_app/models/product_model.dart';
import 'package:productos_app/provider/product_form_provider.dart';

import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../services/product_service.dart';

//https://api.cloudinary.com/v1_1/dpw4ny1sc/image/upload?upload_preset=x3bdb1he
class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);
    final selectedProduct = productService.selectedProduct;

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(selectedProduct),
      child: _ProductScreenBody(
        selectedProduct: selectedProduct,
        productService: productService,
      ),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  final ProductService productService;

  const _ProductScreenBody({
    Key? key,
    required this.productService,
    required this.selectedProduct,
  }) : super(key: key);

  final ProductResponse selectedProduct;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(product: selectedProduct),
                Positioned(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  top: 60,
                  left: 5,
                ),
                Positioned(
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    //camara geleria
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  top: 60,
                  right: 5,
                )
              ],
            ),
            _ProductForm(),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!productForm.isValidForm()) return;
          await productService.saveOrCreateProduct(productForm.product);
        },
        child: const Icon(Icons.save_outlined),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            key: productForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  initialValue: product.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El nombre es obligatorio';
                    }
                  },
                  onChanged: (value) => product.name = value,
                  decoration: InputDecorations.authInputDecoration(
                      'Nombre del producto'),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  initialValue: '${product.price}',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'El precio es obligatorio';
                    }
                  },
                  onChanged: (value) {
                    if (double.tryParse(value) == null) {
                      product.price = 0;
                    } else {
                      product.price = double.parse(value);
                    }
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,2}'))
                  ],
                  decoration: InputDecorations.authInputDecoration(
                      'Precio del producto'),
                ),
                const SizedBox(height: 30),
                SwitchListTile.adaptive(
                  value: product.available,
                  onChanged: productForm.updateAvailability,
                  title: const Text('Disponible'),
                ),
                const SizedBox(height: 30),
              ],
            )),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 5))
          ]);
}
