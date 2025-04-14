// import 'package:farmz/Views/Screens/role_selection_screen.dart';
import 'package:farmz/Views/Screens/Farmer/farmer_home_page.dart';
import 'package:farmz/Views/Screens/welcome_page.dart';
import 'package:farmz/providers/farmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

var kLightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(184, 235, 208, 1), 
);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromRGBO(53, 114, 102, 1),
);
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // Method to check the token and set the user data if available
  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    // obtain an instance of sharedPreference for local data storage
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // Retrive the authenticaion token and user data stored locally
    String? token = preferences.getString('farmer_auth_token');
    String? userJson = preferences.getString('farmers');

    // If both token and user data are available, update the user state
    if (token != null && userJson != null) {
      ref.read(farmerProvider.notifier).setUser(userJson);
    } else {
      ref.read(farmerProvider.notifier).signOut();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: kLightColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kLightColorScheme.primary,
          foregroundColor: kLightColorScheme.onPrimary,
        ),
        cardTheme: CardTheme(
          color: kLightColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kLightColorScheme.primary,
            foregroundColor: kLightColorScheme.onPrimary,
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        appBarTheme: AppBarTheme(
          backgroundColor: kDarkColorScheme.inversePrimary,
          foregroundColor: kDarkColorScheme.onPrimary,
        ),
        cardTheme: CardTheme(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primary,
            foregroundColor: kDarkColorScheme.onPrimary,
          ),
        ),
      ),
      home: FutureBuilder(
        future: _checkTokenAndSetUser(ref), // Ensure to await this completely
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          // Check if the user is logged in
          final user = ref.watch(farmerProvider);

          // If user data is found, navigate to the farmer home page, otherwise show WelcomePage
          return user != null ? FarmerHomePage() : WelcomePage();
        },
      ),
    );
  }
}
