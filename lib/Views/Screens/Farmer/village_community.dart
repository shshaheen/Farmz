import 'package:farmz/Views/Screens/Farmer/widget/community_card1.dart';
import 'package:farmz/Views/Screens/Farmer/widget/community_card2.dart';
import 'package:farmz/Views/Screens/Farmer/widget/community_card3.dart';
import 'package:flutter/material.dart';

class VillageCommunity extends StatelessWidget {
  const VillageCommunity({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 520,
            child: PageView(
              scrollDirection: Axis.horizontal,
              children: [
                CommunityCard1(),
                CommunityCard2(),
                CommunityCard3(),
              ],
              ),
              
          ),
          Wrap(
            spacing: 12,
            children: [
              ActionChip(label: Text("View Members"), onPressed: () {}),
              ActionChip(label: Text("Upcoming Events"), onPressed: () {}),
              ActionChip(label: Text("Chat"), onPressed: () {}),
            ],
          ),
          Container(
  padding: EdgeInsets.all(16),
  margin: EdgeInsets.symmetric(vertical: 12),
  decoration: BoxDecoration(
    color: Colors.green.shade50,
    borderRadius: BorderRadius.circular(12),
  ),
  child: Text(
    '"The ultimate goal of farming is not the growing of crops, but the cultivation of human beings." – Masanobu Fukuoka',
    style: TextStyle(fontStyle: FontStyle.italic, color: Colors.green.shade900),
    textAlign: TextAlign.center,
  ),
),

        ],        
      ),


    );
  }
}