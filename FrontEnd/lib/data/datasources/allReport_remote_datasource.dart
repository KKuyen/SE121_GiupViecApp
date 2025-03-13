import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';

import 'package:se121_giupviec_app/data/models/Complaint.dart';
import 'package:se121_giupviec_app/domain/entities/complaint.dart';

abstract class ReportRemoteDatasource {
  Future<List<Complaint>> getAllReport(int userId);
  Future<Complaint> getAReport(int ComplaintId);
  Future<Complaint> createReport(int taskId, String type, String description,
      int customerId, int taskerId);
}

Future<String> getToken() async {
  return await SecureStorage().readAccess_token();
}

class ReportRemoteDatasourceImpl implements ReportRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  ReportRemoteDatasourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });

  @override
  Future<List<Complaint>> getAllReport(int userId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-complaints-by-userId'),
        body: json.encode({
          'userId': userId,
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
      final List<dynamic> taskListJson =
          json.decode(response.body)['complaints'];
      print('--------------------------------------');
      print(taskListJson);
      return taskListJson.map((json) => ComplaintModel.fromJson(json)).toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<Complaint> getAReport(int complaintId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse(
            '$baseUrl/$apiVersion/get-a-complaint?complaintId=$complaintId'),
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
      final Map<String, dynamic> responseBody = json.decode(response.body);
      print(responseBody);
      final Map<String, dynamic> report = responseBody['complaint'];
      print(report);
      final ComplaintModel complaintModel = ComplaintModel.fromJson(report);
      return complaintModel;
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<Complaint> createReport(int taskId, String type, String description,
      int customerId, int taskerId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/create-complaint'),
        body: json.encode({
          'taskId': taskId,
          'type': type,
          'description': description,
          'customerId': customerId,
          'taskerId': taskerId,
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
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      print(responseBody);
      final ComplaintModel complaintModel =
          ComplaintModel.fromJson(responseBody['complaint']);
      return complaintModel;
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to create complaint');
    }
  }
}
