import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';

import 'package:se121_giupviec_app/data/models/taskerInfo_model.dart';

abstract class TaskerRemoteDatasource {
  Future<TaskerInfoModel> getATasker(int userId, int taskerId);
}

class TaskerRemoteDataSourceImpl implements TaskerRemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  TaskerRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });

  @override
  Future<TaskerInfoModel> getATasker(int userId, int taskerId) async {
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-tasker-info'),
        body: json.encode({
          "userId": userId,
          'taskerId': taskerId,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': AppInfor1.user_token
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
      final dynamic taskerJson = json.decode(response.body);

      print("tasker: $taskerJson");
      return TaskerInfoModel.fromJson(taskerJson);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }
}
