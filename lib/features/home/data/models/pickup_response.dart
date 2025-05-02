import 'package:interview_test/features/home/data/models/pickup_data_model.dart';

class PickupResponse {
  final bool success;
  final PickupDataModel data;
  final String message;

  PickupResponse({
    required this.success,
    required this.data,
    required this.message,
  });

  factory PickupResponse.fromJson(Map<String, dynamic> json) {
    return PickupResponse(
      success: json['success'],
      data: PickupDataModel.fromJson(json['data']),
      message: json['message'],
    );
  }
}
