import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/data/models/notification_model.dart';
import 'package:se121_giupviec_app/data/models/review_model.dart';
import 'package:se121_giupviec_app/domain/entities/notification.dart';

abstract class AllNotificationRemoteDatasource {
  Future<List<Notification>> getAllNotication(int userId);
  Future<void> deleteANotification(int notificationId);
  Future<void> addANotification(
      int userId, String header, String content, String image);
}

class AllNotificationRemoteDatasourceImpl
    implements AllNotificationRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  AllNotificationRemoteDatasourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });
  @override
  Future<void> addANotification(
      int userId, String header, String content, String image) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/push-notification'),
        body: json.encode({
          'userId': userId,
          'header': header,
          'content': content,
          'image': image,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.tasker_token
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
      print('--------------------------------------');
      print(response.body);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<List<Notification>> getAllNotication(int userId) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-notification'),
        body: json.encode({
          'userId': userId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.tasker_token
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
          json.decode(response.body)['notificationList'];
      print('--------------------------------------');
      print(taskListJson);
      return taskListJson
          .map((json) => NotificationModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<void> deleteANotification(int notificationId) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/delete-notification'),
        body: json.encode({
          'notificationId': notificationId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.tasker_token
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
      print('--------------------------------------');
      print(response.body);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }
}
