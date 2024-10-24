import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(
      String fullName, String email, String password, String phone);
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
      String fullName, String email, String password, String phone) async {
    final response = await client.post(
      Uri.parse('$baseUrl/$apiVersion/register'),
      body: json.encode({
        'fullName': fullName,
        'email': email,
        'password': password,
        'phone': phone,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to register');
    }
  }
}
