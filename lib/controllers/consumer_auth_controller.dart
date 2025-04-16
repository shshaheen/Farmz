import 'package:farmz/Views/Screens/authentiaciton/consumer_login_screen.dart';
import 'package:farmz/Views/Screens/consumer/consumer_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/consumer_auth.dart';
import '../services/manage_http_response.dart';
import '../global_variables.dart';
import '../providers/consumer.dart';

final providerContainer = ProviderContainer();

class ConsumerAuthController {
  // Sign Up Method
  Future<void> signUpUsers({
    required  context,
    required String username,
    required String email,
    required String village,
    required String password,
  }) async {
    try {
      ConsumerAuth user = ConsumerAuth(
        id: '',
        username: username,
        email: email,
        village: village,
        password: password,
        token: '', 
        
      );

      http.Response response = await http.post(
        Uri.parse('$uri/api/consumer/signup'),
        body: user.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ConsumerLoginScreen()));
          showSnackBar(context, 'Account created successfully.');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Sign In Method
  Future<void> signInUsers({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/consumer/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String token = jsonDecode(response.body)['token'];
          await preferences.setString('consumer_auth_token', token);

          final consumerData = jsonDecode(response.body)['consumer'];
          if (consumerData != null) {
            final userJson = jsonEncode(consumerData);
            providerContainer
                .read(consumerProvider.notifier)
                .setUser(userJson);
            await preferences.setString('consumer', userJson);
          } else {
            showSnackBar(context, 'Login failed: User data missing.');
            return;
          }

          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => ConsumerHomePage()),
              (route) => false);
          showSnackBar(context, 'Logged In');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Sign Out Method
  Future<void> signOutUsers({required BuildContext context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('consumer_auth_token');
      await preferences.remove('consumer');

      providerContainer.read(consumerProvider.notifier).signOut();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => ConsumerLoginScreen()),
          (route) => false);
      showSnackBar(context, 'Signed out successfully.');
    } catch (e) {
      showSnackBar(context, 'Error Signing out.');
    }
  }
}
