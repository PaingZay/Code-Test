import 'package:interview_test/features/auth/data/models/user_session.dart';

class ResponseModel {
  final bool success;
  final UserSessionModel? data;
  final String message;
  final DateTime timestamp;

  ResponseModel({
    required this.success,
    this.data,
    required this.message,
    required this.timestamp,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      success: json['success'],
      data:
          json['data'] != null ? UserSessionModel.fromJson(json['data']) : null,
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(), // Use null-aware operator
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
