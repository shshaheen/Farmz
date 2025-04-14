import 'package:farmz/Views/Screens/Farmer/farm_tasks.dart';
import 'package:farmz/Views/Screens/Farmer/market_demand.dart';
import 'package:farmz/Views/Screens/Farmer/upload_products.dart';
import 'package:farmz/Views/Screens/Farmer/village_community.dart';
import 'package:flutter/material.dart';
import 'chat_screen.dart';

class FarmerHomePage extends StatefulWidget {
  const FarmerHomePage({super.key});

  @override
  State<FarmerHomePage> createState() => _FarmerHomePageState();
}

class _FarmerHomePageState extends State<FarmerHomePage> {
  int _selectedIndex = 0;

  final List<String> _iconPaths = [
    "assets/images/demand.png",
    "assets/images/village_community.png",
    "assets/images/crop_calender.png",
    "assets/images/upload.png",
  ];
  final List<Widget> _pages = [
    MarketDemand(),
    VillageCommunity(),
    FarmTasks(),
    UploadProducts(),
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
        title: const Text("Hello Farmer!"),

         actions: [
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatScreen()));
                 
                  // Handle profile tap
                },
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/niya.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
        // centerTitle: true,
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
      body: _pages[_selectedIndex]
    );
  }
}
