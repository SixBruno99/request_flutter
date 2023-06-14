import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlaceHolderRequest extends StatefulWidget {
  const PlaceHolderRequest({Key? key}) : super(key: key);

  @override
  State<PlaceHolderRequest> createState() => _PlaceHolderRequestState();
}

class _PlaceHolderRequestState extends State<PlaceHolderRequest> {
  Map<String, dynamic>? jsonData;
  TextEditingController searchController = TextEditingController();

  Future<void> fetch() async {
    var url = Uri.parse(
        "http://jsonplaceholder.typicode.com/todos/${searchController.text}");
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    setState(() {
      jsonData = json;
    });
  }

  String formatJson(Map<String, dynamic> json) {
    var encoder = const JsonEncoder.withIndent('');
    return encoder.convert(json);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("PlaceHolder"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth * 0.5,
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Digite o número',
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetch,
              child: const Text('Buscar'),
            ),
            const SizedBox(height: 16),
            jsonData != null
                ? SizedBox(
                    width: screenWidth * 0.5,
                    child: Text(formatJson(jsonData!)),
                  )
                : const Text('Pressione o botão para carregar os dados'),
          ],
        ),
      ),
    );
  }
}
