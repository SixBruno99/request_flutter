import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsRequest extends StatefulWidget {
  const ProductsRequest({super.key});

  @override
  State<ProductsRequest> createState() => _ProductsRequestState();
}

class _ProductsRequestState extends State<ProductsRequest> {
  List<dynamic> products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    const String url = 'https://dummyjson.com/products';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData.containsKey('products')) {
          final productsData = jsonData['products'];
          if (productsData is List<dynamic>) {
            setState(() {
              isLoading = false;
              products = productsData;
            });
          } else {
            setState(() {
              isLoading = false;
            });
            throw Exception(
                'Resposta inválida: o formato dos dados é inválido');
          }
        } else {
          setState(() {
            isLoading = false;
          });
          throw Exception(
              'Resposta inválida: a chave "products" está faltando');
        }
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Falha ao carregar os produtos');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Erro na solicitação HTTP: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Produtos'),
          centerTitle: true,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Produtos'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            final productName =
                product['title'] ?? 'Nome do produto indisponível';
            final productDescription =
                product['description'] ?? 'Descrição indisponível';
            final productImage =
                product['thumbnail'] ?? 'https://via.placeholder.com/150';
            final productPrice = product['price'] ?? 'Preço indisponível';

            return ListTile(
              title: Text(productName),
              subtitle: Text(productDescription),
              leading: Image.network(productImage),
              trailing: Text('\$$productPrice'),
            );
          },
        ),
      );
    }
  }
}
