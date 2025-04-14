import 'package:farmz/Views/Screens/authentiaciton/consumer_signup_screen.dart';
import 'package:farmz/Views/Screens/authentiaciton/farmer_signup_screen.dart';
import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 120),
                const Center(
                  child: Text(
                    "Hey there!",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                      fontFamily: 'Cursive',
                    ),
                  ),
                ),
                const SizedBox(height: 200),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to Farmer screen
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const FarmerSignupScreen();
                          }));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "I AM A FARMER",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return  ConsumerSignupScreen();
                          }));
                          // Navigate to Consumer screen
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "I AM A CONSUMER",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),

            // Right side top illustration (e.g., sugarcane)
            Positioned(
              right: 10,
              top: 280,
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  'assets/images/sugarcane.png',
                  height: 120,
                ),
              ),
            ),

            // Bottom left cart image
            Positioned(
              bottom: 20,
              child: IgnorePointer(
                child: Image.asset(
                  'assets/images/cart1.png',
                  height: 300,
                  width: 350,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
