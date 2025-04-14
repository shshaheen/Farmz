import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:farmz/models/consumer_auth.dart';

class ConsumerProvider extends StateNotifier<ConsumerAuth?> {
  // Constructor initializing with the default Consumer object
  ConsumerProvider() : super(null);

  // Getter method to access the current consumer
  ConsumerAuth? get user => state;

  // Method to set user state from JSON string
  void setUser(String userJson) {
    state = ConsumerAuth.fromJson(userJson);
  }

  // Method to clear user state (sign out)
  void signOut() {
    state = null;
  }
}

// Make the data accessible within the application
final consumerProvider =
    StateNotifierProvider<ConsumerProvider, ConsumerAuth?>((ref) => ConsumerProvider());
