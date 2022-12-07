import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                const ProductImage(),
                Positioned(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  top: 60,
                  left: 20,
                ),
                Positioned(
                  child: IconButton(
                    icon: const Icon(Icons.camera_alt_outlined),
                    //camara geleria
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  top: 60,
                  right: 20,
                )
              ],
            ),
            const _ProductForm(),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save_outlined),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
            child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              decoration:
                  InputDecorations.authInputDecoration('Nombre del producto'),
            ),
            const SizedBox(height: 30),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecorations.authInputDecoration('Precio del producto'),
            ),
            const SizedBox(height: 30),
            SwitchListTile.adaptive(
              value: true,
              onChanged: (value) {},
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
