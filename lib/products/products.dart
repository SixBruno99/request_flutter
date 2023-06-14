import 'package:flutter/material.dart';

class ProductsRequest extends StatefulWidget {
  const ProductsRequest({super.key});

  @override
  State<ProductsRequest> createState() => _ProductsRequestState();
}

class _ProductsRequestState extends State<ProductsRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        centerTitle: true,
      ),
      body: const Text("Produtos"),
    );
  }
}