import 'package:flutter/material.dart';

// Widgets
import 'package:flutter_application_1/placeholder/placeholder.dart';
import 'package:flutter_application_1/products/products.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentScreen = 0;

  List<Widget> screens = const [
    PlaceHolderRequest(),
    ProductsRequest(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentScreen],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentScreen,
          onTap: (indice) {
            setState(() {
              _currentScreen = indice;
            });
          },
          items: const [
            BottomNavigationBarItem(
              label: "PlaceHolder",
              icon: Icon(Icons.list),
            ),
            BottomNavigationBarItem(
              label: "Products",
              icon: Icon(Icons.production_quantity_limits),
            ),
          ]),
    );
  }
}
