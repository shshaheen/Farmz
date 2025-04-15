import 'package:farmz/Views/Screens/Farmer/farmer_home_page.dart';
import 'package:farmz/Views/Screens/consumer/consumer_home_page.dart';
import 'package:farmz/Views/Screens/welcome_page.dart';
import 'package:farmz/providers/farmer.dart';
import 'package:farmz/providers/consumer.dart';
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

  // Check both consumer and farmer token and set user accordingly
  Future<String> _checkTokenAndSetUser(WidgetRef ref) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? farmerToken = preferences.getString('farmer_auth_token');
    String? farmerJson = preferences.getString('farmers');

    String? consumerToken = preferences.getString('consumer_auth_token');
    String? consumerJson = preferences.getString('consumer');

    if (farmerToken != null && farmerJson != null) {
      ref.read(farmerProvider.notifier).setUser(farmerJson);
      return 'farmer';
    } else if (consumerToken != null && consumerJson != null) {
      ref.read(consumerProvider.notifier).setUser(consumerJson);
      return 'consumer';
    } else {
      ref.read(farmerProvider.notifier).signOut();
      ref.read(consumerProvider.notifier).signOut();
      return 'none';
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
        future: _checkTokenAndSetUser(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            final userType = snapshot.data as String;
            if (userType == 'farmer') {
              return FarmerHomePage();
            } else if (userType == 'consumer') {
              return ConsumerHomePage();
            }
          }

          return WelcomePage();
        },
      ),
    );
  }
}
