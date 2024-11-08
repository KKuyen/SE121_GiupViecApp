import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/data/models/response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(
      String name, String email, String password, String phoneNumber);
  Future<ResponseModel> editProfile(
      int userId, String name, String email, String phoneNumber, String avatar);
  Future<ResponseModel> sendOTP(String phoneNumber);
  Future<ResponseModel> verifyOTP(String phoneNumber, String otp);
  Future<ResponseModel> forgetPassword(String phoneNumber, String newPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  AuthRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/login'),
        body: json.encode({
          'phoneNumber': email,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );
    } on SocketException {
      // Handle network errors
      print("No Internet connection");
      throw Exception('No Internet connection');
    } on HttpException {
      // Handle HTTP errors
      print("HTTP error occurred");
      throw Exception('HTTP error occurred');
    } on FormatException {
      // Handle JSON format errors
      print("Bad response format");
      throw Exception('Bad response format');
    } catch (e) {
      // Handle any other exceptions
      print("Unexpected error: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to login');
    }
  }

  @override
  Future<UserModel> register(
      String name, String email, String password, String phoneNumber) async {
    final response = await client.post(
      Uri.parse('$baseUrl/$apiVersion/register'),
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'role': 'R1',
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }

  @override
  Future<ResponseModel> editProfile(int userId, String name, String email,
      String phoneNumber, String avatar) async {
    final response = await client.put(
      Uri.parse('$baseUrl/$apiVersion/edit-user-profile'),
      body: json.encode({
        'userId': userId,
        'name': name,
        'email': email,
        'phoneNumber': phoneNumber,
        'avatar': avatar,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjUsInBob25lTnVtYmVyIjoiMDM0NTY2NDAyNSIsInJvbGUiOiJSMSIsImV4cGlyZXNJbiI6IjMwZCIsImlhdCI6MTcyODIyMzI3N30.HPD25AZolhKCteXhFbF34zMyh2oewByvVHKBrFfET88'
      },
    );

    if (response.statusCode == 200) {
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to edit profile');
    }
  }

  @override
  Future<ResponseModel> sendOTP(String phoneNumber) async {
    final response = await client.post(
      Uri.parse('$baseUrl/$apiVersion/send-otp'),
      body: json.encode({
        'phoneNumber': phoneNumber,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to send OTP');
    }
  }

  @override
  Future<ResponseModel> verifyOTP(String phoneNumber, String otp) async {
    final response = await client.post(
      Uri.parse('$baseUrl/$apiVersion/verify-otp'),
      body: json.encode({
        'phoneNumber': phoneNumber,
        'otp': otp,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to verify OTP');
    }
  }

  @override
  Future<ResponseModel> forgetPassword(
      String phoneNumber, String newPassword) async {
    final response = await client.put(
      Uri.parse('$baseUrl/$apiVersion/forget-password'),
      body: json.encode({
        'phoneNumber': phoneNumber,
        'newPassword': newPassword,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to change password');
    }
  }
}
