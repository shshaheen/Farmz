import 'package:farmz/Views/Screens/Farmer/farmer_home_page.dart';
import 'package:farmz/providers/farmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:farmz/Views/Screens/authentiaciton/farmer_login_screen.dart';
import 'package:farmz/services/manage_http_response.dart';
import 'dart:convert';
import '../models/farmer_auth.dart';
import 'package:http/http.dart' as http;
import '../global_variables.dart';

final providerContainer = ProviderContainer();

class FarmerAuthController {
  Future<void> signUpUsers(
      {required context,
      required String username,
      required String email,
      required String village,
      required String password}) async {
    try {
      FarmerAuth user = FarmerAuth(
          id: '',
          username: username,
          email: email,
          village: village,
          password: password,
          token: '');
      http.Response response = await http.post(
        Uri.parse('$uri/api/farmer/signup'),
        body: user
            .toJson(), //Convert the user object to json for the request body
        headers: <String, String>{
          "Content-Type":
              "application/json; charset=UTF-8", // specify the content type as Json
        }, // Set the Headers for the request body
      );
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => FarmerLoginScreen()));
            showSnackBar(context, 'Account has been created for you.');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> signInUsers(
      {required context,
      required String email,
      required String password}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/farmer/signin'),
        body: jsonEncode(
          {
            'email': email, // include the email in the request body,
            'password': password, // include the password in the request body
          },
        ), //Convert the user object to json for the request body
        headers: <String, String>{
          // this will set the header
          "Content-Type":
              "application/json; charset=UTF-8", // specify the content type as Json
        }, // Set the Headers for the request body
      );
      print(response.body);
      // Handle the response using the manage_http_response
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async {
            // Access sharedPreferences for token and user data storage
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            //Extract the authentication token from the response body
            String token = jsonDecode(response.body)['token'];

            // Store the authentication token securely in sharedPreferences

            await preferences.setString('farmer_auth_token', token);

            // Encode the user data received from the backend as JSON
            final farmersData = jsonDecode(response.body)['farmer'];

            if (farmersData != null) {
              final userJson = jsonEncode(farmersData);
              providerContainer.read(farmerProvider.notifier).setUser(userJson);
              await preferences.setString('farmers', userJson);
            } else {
              showSnackBar(context, 'Login failed: User data missing.');
            }

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => FarmerHomePage()),
                (route) => false);
            showSnackBar(context, 'Logged In');
          });
    } catch (e) {
      // print("Error:  $e");
      showSnackBar(context, e.toString());
    }
  }

  //SignOut
  Future<void> signOutUsers({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // Clear the stored token and user from SharedPreference
      await preferences.remove('auth_token');
      await preferences.remove('user');
      // Clear the user state
      providerContainer.read(farmerProvider.notifier).signOut();
      //Navigate the user back to the login screen
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => FarmerLoginScreen()),
          (route) => false);
      showSnackBar(context, 'Signout successfully');
    } catch (e) {
      showSnackBar(context, 'Error Signing out');
    }
  }
}
