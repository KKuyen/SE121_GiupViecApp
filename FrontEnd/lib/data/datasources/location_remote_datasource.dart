import 'dart:convert';
import 'dart:io';

import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';

import '../models/location_model.dart';
import 'package:http/http.dart' as http;

import '../models/response_model.dart';

abstract class LocationRemoteDatasource {
  Future<List<LocationModel>> getMyLocation(int userId);
  Future<LocationModel> getMyDefaultLocation(int userId);
  Future<ResponseModel> addNewLocation(
      String? ownerName,
      String? ownerPhoneNumber,
      String country,
      String province,
      String district,
      String detailAddress,
      String map,
      int userId,
      bool isDefault);
  Future<ResponseModel> deleteLocation(int id);
}

Future<String> getToken() async {
  return await SecureStorage().readAccess_token();
}

class LocationRemoteDatasourceImpl implements LocationRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  LocationRemoteDatasourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });

  @override
  Future<List<LocationModel>> getMyLocation(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final uri = Uri.parse('$baseUrl/$apiVersion/get-my-location').replace(
        queryParameters: {
          'userId': userId.toString(),
        },
      );
      response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );
      print("response: ${response.body}");
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
      print("Unexpected errorrrrrrrr: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final List<dynamic> LocationListJson =
          json.decode(response.body)['locations'];
      return LocationListJson.map((json) => LocationModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<LocationModel> getMyDefaultLocation(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      final uri =
          Uri.parse('$baseUrl/$apiVersion/get-my-default-location').replace(
        queryParameters: {
          'userId': userId.toString(),
        },
      );
      response = await client.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
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
      print("Unexpected errorrrrrrrr: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return LocationModel.fromJson(responseBody['location']);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<ResponseModel> addNewLocation(
      String? ownerName,
      String? ownerPhoneNumber,
      String country,
      String province,
      String district,
      String detailAddress,
      String map,
      int userId,
      bool isDefault) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;

    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/add-new-location'),
        body: json.encode({
          'ownerName': ownerName,
          'ownerPhoneNumber': ownerPhoneNumber,
          'country': country,
          'province': province,
          'district': district,
          'detailAddress': detailAddress,
          'map': map,
          'userId': userId,
          'isDefault': isDefault,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
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
      print("Unexpected errorrrrrrrr: $e");
      throw Exception('Unexpected error: $e');
    }

    if (response.statusCode == 200) {
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add location');
    }
  }

  @override
  Future<ResponseModel> deleteLocation(int id) async {
    String token = await getToken();
    token = 'Bearer $token';
    final uri = Uri.parse('$baseUrl/$apiVersion/delete-my-location').replace(
      queryParameters: {
        'id': id.toString(),
      },
    );
    try {
      final response = await client.delete(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': token,
        },
      );

      if (response.statusCode == 200) {
        return ResponseModel.fromJson(json.decode(response.body));
      } else {
        print("response.body failed: ${response.body}");
        throw Exception('Failed to delete location');
      }
    } catch (e) {
      print("Unexpected error: $e");
      throw Exception('Unexpected error: $e');
    }
  }
}
