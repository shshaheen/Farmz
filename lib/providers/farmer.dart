import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:farmz/models/farmer_auth.dart';

class FarmerProvider extends StateNotifier<FarmerAuth?> {
  // constructor initializing with the default User Object
  // Purpose: Manage the state of the user object allowing updates
  FarmerProvider() : super(null);
  // Getter method to extract value from an object
  FarmerAuth? get user => state;

  //method to set user state from Json
  //purpose : updates the user state based on json string representation of user object
  void setUser(String userJson) {
    state = FarmerAuth.fromJson(userJson);
  }

  //Method to clear user state
  void signOut() {
    state = null;
  }

  
}

// make the data accessible within the application
final farmerProvider =
    StateNotifierProvider<FarmerProvider, FarmerAuth?>((ref) => FarmerProvider());
