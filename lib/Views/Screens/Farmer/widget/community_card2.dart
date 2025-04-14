import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityCard2 extends StatelessWidget {
  CommunityCard2({super.key});
  final Color primaryColor = const Color(0xFF4C9A2A);
  final Color tagColor = Color(0xFFF9EEC1);
  
  void _joinCommunity() async {
  final Uri url = Uri.parse('https://chat.whatsapp.com/GUJ5Mj7O6JH1giAipSnfao');

  if (await canLaunchUrl(url)) {
    await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // Required to open WhatsApp or browser
    );
  } else {
    print('Could not launch $url');
    // Optional: show a snackbar or alert
  }
}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Member Count
            Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      child: Text(
        "Sunrise Farmers Co-op",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    ),
    const SizedBox(width: 8),
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: const [
          Icon(Icons.group, size: 18),
          SizedBox(width: 5),
          Text("8 Members"),
        ],
      ),
    )
  ],
),


            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text("Meadowville, CA"),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              "Co-operative focused on shared resources and collective marketing of farm products.",
              style: TextStyle(fontSize: 15),
            ),

            const SizedBox(height: 12),

            // Tags
            Row(
              children: [
                for (var label in ["Co-op", "Fruits", "Shared Equipment"])
                  Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: tagColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            // Next Event
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.green),
                  const SizedBox(width: 8),
                  RichText(
                    text: TextSpan(
                      text: "Next: ",
                      style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                      children: const [
                        TextSpan(
                          text: "Resource Sharing Meeting\n",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: "March 20, 2025",
                          style: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Members
            Row(
              children: [
                memberChip("EW", "Emma Wilson", online: true),
                const SizedBox(width: 12),
                memberChip("MB", "Michael"),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                memberChip("RJ", "Robert Johnson"),
                const SizedBox(width: 20),
                const CircleAvatar(
                  backgroundColor: Color(0xFFF0F3E7),
                  radius: 18,
                  child: Text("+5", style: TextStyle(color: Colors.black)),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Join Button
            Center(
              child: TextButton(
                onPressed: _joinCommunity,
                child:Text("Join Community",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                ),
                
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget memberChip(String initials, String name, {bool online = false}) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: primaryColor,
          child: Text(initials, style: const TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 8),
        Text(name, style: const TextStyle(fontSize: 16)),
        if (online)
          const Padding(
            padding: EdgeInsets.only(left: 4),
            child: Icon(Icons.circle, color: Colors.green, size: 10),
          )
      ],
    );
  }
}