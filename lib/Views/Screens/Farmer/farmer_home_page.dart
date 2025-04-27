import 'package:farmz/Views/Screens/Farmer/farm_tasks.dart';
import 'package:farmz/Views/Screens/Farmer/market_demand.dart';
import 'package:farmz/Views/Screens/Farmer/upload_products.dart';
import 'package:farmz/Views/Screens/Farmer/village_community.dart';
import 'package:farmz/controllers/farmer_auth_controller.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({super.key});

  @override
  State<FarmerHomePage> createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  int _selectedIndex = 0;
  final FarmerAuthController _authController = FarmerAuthController();
  final List<String> _iconPaths = [
    "assets/images/demand.png",
    "assets/images/village_community.png",
    "assets/images/crop_calender.png",
    "assets/images/upload.png",
  ];
  final List<Map<String, dynamic>> _pages = [
    {
      'widget': MarketDemand(),
      'title': 'Market Demand',
    },
    {
      'widget': VillageCommunity(),
      'title': 'Village Community',
    },
    {
      'widget': FarmTasks(),
      'title': 'Farmer Calendar',
    },
    {
      'widget': UploadProducts(),
      'title': 'Upload Products',
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
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/GrowBot1.jpg',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
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
