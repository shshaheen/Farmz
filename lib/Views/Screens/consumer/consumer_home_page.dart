
import 'package:farmz/Views/Screens/Farmer/village_community.dart';
import 'package:farmz/Views/Screens/consumer/cart_screen.dart';
import 'package:farmz/Views/Screens/consumer/category_screen.dart';
import 'package:farmz/Views/Screens/consumer/products_screen.dart';
import 'package:farmz/controllers/consumer_auth_controller.dart';
import 'package:flutter/material.dart';


class ConsumerHomePage extends StatefulWidget {
  const ConsumerHomePage({super.key});

  @override
  State<ConsumerHomePage> createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<ConsumerHomePage> {
  int _selectedIndex = 0;
  final ConsumerAuthController _authController = ConsumerAuthController();
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
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Confirm Logout'),
                    content: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(ctx).pop(), // Cancel
                        child: Text('No'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(); // Close dialog
                          _authController.signOutUsers(context: context);
                          // 🔓 Perform logout action here
                          // For example, FirebaseAuth.instance.signOut();
                          // Then navigate to login screen
                        },
                        child: Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(width: 8),
            Text(_pages[_selectedIndex]['title']),
          ],
        ),
        
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
