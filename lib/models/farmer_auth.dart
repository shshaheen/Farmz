// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FarmerAuth {
  // Define Fields
  final String id;
  final String username;
  final String email;
  final String village;
  final String password;
  final String token;

  FarmerAuth({
    required this.id, 
    required this.username, 
    required this.email, 
    required this.village, 
    required this.password, 
    required this.token
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'village': village,
      'password': password,
      'token': token,
    };
  }

  factory FarmerAuth.fromMap(Map<String, dynamic> map) {
    return FarmerAuth(
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      village: map['village'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FarmerAuth.fromJson(String source) => 
    FarmerAuth.fromMap(json.decode(source) as Map<String, dynamic>);
}
