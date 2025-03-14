import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/data/models/review_model.dart';

abstract class AllReviewRemoteDatasource {
  Future<List<ReviewModel>> getAllReviews(int taskerId);
  Future<ReviewModel> getAReviews(int taskerId, int taskId);
}

Future<String> getToken() async {
  return await SecureStorage().readAccess_token();
}

class AllReviewRemoteDatasourceImpl implements AllReviewRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  AllReviewRemoteDatasourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });

  @override
  Future<List<ReviewModel>> getAllReviews(int taskerId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-all-reviews'),
        body: json.encode({
          'taskerId': taskerId,
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
      print("Unexpected error: $e");
      throw Exception('Unexpected error: $e');
    }
    if (response.statusCode == 200) {
      final List<dynamic> taskListJson =
          json.decode(response.body)['reviewList'];
      print('--------------------------------------');
      print(taskListJson);
      return taskListJson.map((json) => ReviewModel.fromJson(json)).toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<ReviewModel> getAReviews(int taskerId, int taskId) async {
    String token = await getToken();
    token = 'Bearer $token';

    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-a-review'),
        body: json.encode({'taskerId': taskerId, 'taskId': taskId}),
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
      print("Unexpected error: $e");
      throw Exception('Unexpected error: $e');
    }
    if (response.statusCode == 200) {
      final dynamic reviewJson = json.decode(response.body)['review'];
      print('--------------------------------------');
      print(reviewJson);
      return ReviewModel.fromJson(reviewJson);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }
}
