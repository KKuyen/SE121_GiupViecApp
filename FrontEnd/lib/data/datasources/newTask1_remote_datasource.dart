import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:se121_giupviec_app/common/helpers/SecureStorage.dart';
import 'package:se121_giupviec_app/core/configs/constants/app_infor1.dart';
import 'package:se121_giupviec_app/data/models/location_model.dart';
import 'package:se121_giupviec_app/data/models/taskType_model.dart';
import 'package:se121_giupviec_app/data/models/voucher_model.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class NewTask1RemoteDatasource {
  Future<TasktypeModel> getAtTaskType(int taskTypeId);
  Future<void> createTask(
      int userId,
      int taskTypeId,
      DateTime time,
      int locationId,
      String note,
      int myvoucherId,
      int voucherId,
      String paymentMethod,
      List<Map<String, dynamic>> addPriceDetail);
  Future<List<LocationModel>> getMyLocation(int userId);
  Future<LocationModel?> getMyDefaultLocation(int userId);
  Future<List<VoucherModel>> getAvailableVoucherList(
      int userId, int taskTypeId);
}

Future<String> getToken() async {
  return await SecureStorage().readAccess_token();
}

class NewTask1RemoteDatasourceImpl implements NewTask1RemoteDatasource {
  final http.Client client;
  final String baseUrl;
  final String apiVersion;

  NewTask1RemoteDatasourceImpl({
    required this.client,
    required this.baseUrl,
    required this.apiVersion,
  });
  @override
  Future<LocationModel?> getMyDefaultLocation(int userId) async {
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
      print(responseBody);
      return LocationModel.fromJson(responseBody['location']);
    } else {
      return null;
    }
  }

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
      print(LocationListJson);
      return LocationListJson.map((json) => LocationModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<TasktypeModel> getAtTaskType(int taskTypeId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final http.Response response;
    try {
      response = await client.post(
        Uri.parse('$baseUrl/$apiVersion/get-a-task-type'),
        body: json.encode({
          'taskTypeId': taskTypeId,
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
      final dynamic taskerJson = json.decode(response.body)['TaskType'];

      print("tasker: $taskerJson");
      return TasktypeModel.fromJson(taskerJson);
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed ');
    }
  }

  @override
  Future<void> createTask(
    int userId,
    int taskTypeId,
    DateTime time,
    int locationId,
    String note,
    int myvoucherId,
    int voucherId,
    String paymentMethod,
    List<Map<String, dynamic>> addPriceDetail,
  ) async {
    String token = await getToken();
    token = 'Bearer $token';
    print('paymentMethod: $paymentMethod');
    final response = await client.post(
      Uri.parse('$baseUrl/$apiVersion/create-new-task'),
      body: json.encode({
        'userId': userId,
        'taskTypeId': taskTypeId,
        'time': time.toIso8601String(),
        'locationId': locationId,
        'note': note,
        'addPriceDetail': addPriceDetail,
        'myvoucherId': myvoucherId,
        'voucherId': voucherId,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );
    if (paymentMethod.contains("momo")) {
      print('paymentMethodddd: $paymentMethod');
      try {
        final paymentResult = await client.post(
          Uri.parse('$baseUrl/payment'),
          body: json.encode({
            "money": json.decode(response.body)['price'].split(' ')[0],
            "taskId": json.decode(response.body)['id'] + 9999,
          }),
          headers: {
            'Content-Type': 'application/json',
          },
        );
        final Map<String, dynamic> paymentResultJson =
            json.decode(paymentResult.body);
        final String paymentUrl = paymentResultJson['payUrl'];
        print('paymentUrl: $paymentUrl');
        print('paymentResult: $paymentResultJson');
        if (await canLaunch(paymentUrl)) {
          await launch(paymentUrl);
        } else {
          throw 'Could not launch $paymentUrl';
        }
      } on Exception catch (e) {
        print('error: $e');
        // TODO
      }
    }

    if (response.statusCode == 201) {
      print('thanh cong');
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to create task');
    }
  }

  @override
  Future<List<VoucherModel>> getAvailableVoucherList(
      int userId, int taskTypeId) async {
    String token = await getToken();
    token = 'Bearer $token';
    final response = await client.post(
      Uri.parse('$baseUrl/$apiVersion/get-avaiable-voucher'),
      body: json.encode({
        'userId': userId,
        'taskTypeId': taskTypeId,
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': token,
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> voucherListJson =
          json.decode(response.body)['availableVouchers'];
      print("avalable vourchers");
      print(voucherListJson);
      return voucherListJson
          .map((json) => VoucherModel.fromJson(json))
          .toList();
    } else {
      print("response.body failed: ${response.body}");
      throw Exception('Failed to create task');
    }
  }
}
