
import 'package:farmz/Views/Screens/Farmer/village_community.dart';
import 'package:farmz/Views/Screens/consumer/cart_screen.dart';
import 'package:farmz/Views/Screens/consumer/category_screen.dart';
import 'package:farmz/Views/Screens/consumer/products_screen.dart';
import 'package:flutter/material.dart';


class ConsumerHomePage extends StatefulWidget {
  const ConsumerHomePage({super.key});

  @override
  State<ConsumerHomePage> createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<ConsumerHomePage> {
  int _selectedIndex = 0;

  final List<String> _iconPaths = [
    "assets/images/home.png",
    "assets/images/village_community.png",
    "assets/images/category.png",
    "assets/images/cart.png",
  ];
final List<Map<String, dynamic>> _pages = [
  {
    'widget': ProductsScreen(),
    'title': 'Market Place',
  },
  {
    'widget': VillageCommunity(),
    'title': 'Village Community',
  },
  {
    'widget': CategoryScreen(),
    'title': 'Categories',
  },
  {
    'widget': CartScreen(),
    'title': 'Cart',
  },
];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title']),
        
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: _iconPaths.map((path) {
          int index = _iconPaths.indexOf(path);
          return BottomNavigationBarItem(
            icon: Image.asset(
              path,
              width: 30,
              height: 30,
              color: _selectedIndex == index ? Colors.green : Colors.grey,
            ),
            label: '', // no label like in the image
          );
        }).toList(),
      ),
      body: _pages[_selectedIndex]['widget'],

    );
  }
}
