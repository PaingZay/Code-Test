import 'dart:convert';
import 'package:interview_test/core/enum.dart';
import 'package:interview_test/core/api_service.dart';
import 'package:interview_test/features/home/data/models/pickup_data_model.dart';
import 'package:interview_test/features/home/data/models/pickup_response.dart';

class PickupDataSource {
  final ApiService _apiService;

  PickupDataSource(this._apiService);

  static const String baseUrl = 'https://dev.gigagates.com/qq-delivery-backend';

  Future<PickupDataModel?> getPickupData({
    required int first,
    required int max,
    required String accessToken,
  }) async {
    final url = '$baseUrl/v4/pickup/list';
    final body = {'first': first, 'max': max};

    final response = await _apiService.apiCall(
      url: url,
      method: HttpMethod.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      String decodedResponse = utf8.decode(response.bodyBytes);

      final data = jsonDecode(decodedResponse);

      final pickupListResponse = PickupResponse.fromJson(data);

      if (pickupListResponse.success) {
        return pickupListResponse.data;
      } else {
        throw Exception('Error: ${pickupListResponse.message}');
      }
    } else {
      throw Exception('Failed to request new access token: ${response.body}');
    }
  }
}
