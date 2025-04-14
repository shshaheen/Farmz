// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ConsumerAuth {
  final String id;
  final String username;
  final String email;
  final String village;
  final String password;
  final String token;

  ConsumerAuth({
    required this.id,
    required this.username,
    required this.email,
    required this.village,
    required this.password,
    required this.token,
  });

  // Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'village': village,
      'password': password,
      'token': token,
    };
  }

  // Convert from Map
  factory ConsumerAuth.fromMap(Map<String, dynamic> map) {
    return ConsumerAuth(
      id: map['_id'] ?? map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      village: map['village'] ?? '',
      password: map['password'] ?? '', // Usually omit password in responses
      token: map['token'] ?? '',
    );
  }

  // Convert to JSON String
  String toJson() => json.encode(toMap());

  // Convert from JSON String
  factory ConsumerAuth.fromJson(String source) =>
      ConsumerAuth.fromMap(json.decode(source));
}
