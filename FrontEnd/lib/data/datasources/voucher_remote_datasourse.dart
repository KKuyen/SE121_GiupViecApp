import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';

import '../models/response_model.dart';
import '../models/voucher_model.dart';

abstract class VoucherRemoteDatasource {
  Future<List<VoucherModel>> getAllVoucher();
  Future<ResponseModel> claimVoucher(int userId, int voucherId);
  Future<List<VoucherModel>> getMyVoucher(int userId);
  Future<ResponseModel> deleteMyVoucher(int userId, int voucherId);
}

Future<String> getToken() async {
  return await SecureStorage().readAccess_token();
}

class VoucherRemoteDatasourceImpl implements VoucherRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  VoucherRemoteDatasourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });

  @override
  Future<List<VoucherModel>> getAllVoucher() async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-voucher'),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
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
      final List<dynamic> voucherListJson =
          json.decode(response.body)['voucherList'];
      return voucherListJson
          .map((json) => VoucherModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<ResponseModel> claimVoucher(int userId, int voucherId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      print("userId: $userId, voucherId: $voucherId");
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/claim-voucher'),
        body: json.encode({
          'userId': userId.toString(),
          'voucherId': voucherId.toString(),
        }),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
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
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to claim voucher');
    }
  }

  @override
  Future<List<VoucherModel>> getMyVoucher(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      print("userId: $userId");
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-my-voucher'),
        body: json.encode({
          'userId': userId.toString(),
        }),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
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
      final List<dynamic> voucherListJson =
          json.decode(response.body)['voucherList'];
      return voucherListJson
          .map((json) => VoucherModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<ResponseModel> deleteMyVoucher(int userId, int voucherId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/delete-my-voucher'),
        body: json.encode({
          'userId': userId.toString(),
          'voucherId': voucherId.toString(),
        }),
        headers: {'Content-Type': 'application/json', 'Authorization': token},
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
      return ResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to delete voucher');
    }
  }
}
